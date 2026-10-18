import Foundation
#if canImport(FoundationXML)
    import FoundationXML
#endif

public extension Exoscale.ObjectStorage {
    /// How many objects a bucket of the client's zone holds, counting the latest version of each.
    ///
    /// Objects are listed 1,000 at a time, so counting a large bucket takes one request per
    /// 1,000 objects; `limit` stops counting once that many are found.
    ///
    /// - Returns: The count, and whether it is complete or stopped at `limit`.
    func objectCount(in bucket: String, limit: Int? = nil) async throws -> (count: Int, isComplete: Bool) {
        var count = 0
        var token: String?
        while true {
            var query = ["list-type": "2", "max-keys": "1000"]
            query["continuation-token"] = token
            let page = try await S3ObjectsPage(s3.send(.get, bucket: bucket, query: query))
            count += page.keyCount
            guard page.isTruncated, let next = page.nextToken else {
                return (count, true)
            }
            if let limit, count >= limit {
                return (count, false)
            }
            token = next
        }
    }
}

/// A page of `ListObjectsV2`: how many objects it lists, and how to get the next.
struct S3ObjectsPage: Sendable {
    var keyCount = 0
    var isTruncated = false
    var nextToken: String?

    init(_ data: Data) throws {
        let reader = Reader()
        let parser = XMLParser(data: data)
        parser.delegate = reader
        guard parser.parse() else {
            throw Exoscale.ClientError.invalidResponse
        }
        keyCount = reader.keyCount
        isTruncated = reader.isTruncated
        nextToken = reader.nextToken
    }

    private final class Reader: NSObject, XMLParserDelegate {
        var keyCount = 0
        var isTruncated = false
        var nextToken: String?
        private var text = ""

        func parser(
            _: XMLParser,
            didStartElement _: String,
            namespaceURI _: String?,
            qualifiedName _: String?,
            attributes _: [String: String] = [:]
        ) {
            text = ""
        }

        func parser(_: XMLParser, foundCharacters string: String) {
            text += string
        }

        func parser(_: XMLParser, didEndElement name: String, namespaceURI _: String?, qualifiedName _: String?) {
            let value = text.trimmingCharacters(in: .whitespacesAndNewlines)
            switch name {
            // Counted from the entries rather than KeyCount, which not every S3 implementation sends.
            case "Contents": keyCount += 1
            case "IsTruncated": isTruncated = value == "true"
            case "NextContinuationToken": nextToken = value.isEmpty ? nil : value
            default: break
            }
        }
    }
}
