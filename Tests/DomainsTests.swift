@testable import Exoscale
import Foundation
import Testing

@Test("CreateDomainBody encodes request body")
func createDomainRequestEncodesRequestBody() throws {
    let request = CreateDomainBody(unicodeName: "example.com")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["unicode-name"] == "example.com")
}

@Test("ListDomainsData decodes domains")
func listDomainsResponseDecodesDomains() throws {
    let data = DomainsFixtures.data

    let response = try Exoscale.jsonDecoder().decode(ListDomainsData.self, from: data)

    #expect(response.domains.count == 1)
    #expect(response.domains[0].id == "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")
    #expect(response.domains[0].createdAt == Date(timeIntervalSince1970: 1_777_284_000))
    #expect(response.domains[0].unicodeName == "example.com")
}

@Test("DomainZoneFileData decodes zone file")
func domainZoneFileResponseDecodesZoneFile() throws {
    let data = DomainsFixtures.data2

    let response = try JSONDecoder().decode(DomainZoneFileData.self, from: data)

    #expect(response.zoneFile.contains("$ORIGIN example.com."))
}
