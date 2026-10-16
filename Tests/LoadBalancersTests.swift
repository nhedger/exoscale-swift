@testable import Exoscale
import Foundation
import Testing

@Test("CreateLoadBalancerBody encodes request body")
func createLoadBalancerRequestEncodesRequestBody() throws {
    let request = CreateLoadBalancerBody(
        name: "public-web",
        description: "Public web traffic",
        labels: ["env": "prod"]
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "public-web")
    #expect(object["description"] as? String == "Public web traffic")
    #expect((object["labels"] as? [String: String])?["env"] == "prod")
}

@Test("UpdateLoadBalancerBody encodes request body")
func updateLoadBalancerRequestEncodesRequestBody() throws {
    let request = UpdateLoadBalancerBody(
        name: "private-web",
        description: "Private web traffic",
        labels: ["env": "staging"]
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "private-web")
    #expect(object["description"] as? String == "Private web traffic")
    #expect((object["labels"] as? [String: String])?["env"] == "staging")
}

@Test("AddLoadBalancerServiceBody encodes request body")
func addLoadBalancerServiceRequestEncodesRequestBody() throws {
    let request = AddLoadBalancerServiceBody(
        name: "https",
        description: "HTTPS traffic",
        instancePool: LoadBalancerInstancePoolReference(id: "11111111-1111-1111-1111-111111111111"),
        networkProtocol: .tcp,
        strategy: .sourceHash,
        port: 443,
        targetPort: 8443,
        healthcheck: .init(
            mode: .https,
            interval: 10,
            uri: "/health",
            port: 8443,
            timeout: 2,
            retries: 3,
            tlsSNI: "example.com"
        )
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "https")
    #expect(object["description"] as? String == "HTTPS traffic")
    #expect(object["protocol"] as? String == "tcp")
    #expect(object["strategy"] as? String == "source-hash")
    #expect(object["port"] as? Int == 443)
    #expect(object["target-port"] as? Int == 8443)

    let instancePool = try #require(object["instance-pool"] as? [String: String])
    let healthcheck = try #require(object["healthcheck"] as? [String: Any])

    #expect(instancePool["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(healthcheck["mode"] as? String == "https")
    #expect(healthcheck["interval"] as? Int == 10)
    #expect(healthcheck["uri"] as? String == "/health")
    #expect(healthcheck["port"] as? Int == 8443)
    #expect(healthcheck["timeout"] as? Int == 2)
    #expect(healthcheck["retries"] as? Int == 3)
    #expect(healthcheck["tls-sni"] as? String == "example.com")
}

@Test("UpdateLoadBalancerServiceBody encodes request body")
func updateLoadBalancerServiceRequestEncodesRequestBody() throws {
    let request = UpdateLoadBalancerServiceBody(
        name: "udp",
        description: "UDP traffic",
        networkProtocol: .udp,
        strategy: .maglevHash,
        port: 53,
        targetPort: 5353,
        healthcheck: .init(mode: .tcp, interval: 15, port: 5353, timeout: 3, retries: 2)
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "udp")
    #expect(object["description"] as? String == "UDP traffic")
    #expect(object["protocol"] as? String == "udp")
    #expect(object["strategy"] as? String == "maglev-hash")
    #expect(object["port"] as? Int == 53)
    #expect(object["target-port"] as? Int == 5353)
    #expect((object["healthcheck"] as? [String: Any])?["mode"] as? String == "tcp")
}

@Test("ListLoadBalancersData decodes load balancers")
func listLoadBalancersResponseDecodesLoadBalancers() throws {
    let data = LoadBalancersFixtures.data

    let response = try Exoscale.jsonDecoder().decode(ListLoadBalancersData.self, from: data)
    let loadBalancer = try #require(response.loadBalancers.first)
    let service = try #require(loadBalancer.services?.first)

    #expect(loadBalancer.id == "22222222-2222-2222-2222-222222222222")
    #expect(loadBalancer.description == "Public web traffic")
    #expect(loadBalancer.name == "public-web")
    #expect(loadBalancer.state == .running)
    #expect(loadBalancer.createdAt == Date(timeIntervalSince1970: 1_777_284_000))
    #expect(loadBalancer.ip == "203.0.113.20")
    #expect(loadBalancer.labels == ["env": "prod"])
    #expect(service.id == "33333333-3333-3333-3333-333333333333")
    #expect(service.description == "HTTPS traffic")
    #expect(service.networkProtocol == .tcp)
    #expect(service.name == "https")
    #expect(service.state == .running)
    #expect(service.targetPort == 8443)
    #expect(service.port == 443)
    #expect(service.instancePool?.id == "44444444-4444-4444-4444-444444444444")
    #expect(service.strategy == .sourceHash)
    #expect(service.healthcheck?.mode == .https)
    #expect(service.healthcheck?.tlsSNI == "example.com")
    #expect(service.healthcheckStatus?.first?.publicIP == "198.51.100.10")
    #expect(service.healthcheckStatus?.first?.status == .success)
}
