import Foundation
import Testing

@testable import Exoscale

@Test("IAMPolicy encodes organization policy body")
func iamPolicyEncodesOrganizationPolicyBody() throws {
    let policy = Exoscale.IAMPolicy(
        defaultServiceStrategy: .deny,
        services: [
            "compute": .init(
                type: .rules,
                rules: [
                    .init(action: .allow, expression: "operation == 'list-instances'", resources: ["*"])
                ]
            )
        ]
    )

    let data = try JSONEncoder().encode(policy)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["default-service-strategy"] as? String == "deny")
    let services = try #require(object["services"] as? [String: Any])
    let compute = try #require(services["compute"] as? [String: Any])
    let rules = try #require(compute["rules"] as? [[String: Any]])

    #expect(compute["type"] as? String == "rules")
    #expect(rules.first?["action"] as? String == "allow")
    #expect(rules.first?["expression"] as? String == "operation == 'list-instances'")
    #expect(rules.first?["resources"] as? [String] == ["*"])
}

@Test("IAMPolicy decodes organization policy")
func iamPolicyDecodesOrganizationPolicy() throws {
    let data = Data(
        """
        {
          "default-service-strategy": "allow",
          "services": {
            "compute": {
              "type": "deny"
            },
            "storage": {
              "type": "rules",
              "rules": [
                {
                  "action": "allow",
                  "expression": "true",
                  "resources": ["bucket/example"]
                }
              ]
            }
          }
        }
        """.utf8
    )

    let policy = try JSONDecoder().decode(Exoscale.IAMPolicy.self, from: data)

    #expect(policy.defaultServiceStrategy == .allow)
    #expect(policy.services?["compute"]?.type == .deny)
    #expect(policy.services?["storage"]?.type == .rules)
    #expect(policy.services?["storage"]?.rules?.first?.action == .allow)
    #expect(policy.services?["storage"]?.rules?.first?.expression == "true")
    #expect(policy.services?["storage"]?.rules?.first?.resources == ["bucket/example"])
}
