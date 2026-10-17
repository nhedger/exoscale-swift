import Crypto
@testable import Exoscale
import Foundation
import Testing
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// A response the stub sends back.
struct StubResponse: Sendable {
    var statusCode = 200
    var headers = ["Content-Type": "application/json"]
    var body = "{}"
}

/// Answers a client's requests with scripted responses, in order, and records what was sent.
///
/// Each stub has its own User-Agent, so tests running in parallel never share responses.
final class Stub: @unchecked Sendable {
    let id = UUID().uuidString
    let exoscale: Exoscale
    private let lock = NSLock()
    private var responses: [StubResponse]
    private var recorded: [URLRequest] = []

    init(_ responses: StubResponse...) throws {
        self.responses = responses
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [StubProtocol.self]
        exoscale = try Exoscale(
            configuration: .init(apiKey: "EXOkey", apiSecret: "secret", zone: .chGva2, userAgent: id),
            sessionConfiguration: configuration
        )
        Self.registry.withLock { $0[id] = self }
    }

    /// A stub answering every request with `body` and status 200.
    convenience init(json body: String) throws {
        try self.init(StubResponse(body: body))
    }

    /// The requests received so far, with their bodies.
    var requests: [URLRequest] {
        lock.withLock { recorded }
    }

    /// The only request received, failing the test if there were more or fewer.
    var request: URLRequest {
        get throws {
            let requests = requests
            guard requests.count == 1 else {
                throw StubError.unexpectedRequestCount(requests.count)
            }
            return requests[0]
        }
    }

    fileprivate func respond(to request: URLRequest) -> StubResponse {
        lock.withLock {
            recorded.append(request)
            return responses.count > 1 ? responses.removeFirst() : responses.first ?? StubResponse()
        }
    }

    fileprivate static let registry = Locked<[String: Stub]>([:])
}

enum StubError: Error {
    case unexpectedRequestCount(Int)
}

/// A value guarded by a lock.
final class Locked<Value>: @unchecked Sendable {
    private let lock = NSLock()
    private var value: Value

    init(_ value: Value) {
        self.value = value
    }

    func withLock<Result>(_ body: (inout Value) throws -> Result) rethrows -> Result {
        try lock.withLock { try body(&value) }
    }
}

private final class StubProtocol: URLProtocol {
    override static func canInit(with _: URLRequest) -> Bool {
        true
    }

    override static func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let url = request.url,
              let id = request.value(forHTTPHeaderField: "User-Agent"),
              let stub = Stub.registry.withLock({ $0[id] })
        else {
            client?.urlProtocol(self, didFailWithError: URLError(.unsupportedURL))
            return
        }
        let reply = stub.respond(to: requestWithBody())
        let response = HTTPURLResponse(
            url: url,
            statusCode: reply.statusCode,
            httpVersion: nil,
            headerFields: reply.headers
        )!
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: Data(reply.body.utf8))
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}

    /// URLSession hands bodies to protocols as streams, so they are read back for inspection.
    private func requestWithBody() -> URLRequest {
        guard request.httpBody == nil, let stream = request.httpBodyStream else {
            return request
        }
        var body = Data()
        var buffer = [UInt8](repeating: 0, count: 4096)
        stream.open()
        defer { stream.close() }
        while case let count = stream.read(&buffer, maxLength: buffer.count), count > 0 {
            body.append(buffer, count: count)
        }
        var copy = request
        copy.httpBody = body
        return copy
    }
}

extension URLRequest {
    /// The method and the path relative to the API base URL, such as `PUT /instance/i-1:start`.
    var endpoint: String {
        let path = url.flatMap { URLComponents(url: $0, resolvingAgainstBaseURL: false)?.percentEncodedPath } ?? ""
        return "\(httpMethod ?? "GET") \(path.replacingOccurrences(of: "/v2", with: "", options: .anchored))"
    }

    /// The body as text.
    var bodyText: String? {
        httpBody.flatMap { String(bytes: $0, encoding: .utf8) }
    }

