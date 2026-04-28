import Foundation
import Testing

@testable import Exoscale

@Test("Event decodes mutation event details")
func eventDecodesMutationEventDetails() throws {
    let data = Data(
        """
        [
          {
            "iam-user": {
              "id": "11111111-1111-1111-1111-111111111111",
              "email": "user@example.com"
            },
            "request-id": "request-123",
            "iam-role": {
              "id": "22222222-2222-2222-2222-222222222222",
              "name": "admin"
            },
            "zone": "ch-gva-2",
            "get-params": {
              "dry-run": true
            },
            "body-params": {
              "name": "web-1",
              "size": 2
            },
            "status": 200,
            "source-ip": "203.0.113.10",
            "iam-api-key": {
              "name": "automation",
              "key": "EXO...",
              "role-id": "33333333-3333-3333-3333-333333333333"
            },
            "uri": "/v2/instance",
            "elapsed-ms": 42,
            "timestamp": "2026-04-27T10:00:00Z",
            "path-params": {
              "id": "44444444-4444-4444-4444-444444444444"
            },
            "handler": "create-instance",
            "message": "Instance created"
          }
        ]
        """.utf8
    )

    let events = try JSONDecoder().decode([Exoscale.Event].self, from: data)
    let event = try #require(events.first)

    #expect(event.iamUser?.id == "11111111-1111-1111-1111-111111111111")
    #expect(event.iamUser?.email == "user@example.com")
    #expect(event.requestID == "request-123")
    #expect(event.iamRole?.id == "22222222-2222-2222-2222-222222222222")
    #expect(event.iamRole?.name == "admin")
    #expect(event.zone == "ch-gva-2")
    #expect(event.getParams?["dry-run"] == .bool(true))
    #expect(event.bodyParams?["name"] == .string("web-1"))
    #expect(event.bodyParams?["size"] == .integer(2))
    #expect(event.status == 200)
    #expect(event.sourceIP == "203.0.113.10")
    #expect(event.iamAPIKey?.name == "automation")
    #expect(event.iamAPIKey?.roleID == "33333333-3333-3333-3333-333333333333")
    #expect(event.uri == "/v2/instance")
    #expect(event.elapsedMS == 42)
    #expect(event.timestamp == "2026-04-27T10:00:00Z")
    #expect(event.pathParams?["id"] == .string("44444444-4444-4444-4444-444444444444"))
    #expect(event.handler == "create-instance")
    #expect(event.message == "Instance created")
}

@Test("Client encodes event list filters")
func clientEncodesEventListFilters() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let request = try client.http.makeRequest(
        "GET",
        path: "/event",
        query: [
            "from": "2026-04-26T10:00:00Z",
            "to": "2026-04-27T10:00:00Z",
        ]
    )

    let url = try #require(request.url)
    let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    let queryItems = Dictionary(uniqueKeysWithValues: try #require(components.queryItems).map { ($0.name, $0.value) })

    #expect(queryItems["from"] == "2026-04-26T10:00:00Z")
    #expect(queryItems["to"] == "2026-04-27T10:00:00Z")
}
