import Foundation
import Testing

@testable import Exoscale

@Test("CreateRoleRequest encodes request body")
func createRoleRequestEncodesRequestBody() throws {
    let policy = Exoscale.IAMPolicy(
        defaultServiceStrategy: .allow,
        services: [
            "compute": .init(
                type: .rules,
                rules: [
                    .init(action: .allow, expression: "true", resources: ["*"])
                ]
            )
        ]
    )
    let request = CreateRoleRequest(
        name: "admin-role",
        description: "Admin role",
        permissions: [.bypassGovernanceRetention],
        editable: true,
        labels: ["env": "prod"],
        policy: policy,
        assumeRolePolicy: policy,
        maxSessionTTL: 3600
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "admin-role")
    #expect(object["description"] as? String == "Admin role")
    #expect(object["editable"] as? Bool == true)
    #expect(object["max-session-ttl"] as? Int == 3600)
}

@Test("ListRolesResponse decodes roles")
func listRolesResponseDecodesRoles() throws {
    let data = Data(
        """
        {
          "iam-roles": [
            {
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "admin-role",
              "description": "Admin role",
              "labels": { "env": "prod" },
              "permissions": ["bypass-governance-retention"],
              "assume-role-policy": {
                "default-service-strategy": "allow",
                "services": {
                  "compute": {
                    "type": "rules",
                    "rules": [
                      {
                        "action": "allow",
                        "expression": "true",
                        "resources": ["*"]
                      }
                    ]
                  }
                }
              },
              "editable": true,
              "max-session-ttl": 3600,
              "policy": {
                "default-service-strategy": "deny",
                "services": {
                  "compute": {
                    "type": "allow"
                  }
                }
              }
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListRolesResponse.self, from: data)

    #expect(response.roles.count == 1)
    #expect(response.roles[0].id == "11111111-1111-1111-1111-111111111111")
    #expect(response.roles[0].name == "admin-role")
    #expect(response.roles[0].permissions == [.bypassGovernanceRetention])
    #expect(response.roles[0].assumeRolePolicy?.defaultServiceStrategy == .allow)
    #expect(response.roles[0].policy?.defaultServiceStrategy == .deny)
    #expect(response.roles[0].editable == true)
    #expect(response.roles[0].maxSessionTTL == 3600)
}

@Test("AssumeRoleRequest encodes request body")
func assumeRoleRequestEncodesRequestBody() throws {
    let request = AssumeRoleRequest(ttl: 900)
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Int])

    #expect(object["ttl"] == 900)
}

@Test("AssumedRoleCredentials decodes temporary credentials")
func assumedRoleCredentialsDecodeTemporaryCredentials() throws {
    let data = Data(
        """
        {
          "key": "EXOassumed",
          "name": "assumed-role-key",
          "org-id": "org-123",
          "role-id": "role-123",
          "secret": "secret-value"
        }
        """.utf8
    )

    let credentials = try JSONDecoder().decode(Exoscale.AssumedRoleCredentials.self, from: data)

    #expect(credentials.key == "EXOassumed")
    #expect(credentials.name == "assumed-role-key")
    #expect(credentials.orgID == "org-123")
    #expect(credentials.roleID == "role-123")
    #expect(credentials.secret == "secret-value")
}
