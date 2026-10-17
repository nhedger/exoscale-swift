import Crypto
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Signs requests with Exoscale's `EXO2-HMAC-SHA256` scheme.
struct RequestSigner: Sendable {
    /// How long a signature stays valid.
    static let validity: TimeInterval = 600

    let apiKey: String
    let apiSecret: String

    /// Returns `request` with an `Authorization` header valid until ``validity`` after `now`.
    func sign(_ request: URLRequest, now: Date = Date()) -> URLRequest {
        // Requests are built from a valid base URL, so they always have a URL.
        let url = request.url!
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let expires = Int(now.addingTimeInterval(Self.validity).timeIntervalSince1970)

        // Repeated query parameters can't be signed, so only parameters present once are.
        let parameters = Dictionary(grouping: components?.queryItems ?? [], by: \.name)
            .filter { $0.value.count == 1 }
            .sorted { $0.key < $1.key }
        let path = components?.percentEncodedPath ?? url.path
        let message = [
            Data("\(request.httpMethod ?? "GET") \(path.isEmpty ? "/" : path)".utf8),
            request.httpBody ?? Data(),
            Data(parameters.map { $0.value[0].value ?? "" }.joined().utf8),
            Data(),
            Data(String(expires).utf8)
        ].joined(separator: [0x0A])

        let signature = HMAC<SHA256>.authenticationCode(
            for: Data(message),
            using: SymmetricKey(data: Data(apiSecret.utf8))
        )

        var authorization = ["EXO2-HMAC-SHA256 credential=\(apiKey)"]
        if !parameters.isEmpty {
            authorization.append("signed-query-args=\(parameters.map(\.key).joined(separator: ";"))")
        }
        authorization.append("expires=\(expires)")
        authorization.append("signature=\(Data(signature).base64EncodedString())")

        var signed = request
        signed.setValue(authorization.joined(separator: ","), forHTTPHeaderField: "Authorization")
        return signed
    }
}

extension RequestSigner: CustomReflectable {
    /// Keeps the secret out of `dump` output and debugger summaries.
    var customMirror: Mirror {
        Mirror(self, children: ["apiKey": apiKey, "apiSecret": "<redacted>"])
    }
}
