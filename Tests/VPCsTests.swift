@testable import Exoscale
import Foundation
import Testing

@Test("VPC calls send the expected requests", arguments: [
    Call("list", "GET /vpc", response: "{}") { _ = try await $0.vpcs.list() },
    Call("get", "GET /vpc/vpc-1", response: #"{"id":"vpc-1"}"#) { _ = try await $0.vpcs.get(id: "vpc-1") },
    Call("create", "POST /vpc", body: #"{"dhcp-options":{"dns-servers":["10.0.0.2"]},"name":"main"}"#) {
        _ = try await $0.vpcs.create(name: "main", dhcpOptions: .init(dnsServers: ["10.0.0.2"]))
    },
    Call("update", "PUT /vpc/vpc-1", body: #"{"name":"core"}"#, response: #"{"id":"vpc-1","name":"core"}"#) {
        _ = try await $0.vpcs.update(id: "vpc-1", name: "core")
    },
    Call("delete", "DELETE /vpc/vpc-1", response: "") { try await $0.vpcs.delete(id: "vpc-1") },
    Call("VPC routes", "GET /vpc/vpc-1/route", response: "{}") { _ = try await $0.vpcs.routes(in: "vpc-1") },
    Call("list subnets", "GET /vpc/vpc-1/subnet", response: "{}") {
        _ = try await $0.vpcs.subnets(in: "vpc-1").list()
    },
    Call("get subnet", "GET /vpc/vpc-1/subnet/sub-1", response: #"{"id":"sub-1"}"#) {
        _ = try await $0.vpcs.subnets(in: "vpc-1").get(id: "sub-1")
    },
    Call(
        "create subnet",
        "POST /vpc/vpc-1/subnet",
        body: #"{"address-space":"private","addressfamily":"inet4","ipv4-block":"10.1.0.0/24","name":"app"}"#
    ) {
        _ = try await $0.vpcs.subnets(in: "vpc-1").create(name: "app", ipv4Block: "10.1.0.0/24")
    },
    Call(
        "update subnet",
        "PUT /vpc/vpc-1/subnet/sub-1",
        body: #"{"labels":{"tier":"app"}}"#,
        response: #"{"id":"sub-1"}"#
    ) {
        _ = try await $0.vpcs.subnets(in: "vpc-1").update(id: "sub-1", labels: ["tier": "app"])
    },
    Call("delete subnet", "DELETE /vpc/vpc-1/subnet/sub-1", response: "") {
        try await $0.vpcs.subnets(in: "vpc-1").delete(id: "sub-1")
    },
    Call("attach", "PUT /vpc/vpc-1/subnet/sub-1/attach", body: #"{"instance":{"id":"i-1"},"ipv4":"10.1.0.10"}"#) {
        _ = try await $0.vpcs.subnets(in: "vpc-1").attach(instanceID: "i-1", to: "sub-1", ipv4: "10.1.0.10")
    },
    Call("detach", "PUT /vpc/vpc-1/subnet/sub-1/detach", body: #"{"instance":{"id":"i-1"}}"#) {
        _ = try await $0.vpcs.subnets(in: "vpc-1").detach(instanceID: "i-1", from: "sub-1")
    },
    Call("subnet routes", "GET /vpc/vpc-1/subnet/sub-1/route", response: "{}") {
        _ = try await $0.vpcs.subnets(in: "vpc-1").routes(in: "sub-1")
    },
    Call(
        "add route",
        "POST /vpc/vpc-1/subnet/sub-1/route",
        body: #"{"destination":"0.0.0.0/0","target":"10.1.0.1"}"#,
        response: #"{"id":"rt-1"}"#
    ) {
        _ = try await $0.vpcs.subnets(in: "vpc-1").addRoute(destination: "0.0.0.0/0", target: "10.1.0.1", to: "sub-1")
    },
    Call("delete route", "DELETE /vpc/vpc-1/subnet/sub-1/route/rt-1", response: "") {
        try await $0.vpcs.subnets(in: "vpc-1").deleteRoute("rt-1", from: "sub-1")
    }
])
func vpcCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("VPCs decode their default flag and DHCP options")
func decodeVPCs() async throws {
    let vpcs = try await decode(
        #"{"vpcs":[{"id":"vpc-1","name":"main","default":true,"dhcp-options":{"domain-search":["internal"]},"#
            + #""created-at":"2026-01-02T03:04:05Z"}]}"#,
        from: "/vpc"
    ) { try await $0.vpcs.list() }
    #expect(vpcs == [.init(
        id: "vpc-1",
        name: "main",
        isDefault: true,
        dhcpOptions: .init(domainSearch: ["internal"]),
        createdAt: Date(timeIntervalSince1970: 1_767_323_045)
    )])
}

@Test("Subnets and routes decode")
func decodeSubnets() async throws {
    let subnet = try await decode(
        #"{"id":"sub-1","name":"app","ipv4-block":"10.1.0.0/24","addressfamily":"dual","address-space":"private","#
            + #""instances":[{"id":"i-1","name":"web-1","ipv4":"10.1.0.10"}]}"#,
        from: "/vpc/vpc-1/subnet/sub-1"
    ) { try await $0.vpcs.subnets(in: "vpc-1").get(id: "sub-1") }
    #expect(subnet == .init(
        id: "sub-1",
        name: "app",
        ipv4Block: "10.1.0.0/24",
        addressFamily: .dual,
        addressSpace: .private,
        instances: [.init(id: "i-1", name: "web-1", ipv4: "10.1.0.10")]
    ))

    let routes = try await decode(
        #"{"routes":[{"id":"rt-1","kind":"Subnet","destination":"0.0.0.0/0","target":"10.1.0.1"}]}"#,
        from: "/vpc/vpc-1/route"
    ) { try await $0.vpcs.routes(in: "vpc-1") }
    #expect(routes == [.init(id: "rt-1", kind: .subnet, destination: "0.0.0.0/0", target: "10.1.0.1")])
}
