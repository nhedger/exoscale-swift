import Foundation
import Testing

@testable import Exoscale

@Test("CreateDomainRequest encodes request body")
func createDomainRequestEncodesRequestBody() throws {
    let request = CreateDomainRequest(unicodeName: "example.com")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["unicode-name"] == "example.com")
}

@Test("ListDomainsResponse decodes domains")
func listDomainsResponseDecodesDomains() throws {
    let data = Data(
        """
        {
          "dns-domains": [
            {
              "id": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
              "created-at": "2026-04-27T10:00:00Z",
              "unicode-name": "example.com"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListDomainsResponse.self, from: data)

    #expect(response.domains.count == 1)
    #expect(response.domains[0].id == "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")
    #expect(response.domains[0].createdAt == "2026-04-27T10:00:00Z")
    #expect(response.domains[0].unicodeName == "example.com")
}

@Test("DomainZoneFileResponse decodes zone file")
func domainZoneFileResponseDecodesZoneFile() throws {
    let data = Data(
        """
        {
          "zone-file": "$ORIGIN example.com.\\n@ 3600 IN SOA ns1.example.com. hostmaster.example.com. 1 3600 600 604800 3600"
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(DomainZoneFileResponse.self, from: data)

    #expect(response.zoneFile.contains("$ORIGIN example.com."))
}
