@testable import Exoscale
import Foundation
import Testing

@Test("Security group calls send the expected requests", arguments: [
    Call("list", "GET /security-group", query: ["visibility": "public"], response: "{}") {
        _ = try await $0.securityGroups.list(visibility: .public)
    },
    Call("get", "GET /security-group/sg-1", response: #"{"id":"sg-1"}"#) {
        _ = try await $0.securityGroups.get(id: "sg-1")
    },
    Call("create", "POST /security-group", body: #"{"description":"Web","name":"web"}"#) {
        _ = try await $0.securityGroups.create(name: "web", description: "Web")
    },
    Call("delete", "DELETE /security-group/sg-1") { _ = try await $0.securityGroups.delete(id: "sg-1") },
    Call(
        "add network rule",
        "POST /security-group/sg-1/rules",
        body: #"{"end-port":443,"flow-direction":"ingress","network":"0.0.0.0/0","protocol":"tcp","start-port":443}"#
    ) {
        _ = try await $0.securityGroups.addRule(
            to: "sg-1",
            flowDirection: .ingress,
            protocol: .tcp,
            network: "0.0.0.0/0",
            startPort: 443,
            endPort: 443
        )
    },
    Call(
        "add group rule",
        "POST /security-group/sg-1/rules",
        body: #"{"flow-direction":"ingress","icmp":{"code":0,"type":8},"protocol":"icmp","#
            + #""security-group":{"name":"cloudflare-ipv4","visibility":"public"}}"#
    ) {
        _ = try await $0.securityGroups.addRule(
            to: "sg-1",
            flowDirection: .ingress,
            protocol: .icmp,
            securityGroup: .init(name: "cloudflare-ipv4", visibility: .public),
            icmp: .init(type: 8, code: 0)
        )
    },
    Call("delete rule", "DELETE /security-group/sg-1/rules/r-1") {
        _ = try await $0.securityGroups.deleteRule("r-1", from: "sg-1")
    },
    Call("attach", "PUT /security-group/sg-1:attach", body: #"{"instance":{"id":"i-1"}}"#) {
        _ = try await $0.securityGroups.attach(instanceID: "i-1", to: "sg-1")
    },
    Call("detach", "PUT /security-group/sg-1:detach", body: #"{"instance":{"id":"i-1"}}"#) {
        _ = try await $0.securityGroups.detach(instanceID: "i-1", from: "sg-1")
    },
    Call("add source", "PUT /security-group/sg-1:add-source", body: #"{"cidr":"198.51.100.0/24"}"#) {
        _ = try await $0.securityGroups.addSource(cidr: "198.51.100.0/24", to: "sg-1")
    },
    Call("remove source", "PUT /security-group/sg-1:remove-source", body: #"{"cidr":"198.51.100.0/24"}"#) {
        _ = try await $0.securityGroups.removeSource(cidr: "198.51.100.0/24", from: "sg-1")
    }
])
func securityGroupCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Elastic IP calls send the expected requests", arguments: [
    Call("list", "GET /elastic-ip", response: "{}") { _ = try await $0.elasticIPs.list() },
    Call("get", "GET /elastic-ip/eip-1", response: #"{"id":"eip-1"}"#) { _ = try await $0.elasticIPs.get(id: "eip-1") },
    Call(
        "create",
        "POST /elastic-ip",
        body: #"{"addressfamily":"inet6","#
            + #""healthcheck":{"mode":"https","port":443,"tls-sni":"example.com","uri":"/health"}}"#
    ) {
        _ = try await $0.elasticIPs.create(
            addressFamily: .ipv6,
            healthcheck: .init(mode: .https, port: 443, uri: "/health", tlsSNI: "example.com")
        )
    },
    Call("update", "PUT /elastic-ip/eip-1", body: #"{"labels":{"env":"prod"}}"#) {
        _ = try await $0.elasticIPs.update(id: "eip-1", labels: ["env": "prod"])
    },
    Call("remove description", "DELETE /elastic-ip/eip-1/description") {
        _ = try await $0.elasticIPs.removeDescription(id: "eip-1")
    },
    Call("delete", "DELETE /elastic-ip/eip-1") { _ = try await $0.elasticIPs.delete(id: "eip-1") },
    Call("attach", "PUT /elastic-ip/eip-1:attach", body: #"{"instance":{"id":"i-1"}}"#) {
        _ = try await $0.elasticIPs.attach(id: "eip-1", toInstance: "i-1")
    },
    Call("detach", "PUT /elastic-ip/eip-1:detach", body: #"{"instance":{"id":"i-1"}}"#) {
        _ = try await $0.elasticIPs.detach(id: "eip-1", fromInstance: "i-1")
    }
])
func elasticIPCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Private network calls send the expected requests", arguments: [
    Call("list", "GET /private-network", response: "{}") { _ = try await $0.privateNetworks.list() },
    Call("get", "GET /private-network/pn-1", response: #"{"id":"pn-1"}"#) {
        _ = try await $0.privateNetworks.get(id: "pn-1")
    },
    Call(
        "create",
        "POST /private-network",
        body: #"{"end-ip":"10.0.0.200","name":"backend","netmask":"255.255.255.0","#
            + #""options":{"dns-servers":["10.0.0.1"]},"start-ip":"10.0.0.100"}"#
    ) {
        _ = try await $0.privateNetworks.create(
            name: "backend",
            startIP: "10.0.0.100",
            endIP: "10.0.0.200",
            netmask: "255.255.255.0",
            options: .init(dnsServers: ["10.0.0.1"])
        )
    },
    Call("update", "PUT /private-network/pn-1", body: #"{"name":"backend-2"}"#) {
        _ = try await $0.privateNetworks.update(id: "pn-1", name: "backend-2")
    },
    Call("remove labels", "DELETE /private-network/pn-1/labels") {
        _ = try await $0.privateNetworks.removeLabels(id: "pn-1")
    },
    Call("delete", "DELETE /private-network/pn-1") { _ = try await $0.privateNetworks.delete(id: "pn-1") },
    Call("attach", "PUT /private-network/pn-1:attach", body: #"{"instance":{"id":"i-1"},"ip":"10.0.0.150"}"#) {
        _ = try await $0.privateNetworks.attach(instanceID: "i-1", to: "pn-1", ip: "10.0.0.150")
    },
    Call("detach", "PUT /private-network/pn-1:detach", body: #"{"instance":{"id":"i-1"}}"#) {
        _ = try await $0.privateNetworks.detach(instanceID: "i-1", from: "pn-1")
    },
    Call("set IP", "PUT /private-network/pn-1:update-ip", body: #"{"instance":{"id":"i-1"},"ip":"10.0.0.151"}"#) {
        _ = try await $0.privateNetworks.setIP("10.0.0.151", forInstance: "i-1", in: "pn-1")
    }
])
func privateNetworkCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Security groups decode their rules")
func decodeSecurityGroups() async throws {
    let group = try await decode(
        #"{"id":"sg-1","name":"web","external-sources":["198.51.100.0/24"],"rules":["#
            + #"{"id":"r-1","flow-direction":"ingress","protocol":"tcp","start-port":80,"end-port":80,"#
            + #""network":"0.0.0.0/0"},"#
            + #"{"id":"r-2","flow-direction":"egress","protocol":"all","#
            + #""security-group":{"id":"sg-2","name":"db","visibility":"private"}}]}"#,
        from: "/security-group/sg-1"
    ) { try await $0.securityGroups.get(id: "sg-1") }
    #expect(group == .init(
        id: "sg-1",
        name: "web",
        rules: [
            .init(id: "r-1", flowDirection: .ingress, protocol: .tcp, startPort: 80, endPort: 80, network: "0.0.0.0/0"),
            .init(
                id: "r-2",
                flowDirection: .egress,
                protocol: .all,
                securityGroup: .init(id: "sg-2", name: "db", visibility: .private)
            )
        ],
        externalSources: ["198.51.100.0/24"]
    ))
}

