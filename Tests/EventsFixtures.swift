import Foundation

enum EventsFixtures {
    static let data = Data(#"""
    [
      {
        "body-params" : {
          "name" : "web-1",
          "size" : 2
        },
        "elapsed-ms" : 42,
        "get-params" : {
          "dry-run" : true
        },
        "handler" : "create-instance",
        "iam-api-key" : {
          "key" : "EXO...",
          "name" : "automation",
          "role-id" : "33333333-3333-3333-3333-333333333333"
        },
        "iam-role" : {
          "id" : "22222222-2222-2222-2222-222222222222",
          "name" : "admin"
        },
        "iam-user" : {
          "email" : "user@example.com",
          "id" : "11111111-1111-1111-1111-111111111111"
        },
        "message" : "Instance created",
        "path-params" : {
          "id" : "44444444-4444-4444-4444-444444444444"
        },
        "request-id" : "request-123",
        "source-ip" : "203.0.113.10",
        "status" : 200,
        "timestamp" : "2026-04-27T10:00:00Z",
        "uri" : "/v2/instance",
        "zone" : "ch-gva-2"
      }
    ]
    """#.utf8)
}
