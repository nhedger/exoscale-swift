import Foundation
import Testing

@testable import Exoscale

@Test("ListInstanceTypesResponse decodes instance types")
func listInstanceTypesResponseDecodesInstanceTypes() throws {
    let data = Data(
        """
        {
          "instance-types": [
            {
              "id": "33333333-3333-3333-3333-333333333333",
              "size": "medium",
              "family": "standard",
              "cpus": 2,
              "gpus": 0,
              "authorized": false,
              "memory": 4096,
              "zones": ["ch-gva-2"]
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListInstanceTypesResponse.self, from: data)

    #expect(response.instanceTypes.count == 1)
    #expect(response.instanceTypes[0].id == "33333333-3333-3333-3333-333333333333")
    #expect(response.instanceTypes[0].size == .medium)
    #expect(response.instanceTypes[0].family == .standard)
    #expect(response.instanceTypes[0].cpus == 2)
    #expect(response.instanceTypes[0].memory == 4096)
    #expect(response.instanceTypes[0].zones == [.chGva2])
}
