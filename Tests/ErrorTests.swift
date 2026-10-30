@testable import Exoscale
import Foundation
import Testing
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@Test("Unsuccessful responses throw APIError with the API's message", arguments: [
    (#"{"message":"Instance not found"}"#, "Instance not found"),
    (#"{"title":"Bad Request","status":400,"detail":"to is before from"}"#, "to is before from"),
    (#"{"error":"Too many requests","retry_after":2}"#, "Too many requests"),
    (#"{"message":"Quota exceeded","error":{"code":42}}"#, "Quota exceeded"),
    ("Forbidden by role policy: compute:get-instance", "Forbidden by role policy: compute:get-instance"),
    ("<html>Bad gateway</html>", nil),
    ("", nil)
] as [(String, String?)])
func apiErrorMessages(body: String, message: String?) async throws {
    let stub = try Stub(StubResponse(statusCode: 404, body: body))
    do {
        _ = try await stub.exoscale.instances.get(id: "i-1")
        Issue.record("Expected an API error")
    } catch let error as Exoscale.APIError {
        #expect(error.statusCode == 404)
        #expect(error.message == message)
        #expect(error.body == Data(body.utf8))
    }
}

/// Fri, 15 Jan 2027 08:00:00 GMT.
private let now = Date(timeIntervalSince1970: 1_800_000_000)

private struct RetryAfterCase: Sendable {
    var header: String?
    var body = ""
    var expected: Duration?
}

@Test("Retry-After is read as seconds or an HTTP date, falling back to the body", arguments: [
    RetryAfterCase(header: "120", expected: .seconds(120)),
    RetryAfterCase(header: "Fri, 15 Jan 2027 08:00:30 GMT", expected: .seconds(30)),
    RetryAfterCase(header: "Fri, 15 Jan 2027 07:59:30 GMT", expected: .zero),
    RetryAfterCase(header: "4", body: #"{"retry_after":10}"#, expected: .seconds(4)),
    RetryAfterCase(body: #"{"retry_after":2.5}"#, expected: .seconds(2.5)),
    RetryAfterCase(header: "soon"),
    RetryAfterCase(header: "-5"),
    RetryAfterCase()
])
private func retryAfter(_ testCase: RetryAfterCase) {
    let wait = Exoscale.APIError.retryAfter(header: testCase.header, body: Data(testCase.body.utf8), now: now)
    #expect(wait == testCase.expected)
}

@Test("Rate-limited responses carry the requested wait and are never retried")
func rateLimited() async throws {
    let stub = try Stub(StubResponse(statusCode: 429, headers: ["Retry-After": "30"], body: #"{"error":"Slow down"}"#))
    await #expect(throws: Exoscale.APIError(
        statusCode: 429,
        message: "Slow down",
        retryAfter: .seconds(30),
        body: Data(#"{"error":"Slow down"}"#.utf8)
    )) {
        try await stub.exoscale.instances.get(id: "i-1")
    }
    #expect(stub.requests.count == 1)
}

@Test("Error descriptions append the API's message")
func errorDescriptions() {
    let reason = HTTPURLResponse.localizedString(forStatusCode: 404)
    let error = Exoscale.APIError(statusCode: 404, message: "Instance not found")
    #expect(error.localizedDescription == "The API returned HTTP 404 (\(reason)). Instance not found")
}

@Test("Successful responses must be JSON when they say what they are")
func unexpectedContentType() async throws {
    let stub = try Stub(StubResponse(headers: ["Content-Type": "text/html"], body: "<html></html>"))
    await #expect(throws: Exoscale.ClientError.unexpectedContentType("text/html")) {
        try await stub.exoscale.instances.get(id: "i-1")
    }
}

@Test("A cancelled task sends no request")
func cancellation() async throws {
    let stub = try Stub(json: "{}")
    let task = Task {
        withUnsafeCurrentTask { $0?.cancel() }
        return try await stub.exoscale.instances.get(id: "i-1")
    }
    await #expect(throws: CancellationError.self) {
        try await task.value
    }
    #expect(stub.requests.isEmpty)
}
