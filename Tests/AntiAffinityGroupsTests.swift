@testable import Exoscale
import Foundation
import Testing

@Test("CreateAntiAffinityGroupBody encodes request body")
func createAntiAffinityGroupRequestEncodesRequestBody() throws {
    let request = CreateAntiAffinityGroupBody(
        name: "spread-web",
        description: "Spread web instances"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "spread-web")
    #expect(object["description"] == "Spread web instances")
}

@Test("ListAntiAffinityGroupsData decodes groups")
func listAntiAffinityGroupsResponseDecodesGroups() throws {
    let data = Data(
        """
        {
          "anti-affinity-groups": [
            {
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "spread-web",
              "description": "Spread web instances",
              "instances": [
                {
                  "id": "22222222-2222-2222-2222-222222222222",
                  "name": "web-1",
                  "state": "running",
                  "public-ip": "203.0.113.10",
                  "instance-type": {
                    "id": "33333333-3333-3333-3333-333333333333",
                    "size": "medium",
                    "family": "standard"
                  },
                  "template": {
                    "id": "44444444-4444-4444-4444-444444444444",
                    "name": "Linux template"
                  }
                }
              ]
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListAntiAffinityGroupsData.self, from: data)
    let group = try #require(response.antiAffinityGroups.first)

    #expect(group.id == "11111111-1111-1111-1111-111111111111")
    #expect(group.name == "spread-web")
    #expect(group.description == "Spread web instances")
    #expect(group.instances?.first?.id == "22222222-2222-2222-2222-222222222222")
    #expect(group.instances?.first?.name == "web-1")
    #expect(group.instances?.first?.state == .running)
    #expect(group.instances?.first?.instanceType?.family == .standard)
    #expect(group.instances?.first?.template?.id == "44444444-4444-4444-4444-444444444444")
}

@Test("Anti-affinity group lists accept unnamed instances", arguments: [
    #"{"id":"instance-1"}"#,
    #"{"id":"instance-1","name":null}"#
])
func antiAffinityGroupListAcceptsUnnamedInstances(member: String) throws {
    // Arrange
    let client = try Exoscale(apiKey: "key", apiSecret: "secret", zone: .chDk2)
    let data = Data("""
    {"anti-affinity-groups":[{"id":"group-1","name":"spread-web","instances":[
        \(member), {"id":"instance-2","name":"web-2"}
    ]}]}
    """.utf8)

    // Act
    let payload = try JSONDecoder().decode(ListAntiAffinityGroupsData.self, from: data)
    let groups = AntiAffinityGroupsOperations.List.Response(data: payload).transform(client: client.http)
    let group = try #require(groups.first)

    // Assert
    #expect(group.instances?.map(\.id) == ["instance-1", "instance-2"])
    #expect(group.instances?.map(\.name) == [nil, "web-2"])
}

@Test("Anti-affinity group details accept unnamed instances", arguments: [
    #"{"id":"instance-1"}"#,
    #"{"id":"instance-1","name":null}"#
])
func antiAffinityGroupDetailsAcceptsUnnamedInstances(member: String) throws {
    // Arrange
    let client = try Exoscale(apiKey: "key", apiSecret: "secret", zone: .chDk2)
    let data = Data("""
    {"id":"group-1","name":"spread-web","instances":[\(member)]}
    """.utf8)

    // Act
    let payload = try JSONDecoder().decode(Exoscale.AntiAffinityGroup.Payload.self, from: data)
    let group = AntiAffinityGroupsOperations.Get.Response(data: payload).transform(client: client.http)
    let instance = try #require(group.instances?.first)

    // Assert
    #expect(instance.id == "instance-1")
    #expect(instance.name == nil)
}
