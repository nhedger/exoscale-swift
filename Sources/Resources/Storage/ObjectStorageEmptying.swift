import Crypto
import Foundation
#if canImport(FoundationXML)
    import FoundationXML
#endif

public extension Exoscale.ObjectStorage {
    /// Deletes every object of a bucket of the client's zone, with all their versions and delete
    /// markers, so the bucket can then be deleted. Objects are deleted 1,000 at a time.
    ///
    /// - Returns: How many object versions and delete markers were deleted.
    @discardableResult
    func emptyBucket(_ name: String) async throws -> Int {
        var deleted = 0
        // Each page lists what remains, since what was listed before is deleted.
        while true {
            let page = try await objectVersions(in: name)
            if !page.versions.isEmpty {
                try await deleteObjects(page.versions, from: name)
                deleted += page.versions.count
            }
            guard page.isTruncated else { return deleted }
        }
    }

    /// The first 1,000 object versions and delete markers of a bucket.
    internal func objectVersions(in bucket: String) async throws -> S3VersionsPage {
        let data = try await s3.send(.get, bucket: bucket, query: ["versions": "", "max-keys": "1000"])
        return try S3VersionsPage(data)
    }

    /// Deletes up to 1,000 object versions in one request.
    internal func deleteObjects(_ versions: [S3ObjectVersion], from bucket: String) async throws {
        let objects = versions.map { version in
            "<Object><Key>\(Self.escapeXML(version.key))</Key>"
                + (version.versionID.map { "<VersionId>\(Self.escapeXML($0))</VersionId>" } ?? "")
                + "</Object>"
        }
        let body = Data("<Delete><Quiet>true</Quiet>\(objects.joined())</Delete>".utf8)
        let data = try await s3.send(.post, bucket: bucket, query: ["delete": ""], body: body, headers: [
            "Content-Type": "application/xml",
            "Content-MD5": Data(Insecure.MD5.hash(data: body)).base64EncodedString()
        ])
        // Objects that couldn't be deleted are reported in a successful response.
        let failure = Exoscale.S3Error(statusCode: 200, body: data)
        if failure.code != nil {
            throw failure
        }
    }

    private static func escapeXML(_ text: String) -> String {
        text.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&apos;")
    }
}

/// An object version or delete marker, as listed by `ListObjectVersions`.
struct S3ObjectVersion: Hashable, Sendable {
    var key: String
    /// `nil` for buckets that never had versioning, whose objects have the version `null`.
    var versionID: String?
}

/// A page of `ListObjectVersions`.
struct S3VersionsPage: Sendable {
    var versions: [S3ObjectVersion] = []
    var isTruncated = false

    init(_ data: Data) throws {
        let reader = Reader()
        let parser = XMLParser(data: data)
        parser.delegate = reader
        guard parser.parse() else {
            throw Exoscale.ClientError.invalidResponse
        }
        versions = reader.versions
        isTruncated = reader.isTruncated
    }

    /// Reads the `Version` and `DeleteMarker` entries, and whether more follow.
    private final class Reader: NSObject, XMLParserDelegate {
        var versions: [S3ObjectVersion] = []
        var isTruncated = false
        private var text = ""
        private var key: String?
        private var versionID: String?
        private var depth = 0

        func parser(
            _: XMLParser,
            didStartElement name: String,
            namespaceURI _: String?,
            qualifiedName _: String?,
            attributes _: [String: String] = [:]
        ) {
            text = ""
            if name == "Version" || name == "DeleteMarker" {
                key = nil
                versionID = nil
                depth += 1
            }
        }

        func parser(_: XMLParser, foundCharacters string: String) {
            text += string
        }

        func parser(_: XMLParser, didEndElement name: String, namespaceURI _: String?, qualifiedName _: String?) {
            switch name {
            case "Key" where depth > 0:
                key = text
            case "VersionId" where depth > 0:
                versionID = text == "null" ? nil : text
            case "Version", "DeleteMarker":
                if let key {
                    versions.append(S3ObjectVersion(key: key, versionID: versionID))
                }
                depth -= 1
            case "IsTruncated":
                isTruncated = text.trimmingCharacters(in: .whitespacesAndNewlines) == "true"
            default:
                break
            }
        }
    }
}
