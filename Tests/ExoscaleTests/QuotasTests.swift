import Foundation
import Testing

@testable import Exoscale

@Test("ListQuotasResponse decodes quotas")
func listQuotasResponseDecodesQuotas() throws {
    let data = Data(
        """
        {
          "quotas": [
            {
              "resource": "instance",
              "usage": 2,
              "limit": 10
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListQuotasResponse.self, from: data)

    #expect(response.quotas.count == 1)
    #expect(response.quotas[0].resource == "instance")
    #expect(response.quotas[0].usage == 2)
    #expect(response.quotas[0].limit == 10)
}

@Test("Quota decodes resource quota")
func quotaDecodesResourceQuota() throws {
    let data = Data(
        """
        {
          "resource": "snapshot",
          "usage": 4,
          "limit": -1
        }
        """.utf8
    )

    let quota = try JSONDecoder().decode(Exoscale.Quota.self, from: data)

    #expect(quota.resource == "snapshot")
    #expect(quota.usage == 4)
    #expect(quota.limit == -1)
}
