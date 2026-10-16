@testable import Exoscale
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Testing

private final class RecordedRequests: @unchecked Sendable {
    private let lock = NSLock()
    private var requests: [String: [URLRequest]] = [:]

    func append(_ request: URLRequest, for id: String) {
        lock.withLock { requests[id, default: []].append(request) }
    }

    func requests(for id: String) -> [URLRequest] {
        lock.withLock { requests[id] ?? [] }
    }
}

private final class QueryStubProtocol: URLProtocol {
    static let recorded = RecordedRequests()
    static let bodies = [
        "/v2/usage-report": #"{"usage":[]}"#,
        "/v2/ai/deployment": #"{"deployments":[]}"#,
        "/v2/ai/deployment/deployment-1/logs": #"{"logs":[]}"#,
        "/v2/ai/help/inference-engine-parameters": #"{"parameters":[]}"#,
        "/v2/sos/assets/presigned-url": #"{"url":"https://sos.example.com/assets/object"}"#,
        "/v2/event": "[]"
    ]

    override static func canInit(with _: URLRequest) -> Bool {
        true
    }

    override static func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let url = request.url,
              let id = request.value(forHTTPHeaderField: "User-Agent"),
              let body = Self.bodies[url.path],
              let response = HTTPURLResponse(
                  url: url,
                  statusCode: 200,
                  httpVersion: nil,
                  headerFields: ["Content-Type": "application/json"]
              )
        else {
            client?.urlProtocol(self, didFailWithError: URLError(.unsupportedURL))
            return
        }
        Self.recorded.append(request, for: id)
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: Data(body.utf8))
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

/// A client whose requests are answered locally and recorded under a unique User-Agent.
private struct StubbedExoscale {
    let id = UUID().uuidString
    let exoscale: Exoscale

    init() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [QueryStubProtocol.self]
        exoscale = try Exoscale(
            config: Exoscale.Config(apiKey: "key", apiSecret: "secret", zone: .chGva2, userAgent: id),
            sessionConfiguration: configuration
        )
    }

    var requests: [URLRequest] {
        QueryStubProtocol.recorded.requests(for: id)
    }
}

@Test(
    "Query values reach the API unchanged and keep a valid signature",
    arguments: ["2026-10-16T12:00:00+02:00", "reports/q3+q4 final.pdf", "a;b&c=d#e", "env:prod,tier:web", "café/ü"]
)
func queryValuesSurviveFormDecoding(value: String) throws {
    let client = try Exoscale(apiKey: "key", apiSecret: "secret", zone: .chGva2)
    let request = try client.http.makeRequest("GET", path: "/event", query: ["from": value])
    let signed = try SignRequest(apiKey: "key", apiSecret: "secret").adapt(request)

    #expect(try formDecodedQuery(of: #require(signed.url)) == ["from": value])
    #expect(try hasValidSignature(signed, secret: "secret"))
}

@Test("Object keys and event ranges containing '+' are sent intact")
func plusSignsInPublicQueryParameters() async throws {
    let stub = try StubbedExoscale()
    _ = try await stub.exoscale.objectStorage.presignedURL(bucket: "assets", key: "reports/q3+q4.pdf")
    _ = try await stub.exoscale.events.list(from: "2026-10-01T00:00:00+02:00", to: "2026-10-16T00:00:00+02:00")

    let requests = stub.requests
    try #require(requests.count == 2)
    #expect(try formDecodedQuery(of: #require(requests[0].url)) == ["key": "reports/q3+q4.pdf"])
    #expect(try formDecodedQuery(of: #require(requests[1].url)) == [
        "from": "2026-10-01T00:00:00+02:00",
        "to": "2026-10-16T00:00:00+02:00"
    ])
    for request in requests {
        #expect(try hasValidSignature(request, secret: "secret"))
    }
}

@Test("Nil query values are omitted instead of sent as bare parameters")
func nilQueryValuesAreOmitted() throws {
    let client = try Exoscale(apiKey: "key", apiSecret: "secret", zone: .chGva2)
    let empty = try client.http.makeRequest("GET", path: "/instance", query: ["labels": nil])
    let mixed = try client.http.makeRequest(
        "GET",
        path: "/instance",
        query: ["labels": nil, "ip-address": "203.0.113.1"]
    )

    #expect(empty.url?.absoluteString == "https://api-ch-gva-2.exoscale.com/v2/instance")
    #expect(mixed.url?.absoluteString == "https://api-ch-gva-2.exoscale.com/v2/instance?ip-address=203.0.113.1")
}

@Test("Omitted optional parameters leave the query empty")
func omittedOptionalParametersAreNotSent() async throws {
    let stub = try StubbedExoscale()
    _ = try await stub.exoscale.organization.usageReport()
    _ = try await stub.exoscale.deployments.list()
    _ = try await stub.exoscale.deployments.logs(id: "deployment-1")
    _ = try await stub.exoscale.deployments.inferenceEngineParameters()

    let requests = stub.requests
    try #require(requests.count == 4)
    for request in requests {
        #expect(request.url?.query == nil, "Unexpected query on \(request.url?.path ?? "")")
    }
}

@Test("Supplied optional parameters are sent")
func suppliedOptionalParametersAreSent() async throws {
    let stub = try StubbedExoscale()
    _ = try await stub.exoscale.organization.usageReport(period: "2026-09")
    _ = try await stub.exoscale.deployments.list(visibility: "public")
    _ = try await stub.exoscale.deployments.logs(id: "deployment-1", stream: false, tail: 10)
    _ = try await stub.exoscale.deployments.inferenceEngineParameters(version: "0.19.0")

    let queries = try stub.requests.map { try formDecodedQuery(of: #require($0.url)) }
    #expect(queries == [
        ["period": "2026-09"],
        ["visibility": "public"],
        ["stream": "false", "tail": "10"],
        ["version": "0.19.0"]
    ])
}
