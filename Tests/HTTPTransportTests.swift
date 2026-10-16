@testable import Exoscale
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Testing

private final class TransportProtocol: URLProtocol {
    static let cancellationEvents = AsyncStream<String>.makeStream()
    static let errorBody = Data(#"{"message":"API failure"}"#.utf8)

    override static func canInit(with _: URLRequest) -> Bool {
        true
    }

    override static func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        do {
            let url = try #require(request.url)
            let path = url.path
            if path == "/v2/hanging" {
                Self.cancellationEvents.continuation.yield("started")
                return
            }
            if path == "/v2/pre-cancelled" {
                Issue.record("A cancelled task must not start a network request")
                client?.urlProtocol(self, didFailWithError: URLError(.cancelled))
                return
            }
            if path == "/v2/transport-error" {
                client?.urlProtocol(self, didFailWithError: URLError(.timedOut))
                return
            }
            if path == "/v2/non-http" {
                let response = URLResponse(
                    url: url,
                    mimeType: "application/json",
                    expectedContentLength: 2,
                    textEncodingName: "utf-8"
                )
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: Data("{}".utf8))
                client?.urlProtocolDidFinishLoading(self)
                return
            }

            try loadHTTPResponse(url: url)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
        if request.url?.path == "/v2/hanging" {
            Self.cancellationEvents.continuation.yield("stopped")
            Self.cancellationEvents.continuation.finish()
        }
    }

    private func loadHTTPResponse(url: URL) throws {
        let fixture = try responseFixture(url: url)
        checkHeaders(path: url.path)
        let headers = fixture.contentType.map { ["Content-Type": $0] } ?? [:]
        let response = try #require(HTTPURLResponse(
            url: url,
            statusCode: fixture.statusCode,
            httpVersion: nil,
            headerFields: headers
        ))
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if !fixture.body.isEmpty {
            client?.urlProtocol(self, didLoad: fixture.body)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    private func checkHeaders(path: String) {
        #expect(request.value(forHTTPHeaderField: "Authorization")?.hasPrefix("EXO2-HMAC-SHA256 ") == true)
        switch path {
        case "/v2/headers":
            #expect(request.value(forHTTPHeaderField: "User-Agent") == "transport-test")
            #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
            #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
        case "/v2/custom-headers":
            #expect(request.value(forHTTPHeaderField: "User-Agent") == "custom-agent")
            #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/custom+json")
            #expect(request.value(forHTTPHeaderField: "Accept") == "application/custom+json")
        case "/v2/json":
            #expect(request.value(forHTTPHeaderField: "Content-Type") == nil)
        default:
            break
        }
    }

    private func responseFixture(url: URL) throws -> ResponseFixture {
        if url.path.hasPrefix("/v2/status/") {
            // Status validation must take precedence over content-type validation.
            return try ResponseFixture(
                statusCode: #require(Int(url.lastPathComponent)), contentType: "text/plain", body: Self.errorBody
            )
        }
        switch url.path {
        case "/v2/policy":
            return ResponseFixture(
                statusCode: 403, contentType: "text/plain",
                body: Data("Forbidden by role policy: missing permission".utf8)
            )
        case "/v2/vendor-json":
            return ResponseFixture(contentType: "application/vnd.exoscale+json")
        case "/v2/missing-content-type":
            return ResponseFixture(contentType: nil)
        case "/v2/html":
            return ResponseFixture(contentType: "text/html")
        case "/v2/malformed":
            return ResponseFixture(body: Data("not JSON".utf8))
        case "/v2/empty-204":
            return ResponseFixture(statusCode: 204, contentType: nil, body: Data())
        case "/v2/empty-200":
            return ResponseFixture(body: Data())
        default:
            if !["/v2/headers", "/v2/custom-headers", "/v2/json"].contains(url.path) {
                Issue.record("Unexpected transport test path: \(url.path)")
            }
            return ResponseFixture()
        }
    }
}

private extension TransportProtocol {
    struct ResponseFixture {
        var statusCode = 200
        var contentType: String? = "application/json; charset=utf-8"
        var body = Data(#"{"value":42}"#.utf8)
    }
}

private func transportClient() throws -> Http.Client {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [TransportProtocol.self]
    return try Http.Client(
        config: Exoscale.Config(apiKey: "test", apiSecret: "test", zone: .chGva2, userAgent: "transport-test"),
        sessionConfiguration: configuration
    )
}

@Test(
    "URLSession preserves HTTP status and response body in SDK errors",
    arguments: [400, 404, 409, 422, 500, 502]
)
func httpStatusErrors(statusCode: Int) async throws {
    let http = try transportClient()
    await #expect(throws: Exoscale.ApiError.httpError(statusCode: statusCode, body: TransportProtocol.errorBody)) {
        try await http.get(path: "/status/\(statusCode)", as: Exoscale.JSONValue.self)
    }
}

@Test("URLSession preserves existing authorization error cases")
func httpAuthorizationErrors() async throws {
    let http = try transportClient()
    await #expect(throws: Exoscale.ApiError.unauthorized(message: "API failure")) {
        try await http.get(path: "/status/401", as: Exoscale.JSONValue.self)
    }
    await #expect(throws: Exoscale.ApiError.forbidden(message: "API failure")) {
        try await http.get(path: "/status/403", as: Exoscale.JSONValue.self)
    }
    let policyError = Exoscale.ApiError.forbiddenByPolicy(message: "Forbidden by role policy: missing permission")
    await #expect(throws: policyError) {
        try await http.get(path: "/policy", as: Exoscale.JSONValue.self)
    }
}

