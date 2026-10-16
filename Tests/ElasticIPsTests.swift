@testable import Exoscale
import Foundation
import Testing

@Test("CreateElasticIPBody encodes request body")
func createElasticIPRequestEncodesRequestBody() throws {
    let request = CreateElasticIPBody(
        addressFamily: .inet4,
        description: "public ingress",
        healthcheck: .init(
            mode: .https,
            port: 443,
            uri: "/health",
            interval: 10,
            timeout: 2,
            strikesOK: 2,
            strikesFail: 3,
            tlsSNI: "example.com",
            tlsSkipVerify: true
        ),
        labels: ["env": "prod"]
    )
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["addressfamily"] as? String == "inet4")
    #expect(object["description"] as? String == "public ingress")
    #expect((object["labels"] as? [String: String])?["env"] == "prod")
    let healthcheck = try #require(object["healthcheck"] as? [String: Any])
    #expect(healthcheck["mode"] as? String == "https")
    #expect(healthcheck["port"] as? Int == 443)
    #expect(healthcheck["uri"] as? String == "/health")
    #expect(healthcheck["interval"] as? Int == 10)
    #expect(healthcheck["timeout"] as? Int == 2)
    #expect(healthcheck["strikes-ok"] as? Int == 2)
    #expect(healthcheck["strikes-fail"] as? Int == 3)
    #expect(healthcheck["tls-sni"] as? String == "example.com")
    #expect(healthcheck["tls-skip-verify"] as? Bool == true)
}

@Test("ElasticIPInstanceBody encodes instance reference")
func elasticIPInstanceRequestEncodesInstanceReference() throws {
    let request = ElasticIPInstanceBody(instanceID: "11111111-1111-1111-1111-111111111111")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let instance = try #require(object["instance"] as? [String: String])

    #expect(instance["id"] == "11111111-1111-1111-1111-111111111111")
}

@Test("ListElasticIPsData decodes Elastic IPs")
func listElasticIPsResponseDecodesElasticIPs() throws {
    let data = Data(
        """
        {
          "elastic-ips": [
            {
              "id": "22222222-2222-2222-2222-222222222222",
              "ip": "203.0.113.10",
              "addressfamily": "inet4",
              "cidr": "203.0.113.10/32",
              "description": "public ingress",
              "healthcheck": {
                "strikes-ok": 2,
                "tls-skip-verify": true,
                "tls-sni": "example.com",
                "strikes-fail": 3,
                "mode": "https",
                "port": 443,
                "uri": "/health",
                "interval": 10,
                "timeout": 2
              },
              "labels": {
                "env": "prod"
              }
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListElasticIPsData.self, from: data)

    #expect(response.elasticIPs.count == 1)
    #expect(response.elasticIPs[0].id == "22222222-2222-2222-2222-222222222222")
    #expect(response.elasticIPs[0].ip == "203.0.113.10")
    #expect(response.elasticIPs[0].addressFamily == .inet4)
    #expect(response.elasticIPs[0].cidr == "203.0.113.10/32")
    #expect(response.elasticIPs[0].description == "public ingress")
    #expect(response.elasticIPs[0].healthcheck?.mode == .https)
    #expect(response.elasticIPs[0].healthcheck?.port == 443)
    #expect(response.elasticIPs[0].labels == ["env": "prod"])
}
