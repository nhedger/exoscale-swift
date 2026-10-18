import Crypto
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Signs requests to Simple Object Storage (SOS) with AWS Signature Version 4, as its S3-compatible
/// API expects.
struct S3Signer: Sendable {
    let accessKey: String
    let secretKey: String
    /// The zone, which S3 calls the region.
    let region: String

    /// The hash of an empty body.
    static let emptyPayloadHash = hex(SHA256.hash(data: Data()))

    /// Returns `request` with its `x-amz-date`, `x-amz-content-sha256` and `Authorization` headers.
    /// The headers signed are `Host`, any `Range` and `Content-Type`, and every `x-amz-` header.
    func sign(_ request: URLRequest, now: Date = Date()) -> URLRequest {
        var signed = request
        // Requests are built from a valid base URL, so they always have a URL.
        let url = request.url!
        let (date, time) = Self.timestamps(now)
        let payloadHash = request.httpBody.map { Self.hex(SHA256.hash(data: $0)) } ?? Self.emptyPayloadHash
        signed.setValue(time, forHTTPHeaderField: "x-amz-date")
        signed.setValue(payloadHash, forHTTPHeaderField: "x-amz-content-sha256")

        var headers = ["host": Self.host(of: url)]
        for (name, value) in signed.allHTTPHeaderFields ?? [:] {
            let name = name.lowercased()
            if name.hasPrefix("x-amz-") || name == "range" || name == "content-type" {
                headers[name] = value.trimmingCharacters(in: .whitespaces)
            }
        }
        let names = headers.keys.sorted()
        let signedHeaders = names.joined(separator: ";")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let path = components?.percentEncodedPath ?? ""
        let query = (components?.percentEncodedQueryItems ?? [])
            .map { ($0.name, $0.value ?? "") }
            .sorted { $0 < $1 }
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
        let canonicalRequest = [
            request.httpMethod ?? "GET",
            path.isEmpty ? "/" : path,
            query,
            names.map { "\($0):\(headers[$0]!)\n" }.joined(),
            signedHeaders,
            payloadHash
        ].joined(separator: "\n")

        let scope = "\(date)/\(region)/s3/aws4_request"
        let stringToSign = [
            "AWS4-HMAC-SHA256",
            time,
            scope,
            Self.hex(SHA256.hash(data: Data(canonicalRequest.utf8)))
        ].joined(separator: "\n")

        var key = SymmetricKey(data: Data("AWS4\(secretKey)".utf8))
        for part in [date, region, "s3", "aws4_request"] {
            key = SymmetricKey(data: Data(HMAC<SHA256>.authenticationCode(for: Data(part.utf8), using: key)))
        }
        let signature = Self.hex(HMAC<SHA256>.authenticationCode(for: Data(stringToSign.utf8), using: key))

        signed.setValue(
            "AWS4-HMAC-SHA256 Credential=\(accessKey)/\(scope), SignedHeaders=\(signedHeaders), Signature=\(signature)",
            forHTTPHeaderField: "Authorization"
        )
        return signed
    }

    /// The host, with its port when it isn't the scheme's default.
    private static func host(of url: URL) -> String {
        let host = url.host ?? ""
        guard let port = url.port, port != (url.scheme == "http" ? 80 : 443) else { return host }
        return "\(host):\(port)"
    }

    /// The day, such as `20130524`, and the time, such as `20130524T000000Z`, in UTC.
    private static func timestamps(_ date: Date) -> (String, String) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let parts = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let day = String(format: "%04d%02d%02d", parts.year!, parts.month!, parts.day!)
        return (day, day + String(format: "T%02d%02d%02dZ", parts.hour!, parts.minute!, parts.second!))
    }

    private static func hex(_ bytes: some Sequence<UInt8>) -> String {
        bytes.map { String(format: "%02x", $0) }.joined()
    }
}

extension S3Signer: CustomReflectable {
    /// Keeps the secret out of `dump` output and debugger summaries.
    var customMirror: Mirror {
        Mirror(self, children: ["accessKey": accessKey, "secretKey": "<redacted>", "region": region])
    }
}
