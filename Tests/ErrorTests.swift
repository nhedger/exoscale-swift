@testable import Exoscale
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Testing

@Test(
    "API error messages come from JSON or short plain-text bodies",
    arguments: [
        (#"{"message":"Instance not found"}"#, "Instance not found"),
        (#"{"message":"  "}"#, nil),
        (#"{"errors":["unexpected"]}"#, nil),
        (#"{"title":"Bad Request","status":400,"detail":"to is before from"}"#, "to is before from"),
        (#"{"error":"Too many requests","retry_after":2}"#, "Too many requests"),
        (#"{"message":"Quota exceeded","error":{"code":42}}"#, "Quota exceeded"),
        ("Forbidden by role policy: compute:get-instance", "Forbidden by role policy: compute:get-instance"),
        ("<html><body>Bad gateway</body></html>", nil),
        ("", nil)
    ] as [(String, String?)]
)
func apiErrorMessages(body: String, message: String?) {
    #expect(Exoscale.ApiError.httpError(statusCode: 404, body: Data(body.utf8)).message == message)
}

@Test("API error descriptions append the API message")
func apiErrorDescriptions() {
    let notFound = Exoscale.ApiError.httpError(statusCode: 404, body: Data(#"{"message":"Instance not found"}"#.utf8))
    // The status text comes from Foundation, which words it differently on Apple platforms and Linux.
    let reason = HTTPURLResponse.localizedString(forStatusCode: 404)
    #expect(notFound.localizedDescription == "The API returned HTTP 404 (\(reason)). Instance not found")

    let unauthorized = Http.Client.error(forResponseStatusCode: 401, data: Data(#"{"message":"Expired request"}"#.utf8))
    #expect(unauthorized == .unauthorized(message: "Expired request"))
    #expect(
        unauthorized?.localizedDescription
            == "The request is missing valid authorization credentials. Expired request"
    )

    #expect(
        Exoscale.ApiError.invalidResponse.localizedDescription == "The API returned a non-HTTP response."
    )
}

@Test("Operation wait errors have readable localized descriptions")
func waitErrorDescriptions() {
    #expect(
        OperationsResource.WaitError.timedOut("op-1").localizedDescription
            == "Timed out waiting for operation op-1."
    )
    #expect(
        OperationsResource.WaitError.missingOperationID.localizedDescription
            == "Operation did not include an id."
    )
}

/// Fri, 15 Jan 2027 08:00:00 GMT.
private let retryNow = Date(timeIntervalSince1970: 1_800_000_000)

private struct RetryAfterCase: Sendable {
    var header: String?
    var body: String?
    var expected: Duration?
}

@Test(
    "Retry-After is read as seconds or an HTTP date, falling back to the body's retry_after",
    arguments: [
        RetryAfterCase(header: "120", expected: .seconds(120)),
        RetryAfterCase(header: " 7 ", expected: .seconds(7)),
        RetryAfterCase(header: "Fri, 15 Jan 2027 08:00:30 GMT", expected: .seconds(30)),
        RetryAfterCase(header: "Fri, 15 Jan 2027 07:59:30 GMT", expected: .zero),
        RetryAfterCase(header: "4", body: #"{"retry_after":10}"#, expected: .seconds(4)),
        RetryAfterCase(body: #"{"error":"Too many requests","retry_after":2.5}"#, expected: .seconds(2.5)),
        RetryAfterCase(header: "soon"),
        RetryAfterCase(header: "-5"),
        RetryAfterCase(body: #"{"message":"Slow down"}"#),
        RetryAfterCase()
    ]
)
private func retryAfterParsing(_ testCase: RetryAfterCase) {
    let wait = Exoscale.ApiError.retryAfter(
        header: testCase.header,
        body: testCase.body.map { Data($0.utf8) },
        now: retryNow
    )
    #expect(wait == testCase.expected)
}

@Test("Rate-limited and unavailable errors expose and describe the wait")
func retryAfterDescriptions() {
    let rateLimited = Http.Client.error(
        forResponseStatusCode: 429,
        data: Data(#"{"error":"Too many requests"}"#.utf8),
        retryAfter: "90"
    )
    #expect(rateLimited == .rateLimited(message: "Too many requests", retryAfter: .seconds(90)))
    #expect(rateLimited?.retryAfter == .seconds(90))
    #expect(
        rateLimited?.localizedDescription
            == "Too many requests were sent to the API. Try again in 90 seconds. Too many requests"
    )

    let unavailable = Exoscale.ApiError.serviceUnavailable(message: nil, retryAfter: .milliseconds(200))
    #expect(unavailable.localizedDescription == "The API is temporarily unavailable. Try again in 1 second.")
    #expect(
        Exoscale.ApiError.serviceUnavailable(message: nil, retryAfter: nil).localizedDescription
            == "The API is temporarily unavailable."
    )
    #expect(Exoscale.ApiError.httpError(statusCode: 500, body: Data()).retryAfter == nil)
}
