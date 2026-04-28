import Foundation
import Testing

@testable import Exoscale

@Test("ListZonesResponse decodes zones")
func listZonesResponseDecodesZones() throws {
    let data = Data(
        """
        {
          "zones": [
            {
              "name": "ch-gva-2",
              "api-endpoint": "https://api-ch-gva-2.exoscale.com/v2",
              "sos-endpoint": "https://sos-ch-gva-2.exo.io"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListZonesResponse.self, from: data)

    #expect(response.zones.count == 1)
    #expect(response.zones[0].name == .chGva2)
    #expect(response.zones[0].apiEndpoint == URL(string: "https://api-ch-gva-2.exoscale.com/v2"))
    #expect(response.zones[0].sosEndpoint == URL(string: "https://sos-ch-gva-2.exo.io"))
}
