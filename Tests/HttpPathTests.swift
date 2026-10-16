@testable import Exoscale
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Testing

private final class NoNetworkProtocol: URLProtocol {
    override static func canInit(with _: URLRequest) -> Bool {
        true
    }

    override static func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        Issue.record("No request should be sent, received \(request.url?.absoluteString ?? "nil")")
        client?.urlProtocol(self, didFailWithError: URLError(.cancelled))
    }

    override func stopLoading() {}
}

@Test("Interpolated values stay inside one path segment")
func interpolatedValuesAreEncodedAsOneSegment() {
    let username = "ops/admin?x#y%z;v"
    let path: Http.Path = "/dbaas-postgres/\("pg-main")/user/\(username)/password/reveal"

    #expect(path.percentEncoded == "/dbaas-postgres/pg-main/user/ops%2Fadmin%3Fx%23y%25z%3Bv/password/reveal")
    #expect(path.invalidValue == nil)
}

@Test("Raw values, integers and existing separators are kept readable")
func pathInterpolationKeepsCommonValuesReadable() {
    let field: Http.Path = "/instance/\("vm-1")/\(InstancesResource.Field.labels)"
    let action: Http.Path = "/instance/\("vm-1"):start"
    let status: Http.Path = "/status/\(404)"
    let user: Http.Path = "/dbaas-kafka/\("events")/user/\("svc@team+ci")"

    #expect(field.percentEncoded == "/instance/vm-1/labels")
    #expect(action.percentEncoded == "/instance/vm-1:start")
    #expect(status.percentEncoded == "/status/404")
    #expect(user.percentEncoded == "/dbaas-kafka/events/user/svc@team+ci")
}

@Test("Encoded paths are sent as built and signed as sent")
func encodedPathsAreSignedAsSent() throws {
    let client = try Exoscale(apiKey: "key", apiSecret: "secret", zone: .chGva2)
    let request = try client.http.makeRequest("GET", path: "/dbaas-postgres/\("pg")/user/\("a/b?c")/password/reveal")
    let signed = try SignRequest(apiKey: "key", apiSecret: "secret").adapt(request)
    let url = try #require(signed.url)
    let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))

    #expect(components.percentEncodedPath == "/v2/dbaas-postgres/pg/user/a%2Fb%3Fc/password/reveal")
    #expect(components.query == nil)
    #expect(try hasValidSignature(signed, secret: "secret"))
}

@Test("Empty and dot values are rejected before a request is sent", arguments: ["", ".", ".."])
func invalidPathValuesAreRejected(id: String) async throws {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [NoNetworkProtocol.self]
    let exoscale = try Exoscale(
        config: Exoscale.Config(apiKey: "key", apiSecret: "secret", zone: .chGva2),
        sessionConfiguration: configuration
    )

    await #expect(throws: Exoscale.ApiError.invalidPathValue(id)) {
        try await exoscale.instances.get(id: id)
    }
    await #expect(throws: Exoscale.ApiError.invalidPathValue(id)) {
        try await exoscale.postgresql.revealUserPassword(serviceName: "pg", username: id)
    }
}