@Test("Elastic IPs decode their health check")
func decodeElasticIPs() async throws {
    let address = try await decode(
        #"{"id":"eip-1","ip":"203.0.113.5","addressfamily":"inet4","cidr":"203.0.113.5/32","#
            + #""healthcheck":{"mode":"http","port":80,"uri":"/","interval":10,"timeout":2,"#
            + #""strikes-ok":2,"strikes-fail":3},"#
            + #""labels":{"env":"prod"}}"#,
        from: "/elastic-ip/eip-1"
    ) { try await $0.elasticIPs.get(id: "eip-1") }
    #expect(address == .init(
        id: "eip-1",
        ip: "203.0.113.5",
        addressFamily: .ipv4,
        cidr: "203.0.113.5/32",
        healthcheck: .init(mode: .http, port: 80, uri: "/", interval: 10, timeout: 2, strikesOK: 2, strikesFail: 3),
        labels: ["env": "prod"]
    ))
}

@Test("Private networks decode their options and leases")
func decodePrivateNetworks() async throws {
    let network = try await decode(
        #"{"id":"pn-1","name":"backend","start-ip":"10.0.0.100","end-ip":"10.0.0.200","netmask":"255.255.255.0","#
            + #""vni":42,"options":{"routers":["10.0.0.1"],"domain-search":["internal"]},"#
            + #""leases":[{"ip":"10.0.0.100","instance-id":"i-1"}]}"#,
        from: "/private-network/pn-1"
    ) { try await $0.privateNetworks.get(id: "pn-1") }
    #expect(network == .init(
        id: "pn-1",
        name: "backend",
        startIP: "10.0.0.100",
        endIP: "10.0.0.200",
        netmask: "255.255.255.0",
        vni: 42,
        options: .init(routers: ["10.0.0.1"], domainSearch: ["internal"]),
        leases: [.init(ip: "10.0.0.100", instanceID: "i-1")]
    ))
}