@Test(
    "Successful JSON responses accept standard, vendor and omitted content types",
    arguments: ["/json", "/vendor-json", "/missing-content-type"]
)
func httpJSONResponses(path: String) async throws {
    let value = try await transportClient().get(path: Http.Path(stringLiteral: path), as: Exoscale.JSONValue.self)
    #expect(value == .object(["value": .integer(42)]))
}

@Test("Unexpected content types and non-HTTP responses produce SDK errors")
func httpInvalidResponses() async throws {
    let http = try transportClient()
    await #expect(throws: Exoscale.ApiError.unexpectedContentType("text/html")) {
        try await http.get(path: "/html", as: Exoscale.JSONValue.self)
    }
    await #expect(throws: Exoscale.ApiError.invalidResponse) {
        try await http.get(path: "/non-http", as: Exoscale.JSONValue.self)
    }
    await #expect(throws: DecodingError.self) {
        try await http.get(path: "/malformed", as: Exoscale.JSONValue.self)
    }
}

@Test(
    "Empty successful responses are valid only for endpoints without a response model",
    arguments: ["/empty-200", "/empty-204"]
)
func httpEmptyResponses(path: String) async throws {
    let http = try transportClient()
    _ = try await http.delete(path: Http.Path(stringLiteral: path), as: EmptyResponse.self)
    await #expect(throws: DecodingError.self) {
        try await http.get(path: Http.Path(stringLiteral: path), as: Exoscale.Operation.Payload.self)
    }
}

@Test("Native URLSession transport errors propagate")
func httpNativeErrors() async throws {
    do {
        _ = try await transportClient().get(path: "/transport-error", as: Exoscale.JSONValue.self)
        Issue.record("Expected a transport error")
    } catch let error as URLError {
        #expect(error.code == .timedOut)
    }
}

@Test("Request transformations apply defaults and preserve explicit headers")
func httpRequestHeaders() async throws {
    let http = try transportClient()
    _ = try await http.post(path: "/headers", body: Data("{}".utf8), as: Exoscale.JSONValue.self)
    _ = try await http.post(
        path: "/custom-headers",
        body: Data("{}".utf8),
        headers: [
            "User-Agent": "custom-agent",
            "Content-Type": "application/custom+json",
            "Accept": "application/custom+json"
        ],
        as: Exoscale.JSONValue.self
    )
}

@Test("Cancelling a Swift task cancels its active URLSession request", .timeLimit(.minutes(1)))
func httpCancellation() async throws {
    let http = try transportClient()
    let task = Task { try await http.get(path: "/hanging", as: Exoscale.JSONValue.self) }
    var events = TransportProtocol.cancellationEvents.stream.makeAsyncIterator()
    #expect(await events.next() == "started")
    task.cancel()
    do {
        _ = try await task.value
        Issue.record("Expected the request to be cancelled")
    } catch let error as URLError {
        #expect(error.code == .cancelled)
    } catch is CancellationError {
        // Cancellation can also be observed by the client's explicit task check.
    }
    #expect(await events.next() == "stopped")
}

@Test("An already-cancelled task does not start a request")
func httpPreCancellation() async throws {
    let http = try transportClient()
    let gate = AsyncStream<Void>.makeStream()
    let task = Task {
        for await _ in gate.stream {
            break
        }
        return try await http.get(path: "/pre-cancelled", as: Exoscale.JSONValue.self)
    }
    task.cancel()
    gate.continuation.finish()
    await #expect(throws: CancellationError.self) {
        try await task.value
    }
}

@Test("Rate-limited and unavailable responses carry the requested wait and are not retried")
func throttledResponsesAreNotRetried() async throws {
    let body = Data(#"{"error":"Too many requests","retry_after":1}"#.utf8)
    let headers = ["Content-Type": "application/json", "Retry-After": "30"]
    let balance = ScriptedResponse(body: Data(#"{"balance":12.5,"currency":"CHF"}"#.utf8))
    let rateLimited = ScriptedTransport([ScriptedResponse(statusCode: 429, headers: headers, body: body), balance])
    let unavailable = ScriptedTransport([ScriptedResponse(statusCode: 503, headers: headers, body: Data()), balance])

    await #expect(throws: Exoscale.ApiError.rateLimited(message: "Too many requests", retryAfter: .seconds(30))) {
        try await rateLimited.exoscale().organization.liveBalance()
    }
    await #expect(throws: Exoscale.ApiError.serviceUnavailable(message: nil, retryAfter: .seconds(30))) {
        try await unavailable.exoscale().organization.liveBalance()
    }
    #expect(rateLimited.requests.count == 1)
    #expect(unavailable.requests.count == 1)
}

@Test("Rate-limited and unavailable responses without a requested wait keep the API message")
func throttledResponsesWithoutWait() async throws {
    let http = try transportClient()
    await #expect(throws: Exoscale.ApiError.rateLimited(message: "API failure", retryAfter: nil)) {
        try await http.get(path: "/status/429", as: Exoscale.JSONValue.self)
    }
    await #expect(throws: Exoscale.ApiError.serviceUnavailable(message: "API failure", retryAfter: nil)) {
        try await http.get(path: "/status/503", as: Exoscale.JSONValue.self)
    }
}
