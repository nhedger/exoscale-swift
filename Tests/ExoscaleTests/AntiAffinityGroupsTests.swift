import Foundation
import Testing

@testable import Exoscale

@Test("CreateAntiAffinityGroupRequest encodes request body")
func createAntiAffinityGroupRequestEncodesRequestBody() throws {
    let request = CreateAntiAffinityGroupRequest(
        name: "spread-web",
        description: "Spread web instances"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "spread-web")
    #expect(object["description"] == "Spread web instances")
}

@Test("ListAntiAffinityGroupsResponse decodes groups")
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

    let response = try JSONDecoder().decode(ListAntiAffinityGroupsResponse.self, from: data)
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
