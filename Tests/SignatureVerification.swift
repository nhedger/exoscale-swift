import Crypto
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Testing

/// Parses a query the way Go's `net/url` does: `+` is a space and pairs containing `;` are dropped.
func formDecodedQuery(of url: URL) throws -> [String: String] {
    func decode(_ component: Substring) throws -> String {
        try #require(component.replacingOccurrences(of: "+", with: " ").removingPercentEncoding)
    }

    let query = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false)).percentEncodedQuery ?? ""
    var values: [String: String] = [:]
    for pair in query.split(separator: "&") where !pair.contains(";") {
        let parts = pair.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
        try values[decode(parts[0])] = try parts.count > 1 ? decode(parts[1]) : ""
    }
    return values
}

/// Recomputes the EXO2-HMAC-SHA256 signature from the request as the API receives it.
func hasValidSignature(_ request: URLRequest, secret: String) throws -> Bool {
    let url = try #require(request.url)
    let authorization = try #require(request.value(forHTTPHeaderField: "Authorization"))
    var fields: [String: String] = [:]
    for field in authorization.dropFirst("EXO2-HMAC-SHA256 ".count).split(separator: ",") {
        let parts = field.split(separator: "=", maxSplits: 1)
        fields[String(parts[0])] = String(parts[1])
    }

    let query = try formDecodedQuery(of: url)
    let signedValues = try (fields["signed-query-args"]?.split(separator: ";") ?? [])
        .map { try #require(query[String($0)]) }
        .joined()
    let path = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false)).percentEncodedPath
    let message = try [
        "\(request.httpMethod ?? "GET") \(path)",
        #require(String(bytes: request.httpBody ?? Data(), encoding: .utf8)),
        signedValues,
        "",
        #require(fields["expires"])
    ].joined(separator: "\n")
    let code = HMAC<SHA256>.authenticationCode(for: Data(message.utf8), using: SymmetricKey(data: Data(secret.utf8)))
    return Data(code).base64EncodedString() == fields["signature"]
}
