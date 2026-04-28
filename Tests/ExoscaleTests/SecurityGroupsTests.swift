import Foundation
import Testing

@testable import Exoscale

@Test("CreateSecurityGroupRequest encodes request body")
func createSecurityGroupRequestEncodesRequestBody() throws {
    let request = CreateSecurityGroupRequest(
        name: "web-sg",
        description: "Web access"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "web-sg")
    #expect(object["description"] == "Web access")
}

@Test("CreateSecurityGroupRuleRequest encodes request body")
func createSecurityGroupRuleRequestEncodesRequestBody() throws {
    let request = CreateSecurityGroupRuleRequest(
        flowDirection: .ingress,
        description: "HTTPS from public load balancers",
        network: "203.0.113.0/24",
        securityGroup: .init(
            id: "11111111-1111-1111-1111-111111111111",
            name: "public-lb",
            visibility: Exoscale.SecurityGroup.Visibility(rawValue: "public")
        ),
        networkProtocol: .tcp,
        icmp: .init(code: -1, type: -1),
        startPort: 443,
        endPort: 443
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["flow-direction"] as? String == "ingress")
    #expect(object["description"] as? String == "HTTPS from public load balancers")
    #expect(object["network"] as? String == "203.0.113.0/24")
    #expect(object["protocol"] as? String == "tcp")
    #expect(object["start-port"] as? Int == 443)
    #expect(object["end-port"] as? Int == 443)

    let securityGroup = try #require(object["security-group"] as? [String: String])
    let icmp = try #require(object["icmp"] as? [String: Int])

    #expect(securityGroup["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(securityGroup["name"] == "public-lb")
    #expect(securityGroup["visibility"] == "public")
    #expect(icmp["code"] == -1)
    #expect(icmp["type"] == -1)
}

@Test("Security Group action requests encode request bodies")
func securityGroupActionRequestsEncodeRequestBodies() throws {
    let sourceData = try JSONEncoder().encode(SecurityGroupExternalSourceRequest(cidr: "198.51.100.0/24"))
    let sourceObject = try #require(JSONSerialization.jsonObject(with: sourceData) as? [String: String])

    let instanceData = try JSONEncoder().encode(
        SecurityGroupInstanceRequest(instance: InstanceIDReference(id: "11111111-1111-1111-1111-111111111111"))
    )
    let instanceObject = try #require(JSONSerialization.jsonObject(with: instanceData) as? [String: [String: String]])

    #expect(sourceObject["cidr"] == "198.51.100.0/24")
    #expect(instanceObject["instance"]?["id"] == "11111111-1111-1111-1111-111111111111")
}

@Test("ListSecurityGroupsResponse decodes Security Groups")
func listSecurityGroupsResponseDecodesSecurityGroups() throws {
    let data = Data(
        """
        {
          "security-groups": [
            {
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "web-sg",
              "description": "Web access",
              "external-sources": ["198.51.100.0/24"],
              "rules": [
                {
                  "id": "22222222-2222-2222-2222-222222222222",
                  "description": "HTTPS ingress",
                  "flow-direction": "ingress",
                  "protocol": "tcp",
                  "network": "203.0.113.0/24",
                  "security-group": {
                    "id": "33333333-3333-3333-3333-333333333333",
                    "name": "public-lb",
                    "visibility": "public"
                  },
                  "icmp": {
                    "code": -1,
                    "type": -1
                  },
                  "start-port": 443,
                  "end-port": 443
                }
              ]
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListSecurityGroupsResponse.self, from: data)
    let securityGroup = try #require(response.securityGroups.first)
    let rule = try #require(securityGroup.rules?.first)

    #expect(securityGroup.id == "11111111-1111-1111-1111-111111111111")
    #expect(securityGroup.name == "web-sg")
    #expect(securityGroup.description == "Web access")
    #expect(securityGroup.externalSources == ["198.51.100.0/24"])
    #expect(rule.id == "22222222-2222-2222-2222-222222222222")
    #expect(rule.description == "HTTPS ingress")
    #expect(rule.flowDirection == .ingress)
    #expect(rule.networkProtocol == .tcp)
    #expect(rule.network == "203.0.113.0/24")
    #expect(rule.securityGroup?.id == "33333333-3333-3333-3333-333333333333")
    #expect(rule.securityGroup?.name == "public-lb")
    #expect(rule.securityGroup?.visibility?.rawValue == "public")
    #expect(rule.icmp?.code == -1)
    #expect(rule.icmp?.type == -1)
    #expect(rule.startPort == 443)
    #expect(rule.endPort == 443)
}

@Test("Client builds Security Group query and action paths")
func clientBuildsSecurityGroupQueryAndActionPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let listRequest = try client.http.makeRequest(
        "GET",
        path: "/security-group",
        query: ["visibility": "public"]
    )
    let createRuleRequest = try client.http.makeRequest("POST", path: "/security-group/group-id/rules")
    let deleteRuleRequest = try client.http.makeRequest("DELETE", path: "/security-group/group-id/rules/rule-id")
    let addSourceRequest = try client.http.makeRequest("PUT", path: "/security-group/group-id:add-source")
    let removeSourceRequest = try client.http.makeRequest("PUT", path: "/security-group/group-id:remove-source")
    let attachRequest = try client.http.makeRequest("PUT", path: "/security-group/group-id:attach")
    let detachRequest = try client.http.makeRequest("PUT", path: "/security-group/group-id:detach")

    let url = try #require(listRequest.url)
    let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    let queryItems = Dictionary(uniqueKeysWithValues: try #require(components.queryItems).map { ($0.name, $0.value) })

    #expect(queryItems["visibility"] == "public")
    #expect(createRuleRequest.url?.path == "/v2/security-group/group-id/rules")
    #expect(deleteRuleRequest.url?.path == "/v2/security-group/group-id/rules/rule-id")
    #expect(addSourceRequest.url?.path == "/v2/security-group/group-id:add-source")
    #expect(removeSourceRequest.url?.path == "/v2/security-group/group-id:remove-source")
    #expect(attachRequest.url?.path == "/v2/security-group/group-id:attach")
    #expect(detachRequest.url?.path == "/v2/security-group/group-id:detach")
}
