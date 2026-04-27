import Foundation
import Testing

@testable import Exoscale

@Test("CreateElasticIPRequest encodes request body")
func createElasticIPRequestEncodesRequestBody() throws {
    let request = CreateElasticIPRequest(
        addressFamily: .inet4,
        description: "public ingress",
        healthcheck: .init(
            strikesOK: 2,
            tlsSkipVerify: true,
            tlsSNI: "example.com",
            strikesFail: 3,
            mode: .https,
            port: 443,
            uri: "/health",
            interval: 10,
            timeout: 2
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
}

@Test("ElasticIPInstanceRequest encodes instance reference")
func elasticIPInstanceRequestEncodesInstanceReference() throws {
    let request = ElasticIPInstanceRequest(instanceID: "11111111-1111-1111-1111-111111111111")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let instance = try #require(object["instance"] as? [String: String])

    #expect(instance["id"] == "11111111-1111-1111-1111-111111111111")
}

@Test("ListElasticIPsResponse decodes Elastic IPs")
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

    let response = try JSONDecoder().decode(ListElasticIPsResponse.self, from: data)

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
