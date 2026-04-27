import Foundation
import Testing

@testable import Exoscale

@Test("ListDeployTargetsResponse decodes Deploy Targets")
func listDeployTargetsResponseDecodesDeployTargets() throws {
    let data = Data(
        """
        {
          "deploy-targets": [
            {
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "edge-target",
              "type": "edge",
              "description": "Edge deploy target"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListDeployTargetsResponse.self, from: data)
    let deployTarget = try #require(response.deployTargets.first)

    #expect(deployTarget.id == "11111111-1111-1111-1111-111111111111")
    #expect(deployTarget.name == "edge-target")
    #expect(deployTarget.type == .edge)
    #expect(deployTarget.description == "Edge deploy target")
}