    /// The JSON body as a dictionary.
    var jsonBody: [String: Any]? {
        httpBody.flatMap { try? JSONSerialization.jsonObject(with: $0) as? [String: Any] }
    }

    /// The query parsed the way Go's `net/url` does: `+` is a space, and pairs with `;` are dropped.
    var formDecodedQuery: [String: String] {
        let query = url.flatMap { URLComponents(url: $0, resolvingAgainstBaseURL: false)?.percentEncodedQuery } ?? ""
        var values: [String: String] = [:]
        for pair in query.split(separator: "&") where !pair.contains(";") {
            let parts = pair.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
            func decode(_ part: Substring) -> String {
                part.replacingOccurrences(of: "+", with: " ").removingPercentEncoding ?? String(part)
            }
            values[decode(parts[0])] = parts.count > 1 ? decode(parts[1]) : ""
        }
        return values
    }

    /// Whether the signature matches the request as the API receives it.
    func hasValidSignature(secret: String = "secret") -> Bool {
        guard let authorization = value(forHTTPHeaderField: "Authorization"),
              authorization.hasPrefix("EXO2-HMAC-SHA256 "),
              let url,
              let path = URLComponents(url: url, resolvingAgainstBaseURL: false)?.percentEncodedPath
        else {
            return false
        }
        var fields: [String: String] = [:]
        for field in authorization.dropFirst("EXO2-HMAC-SHA256 ".count).split(separator: ",") {
            let parts = field.split(separator: "=", maxSplits: 1)
            fields[String(parts[0])] = parts.count > 1 ? String(parts[1]) : ""
        }
        let query = formDecodedQuery
        let signedValues = (fields["signed-query-args"]?.split(separator: ";") ?? []).map { query[String($0)] ?? "" }
        let message = [
            "\(httpMethod ?? "GET") \(path)",
            bodyText ?? "",
            signedValues.joined(),
            "",
            fields["expires"] ?? ""
        ].joined(separator: "\n")
        let code = HMAC<SHA256>.authenticationCode(
            for: Data(message.utf8),
            using: SymmetricKey(data: Data(secret.utf8))
        )
        return Data(code).base64EncodedString() == fields["signature"]
    }
}

/// A client call and the request it should send.
struct Call: Sendable, CustomTestStringConvertible {
    let testDescription: String
    /// The method and path, such as `PUT /instance/i-1:start`.
    let endpoint: String
    /// The query parameters, after form decoding.
    var query: [String: String] = [:]
    /// The exact JSON body, or `nil` for none.
    var body: String?
    /// The response the stub sends back.
    var response = #"{"id":"op-1","state":"pending"}"#
    let run: @Sendable (Exoscale) async throws -> Void

    init(
        _ description: String,
        _ endpoint: String,
        query: [String: String] = [:],
        body: String? = nil,
        response: String = #"{"id":"op-1","state":"pending"}"#,
        run: @escaping @Sendable (Exoscale) async throws -> Void
    ) {
        testDescription = description
        self.endpoint = endpoint
        self.query = query
        self.body = body
        self.response = response
        self.run = run
    }
}

/// Runs a call against a stub and checks the request it sent.
func check(_ call: Call, sourceLocation: SourceLocation = #_sourceLocation) async throws {
    let stub = try Stub(json: call.response)
    try await call.run(stub.exoscale)
    let request = try stub.request
    #expect(request.endpoint == call.endpoint, sourceLocation: sourceLocation)
    #expect(request.formDecodedQuery == call.query, sourceLocation: sourceLocation)
    #expect(request.bodyText == call.body, sourceLocation: sourceLocation)
    #expect(request.hasValidSignature(), sourceLocation: sourceLocation)
}

/// Decodes `json` as the response of `get`, and checks the request was a GET to `endpoint`.
func decode<Value>(
    _ json: String,
    from endpoint: String,
    _ get: @Sendable (Exoscale) async throws -> Value
) async throws -> Value {
    let stub = try Stub(json: json)
    let value = try await get(stub.exoscale)
    #expect(try stub.request.endpoint == "GET \(endpoint)")
    return value
}
