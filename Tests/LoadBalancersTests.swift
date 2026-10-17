@testable import Exoscale
import Foundation
import Testing

@Test("Load balancer calls send the expected requests", arguments: [
    Call("list", "GET /load-balancer", response: "{}") { _ = try await $0.loadBalancers.list() },
    Call("get", "GET /load-balancer/lb-1", response: #"{"id":"lb-1"}"#) {
        _ = try await $0.loadBalancers.get(id: "lb-1")
    },
    Call("create", "POST /load-balancer", body: #"{"addressfamily":"inet6","name":"web"}"#) {
        _ = try await $0.loadBalancers.create(name: "web", addressFamily: .ipv6)
    },
    Call("update", "PUT /load-balancer/lb-1", body: #"{"description":"Public web"}"#) {
        _ = try await $0.loadBalancers.update(id: "lb-1", description: "Public web")
    },
    Call("reset", "DELETE /load-balancer/lb-1/labels") { _ = try await $0.loadBalancers.reset(.labels, id: "lb-1") },
    Call("delete", "DELETE /load-balancer/lb-1") { _ = try await $0.loadBalancers.delete(id: "lb-1") },
    Call("get service", "GET /load-balancer/lb-1/service/svc-1", response: #"{"id":"svc-1"}"#) {
        _ = try await $0.loadBalancers.service(id: "svc-1", of: "lb-1")
    },
    Call(
        "add service",
        "POST /load-balancer/lb-1/service",
        body: #"{"healthcheck":{"interval":10,"mode":"http","port":8080,"uri":"/health"},"#
            + #""instance-pool":{"id":"pool-1"},"#
            + #""name":"https","port":443,"protocol":"tcp","strategy":"maglev-hash","target-port":8443}"#
    ) {
        _ = try await $0.loadBalancers.addService(
            to: "lb-1",
            name: "https",
            instancePoolID: "pool-1",
            protocol: .tcp,
            port: 443,
            targetPort: 8443,
            strategy: .maglevHash,
            healthcheck: .init(mode: .http, port: 8080, uri: "/health", interval: 10)
        )
    },
    Call("update service", "PUT /load-balancer/lb-1/service/svc-1", body: #"{"target-port":9443}"#) {
        _ = try await $0.loadBalancers.updateService(id: "svc-1", of: "lb-1", targetPort: 9443)
    },
    Call("remove service description", "DELETE /load-balancer/lb-1/service/svc-1/description") {
        _ = try await $0.loadBalancers.removeServiceDescription(id: "svc-1", of: "lb-1")
    },
    Call("delete service", "DELETE /load-balancer/lb-1/service/svc-1") {
        _ = try await $0.loadBalancers.deleteService(id: "svc-1", of: "lb-1")
    }
])
func loadBalancerCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Reverse DNS calls send the expected requests", arguments: [
    Call("get instance", "GET /reverse-dns/instance/i-1", response: #"{"domain-name":"web.example.com"}"#) {
        _ = try await $0.reverseDNS.domainName(forInstance: "i-1")
    },
    Call("set instance", "POST /reverse-dns/instance/i-1", body: #"{"domain-name":"web.example.com"}"#) {
        _ = try await $0.reverseDNS.setDomainName("web.example.com", forInstance: "i-1")
    },
    Call("remove instance", "DELETE /reverse-dns/instance/i-1") {
        _ = try await $0.reverseDNS.removeDomainName(forInstance: "i-1")
    },
    Call("get Elastic IP", "GET /reverse-dns/elastic-ip/eip-1", response: #"{"domain-name":"api.example.com"}"#) {
        _ = try await $0.reverseDNS.domainName(forElasticIP: "eip-1")
    },
    Call("set Elastic IP", "POST /reverse-dns/elastic-ip/eip-1", body: #"{"domain-name":"api.example.com"}"#) {
        _ = try await $0.reverseDNS.setDomainName("api.example.com", forElasticIP: "eip-1")
    },
    Call("remove Elastic IP", "DELETE /reverse-dns/elastic-ip/eip-1") {
        _ = try await $0.reverseDNS.removeDomainName(forElasticIP: "eip-1")
    }
])
func reverseDNSCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Load balancers decode their services and health")
func decodeLoadBalancers() async throws {
    let balancer = try await decode(
        #"{"id":"lb-1","name":"web","state":"running","ip":"2001:db8::1","addressfamily":"inet6","#
            + #""services":[{"id":"svc-1","name":"https","state":"running","protocol":"tcp","strategy":"round-robin","#
            + #""port":443,"target-port":8443,"instance-pool":{"id":"pool-1"},"#
            + #""healthcheck":{"mode":"tcp","port":8443,"retries":2,"tls-sni":"example.com"},"#
            + #""healthcheck-status":[{"public-ip":"203.0.113.10","status":"failure"}]}]}"#,
        from: "/load-balancer/lb-1"
    ) { try await $0.loadBalancers.get(id: "lb-1") }
    #expect(balancer == .init(
        id: "lb-1",
        name: "web",
        state: .running,
        ip: "2001:db8::1",
        addressFamily: .ipv6,
        services: [.init(
            id: "svc-1",
            name: "https",
            state: .running,
            protocol: .tcp,
            strategy: .roundRobin,
            port: 443,
            targetPort: 8443,
            instancePool: .init(id: "pool-1"),
            healthcheck: .init(mode: .tcp, port: 8443, retries: 2, tlsSNI: "example.com"),
            healthcheckStatus: [.init(publicIP: "203.0.113.10", status: .failure)]
        )]
    ))
}

@Test("Reverse DNS returns the domain name")
func decodeReverseDNS() async throws {
    let name = try await decode(#"{"domain-name":"web.example.com"}"#, from: "/reverse-dns/instance/i-1") {
        try await $0.reverseDNS.domainName(forInstance: "i-1")
    }
    #expect(name == "web.example.com")
}
