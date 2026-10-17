@testable import Exoscale
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Testing

private func client() throws -> HTTPClient {
    try Exoscale(apiKey: "EXOkey", apiSecret: "secret").client
}

@Test("Interpolated path values stay inside one segment", arguments: [
    ("i-1", "/v2/instance/i-1"),
    ("a/b", "/v2/instance/a%2Fb"),
    ("a?b#c", "/v2/instance/a%3Fb%23c"),
    ("a;b", "/v2/instance/a%3Bb"),
    ("café", "/v2/instance/caf%C3%A9")
])
func pathEncoding(id: String, path: String) throws {
    let request = try client().makeRequest(.get, "/instance/\(id)")
    #expect(request.url.map { URLComponents(url: $0, resolvingAgainstBaseURL: false)!.percentEncodedPath } == path)
}

@Test("Empty, . and .. identifiers are rejected before sending", arguments: ["", ".", ".."])
func invalidPathComponents(id: String) throws {
    #expect(throws: Exoscale.ClientError.invalidPathComponent(id)) {
        try client().makeRequest(.get, "/instance/\(id)")
    }
}

@Test("Query values survive the API's form decoding and stay signed", arguments: [
    "2026-10-16T12:00:00+02:00", "reports/q3+q4 final.pdf", "a;b&c=d#e", "env:prod,tier:web", "café/ü"
])
func queryEncoding(value: String) throws {
    let client = try client()
    let request = try RequestSigner(apiKey: "EXOkey", apiSecret: "secret")
        .sign(client.makeRequest(.get, "/event", query: ["from": value, "to": nil]))
    #expect(request.formDecodedQuery == ["from": value])
    #expect(request.hasValidSignature())
}

@Test("Bodies leave out nil fields and sort their keys")
func bodyEncoding() throws {
    let name: String? = nil
    let request = try client().makeRequest(.post, "/instance", body: [
        "name": name,
        "disk-size": 50,
        "labels": ["env": "prod"],
        "auto-start": false
    ] as JSONBody)
    #expect(request.bodyText == #"{"auto-start":false,"disk-size":50,"labels":{"env":"prod"}}"#)
    #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
}

@Test("Requests carry the User-Agent, Accept header and a valid signature")
func requestHeaders() async throws {
    let stub = try Stub(json: #"{"id":"op-1","state":"success"}"#)
    _ = try await stub.exoscale.operations.get(id: "op-1")
    let request = try stub.request
    #expect(request.value(forHTTPHeaderField: "User-Agent") == stub.id)
    #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
    #expect(request.hasValidSignature())
}

@Test("Signatures expire ten minutes after signing")
func signatureExpiry() throws {
    let now = Date(timeIntervalSince1970: 1_800_000_000)
    let request = try RequestSigner(apiKey: "EXOkey", apiSecret: "secret").sign(
        client().makeRequest(.get, "/zone"),
        now: now
    )
    #expect(request.value(forHTTPHeaderField: "Authorization")?.contains("expires=1800000600") == true)
}

@Test("Signer reflections never contain the secret")
func signerRedactsSecret() {
    var dumped = ""
    dump(RequestSigner(apiKey: "EXOkey", apiSecret: "top-secret"), to: &dumped)
    #expect(!dumped.contains("top-secret"))
}
