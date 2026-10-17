@testable import Exoscale
import Foundation
import Testing

private let policy = Exoscale.IAMPolicy(
    defaultServiceStrategy: .deny,
    services: ["compute": .init(
        type: .rules,
        rules: [.init(action: .allow, expression: "operation == 'list-instances'")]
    )]
)

private let policyJSON = #"{"default-service-strategy":"deny","services":{"compute":{"rules":[{"action":"allow","#
    + #""expression":"operation == 'list-instances'"}],"type":"rules"}}}"#

@Test("IAM calls send the expected requests", arguments: [
    Call("list roles", "GET /iam-role", response: "{}") { _ = try await $0.roles.list() },
    Call("system roles", "GET /iam-system-role", response: "{}") { _ = try await $0.roles.systemRoles() },
    Call("get role", "GET /iam-role/r-1", response: #"{"id":"r-1"}"#) { _ = try await $0.roles.get(id: "r-1") },
    Call(
        "create role",
        "POST /iam-role",
        body: #"{"max-session-ttl":3600,"name":"readers","permissions":["bypass-governance-retention"],"policy":"#
            + policyJSON + "}"
    ) {
        _ = try await $0.roles.create(
            name: "readers",
            policy: policy,
            permissions: [.bypassGovernanceRetention],
            maxSessionTTL: 3600
        )
    },
    Call("update role", "PUT /iam-role/r-1", body: #"{"description":"Read only"}"#) {
        _ = try await $0.roles.update(id: "r-1", description: "Read only")
    },
    Call("update role policy", "PUT /iam-role/r-1:policy", body: policyJSON) {
        _ = try await $0.roles.updatePolicy(id: "r-1", policy: policy)
    },
    Call("delete role", "DELETE /iam-role/r-1") { _ = try await $0.roles.delete(id: "r-1") },
    Call(
        "assume role",
        "POST /iam-role/r-1/assume",
        body: #"{"ttl":900}"#,
        response: #"{"key":"EXOtmp","secret":"s"}"#
    ) {
        _ = try await $0.roles.assume(id: "r-1", ttl: 900)
    },
    Call("get organization policy", "GET /iam-organization-policy", response: policyJSON) {
        _ = try await $0.organizationPolicy.get()
    },
    Call("update organization policy", "PUT /iam-organization-policy", body: policyJSON) {
        _ = try await $0.organizationPolicy.update(policy)
    },
    Call("reset organization policy", "POST /iam-organization-policy:reset") {
        _ = try await $0.organizationPolicy.reset()
    },
    Call("list users", "GET /user", response: "{}") { _ = try await $0.users.list() },
    Call("create user", "POST /user", body: #"{"email":"ada@example.com","role":{"id":"r-1"}}"#) {
        _ = try await $0.users.create(email: "ada@example.com", roleID: "r-1")
    },
    Call("set user role", "PUT /user/u-1", body: #"{"role":{"id":"r-2"}}"#) {
        _ = try await $0.users.setRole("r-2", forUser: "u-1")
    },
    Call("delete user", "DELETE /user/u-1") { _ = try await $0.users.delete(id: "u-1") },
    Call("list API keys", "GET /api-key", response: "{}") { _ = try await $0.apiKeys.list() },
    Call("get API key", "GET /api-key/EXOkey", response: #"{"key":"EXOkey"}"#) {
        _ = try await $0.apiKeys.get(key: "EXOkey")
    },
    Call(
        "create API key",
        "POST /api-key",
        body: #"{"name":"ci","role-id":"r-1"}"#,
        response: #"{"key":"EXOnew","secret":"s"}"#
    ) {
        _ = try await $0.apiKeys.create(name: "ci", roleID: "r-1")
    },
    Call("delete API key", "DELETE /api-key/EXOkey") { _ = try await $0.apiKeys.delete(key: "EXOkey") },
    Call(
        "events",
        "GET /event",
        query: ["from": "2026-10-01T00:00:00Z", "to": "2026-10-02T00:00:00Z"],
        response: "[]"
    ) {
        _ = try await $0.events.list(
            from: Date(timeIntervalSince1970: 1_790_812_800),
            to: Date(timeIntervalSince1970: 1_790_899_200)
        )
    }
])
func iamCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("IAM policies always send both required fields and read a missing services map as empty")
func iamPolicyCoding() throws {
    let encoded = try JSON.encoder().encode(Exoscale.IAMPolicy(defaultServiceStrategy: .allow))
    #expect(String(bytes: encoded, encoding: .utf8) == #"{"default-service-strategy":"allow","services":{}}"#)

    let decoded = try JSON.decoder().decode(
        Exoscale.IAMPolicy.self,
        from: Data(#"{"default-service-strategy":"deny"}"#.utf8)
    )
    #expect(decoded == .init(defaultServiceStrategy: .deny))

    #expect(throws: DecodingError.self) {
        try JSON.decoder().decode(Exoscale.IAMPolicy.self, from: Data(#"{"services":{}}"#.utf8))
    }
}

@Test("Roles, users and events decode")
func decodeIAM() async throws {
    let roles = try await decode(
        #"{"iam-roles":[{"id":"r-1","name":"readers","editable":true,"max-session-ttl":3600,"#
            + #""permissions":["reset-iam-organization-policy"],"policy":"# + policyJSON + #","#
            + #""assume-role-policy":{"rules":[{"action":"allow","expression":"true"}]}}]}"#,
        from: "/iam-role"
    ) { try await $0.roles.list() }
    #expect(roles == [.init(
        id: "r-1",
        name: "readers",
        editable: true,
        permissions: [.resetIAMOrganizationPolicy],
        policy: policy,
        assumeRolePolicy: .init(rules: [.init(action: .allow, expression: "true")]),
        maxSessionTTL: 3600
    )])

    let users = try await decode(
        #"{"users":[{"id":"u-1","email":"ada@example.com","role":{"id":"r-1"},"sso":false,"#
            + #""two-factor-authentication":true,"pending":true}]}"#,
        from: "/user"
    ) { try await $0.users.list() }
    #expect(users == [.init(
        id: "u-1",
        email: "ada@example.com",
        role: .init(id: "r-1"),
        sso: false,
        twoFactorAuthentication: true,
        pending: true
    )])

    let events = try await decode(
        #"[{"request-id":"req-1","timestamp":"2026-10-01T00:00:00Z","handler":"create-instance","status":200,"#
            + #""source-ip":"198.51.100.7","elapsed-ms":120,"iam-api-key":{"key":"EXOkey","name":"ci"},"#
            + #""body-params":{"name":"web-1","disk-size":50}}]"#,
        from: "/event"
    ) { try await $0.events.list() }
    #expect(events == [.init(
        requestID: "req-1",
        timestamp: Date(timeIntervalSince1970: 1_790_812_800),
        handler: "create-instance",
        status: 200,
        sourceIP: "198.51.100.7",
        elapsedMilliseconds: 120,
        apiKey: .init(key: "EXOkey", name: "ci"),
        bodyParameters: ["name": "web-1", "disk-size": 50]
    )])
}

@Test("New API keys and assumed-role credentials never show their secret when printed")
func secretsAreRedacted() {
    let key = Exoscale.CreatedAPIKey(key: "EXOnew", secret: "top-secret", name: "ci")
    let credentials = Exoscale.AssumedRoleCredentials(key: "EXOtmp", secret: "top-secret")
    for value in [key as Any, credentials as Any] {
        var dumped = ""
        dump(value, to: &dumped)
        #expect(!dumped.contains("top-secret"))
        #expect(!String(describing: value).contains("top-secret"))
        #expect(!String(reflecting: value).contains("top-secret"))
    }
}
