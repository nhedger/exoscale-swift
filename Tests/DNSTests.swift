@testable import Exoscale
import Foundation
import Testing

@Test("DNS calls send the expected requests", arguments: [
    Call("list domains", "GET /dns-domain", response: "{}") { _ = try await $0.domains.list() },
    Call("get domain", "GET /dns-domain/d-1", response: #"{"id":"d-1"}"#) { _ = try await $0.domains.get(id: "d-1") },
    Call("create domain", "POST /dns-domain", body: #"{"unicode-name":"example.com"}"#) {
        _ = try await $0.domains.create(name: "example.com")
    },
    Call("delete domain", "DELETE /dns-domain/d-1") { _ = try await $0.domains.delete(id: "d-1") },
    Call("zone file", "GET /dns-domain/d-1/zone", response: #"{"zone-file":"$ORIGIN example.com."}"#) {
        _ = try await $0.domains.zoneFile(id: "d-1")
    },
    Call("list records", "GET /dns-domain/d-1/record", response: "{}") {
        _ = try await $0.domains.records(in: "d-1").list()
    },
    Call("get record", "GET /dns-domain/d-1/record/r-1", response: #"{"id":"r-1"}"#) {
        _ = try await $0.domains.records(in: "d-1").get(id: "r-1")
    },
    Call(
        "create record",
        "POST /dns-domain/d-1/record",
        body: #"{"content":"mail.example.com","name":"","priority":10,"type":"MX"}"#
    ) {
        _ = try await $0.domains.records(in: "d-1").create(
            name: "",
            type: .mx,
            content: "mail.example.com",
            priority: 10
        )
    },
    Call("update record", "PUT /dns-domain/d-1/record/r-1", body: #"{"ttl":300}"#) {
        _ = try await $0.domains.records(in: "d-1").update(id: "r-1", ttl: 300)
    },
    Call("delete record", "DELETE /dns-domain/d-1/record/r-1") {
        _ = try await $0.domains.records(in: "d-1").delete(id: "r-1")
    }
])
func dnsCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Domains, records and zone files decode")
func decodeDNS() async throws {
    let domains = try await decode(
        #"{"dns-domains":[{"id":"d-1","unicode-name":"exämple.com","created-at":"2026-01-02T03:04:05Z"}]}"#,
        from: "/dns-domain"
    ) { try await $0.domains.list() }
    #expect(domains == [.init(
        id: "d-1",
        unicodeName: "exämple.com",
        createdAt: Date(timeIntervalSince1970: 1_767_323_045)
    )])

    let record = try await decode(
        #"{"id":"r-1","name":"www","type":"CNAME","content":"example.com","ttl":3600,"system-record":false}"#,
        from: "/dns-domain/d-1/record/r-1"
    ) { try await $0.domains.records(in: "d-1").get(id: "r-1") }
    #expect(record == .init(
        id: "r-1",
        name: "www",
        type: .cname,
        content: "example.com",
        ttl: 3600,
        isSystemRecord: false
    ))

    let zone = try await decode(#"{"zone-file":"$ORIGIN example.com.\n"}"#, from: "/dns-domain/d-1/zone") {
        try await $0.domains.zoneFile(id: "d-1")
    }
    #expect(zone == "$ORIGIN example.com.\n")
}
