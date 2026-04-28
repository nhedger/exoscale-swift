import Foundation
import Testing

@testable import Exoscale

@Test("Organization decodes organization details")
func organizationDecodesOrganizationDetails() throws {
    let data = Data(
        """
        {
          "id": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
          "name": "Example Org",
          "address": "123 Example Street",
          "postcode": "1200",
          "city": "Geneva",
          "country": "CH",
          "balance": 42.5,
          "currency": "CHF"
        }
        """.utf8
    )

    let organization = try JSONDecoder().decode(Exoscale.Organization.self, from: data)

    #expect(organization.id == "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")
    #expect(organization.name == "Example Org")
    #expect(organization.address == "123 Example Street")
    #expect(organization.postcode == "1200")
    #expect(organization.city == "Geneva")
    #expect(organization.country == "CH")
    #expect(organization.balance == 42.5)
    #expect(organization.currency == "CHF")
}

@Test("UsageReport decodes usage entries")
func usageReportDecodesUsageEntries() throws {
    let data = Data(
        """
        {
          "usage": [
            {
              "from": "2026-04-01",
              "to": "2026-04-30",
              "product": "compute",
              "variable": "instance-hours",
              "description": "Compute usage",
              "quantity": "12",
              "unit": "hours"
            }
          ]
        }
        """.utf8
    )

    let report = try JSONDecoder().decode(Exoscale.UsageReport.self, from: data)

    #expect(report.usage.count == 1)
    #expect(report.usage[0].from == "2026-04-01")
    #expect(report.usage[0].to == "2026-04-30")
    #expect(report.usage[0].product == "compute")
    #expect(report.usage[0].variable == "instance-hours")
    #expect(report.usage[0].description == "Compute usage")
    #expect(report.usage[0].quantity == "12")
    #expect(report.usage[0].unit == "hours")
}

@Test("EnvImpactReport decodes environmental impact report")
func envImpactReportDecodesEnvironmentalImpactReport() throws {
    let data = Data(
        """
        {
          "metadata": [
            {
              "value": "period",
              "amount": 202604,
              "unit": "month"
            }
          ],
          "products": [
            {
              "value": "compute",
              "metadata": [
                {
                  "value": "instance-hours",
                  "amount": 12.5,
                  "unit": "hours"
                }
              ],
              "impacts": [
                {
                  "value": "carbon",
                  "amount": 1.25,
                  "unit": "kgCO2e",
                  "details": [
                    {
                      "value": "electricity",
                      "amount": 0.75,
                      "unit": "kgCO2e"
                    }
                  ]
                }
              ]
            }
          ]
        }
        """.utf8
    )

    let report = try JSONDecoder().decode(Exoscale.EnvImpactReport.self, from: data)

    #expect(report.metadata?.first?.value == "period")
    #expect(report.metadata?.first?.amount == 202604)
    #expect(report.metadata?.first?.unit == "month")
    #expect(report.products?.first?.value == "compute")
    #expect(report.products?.first?.metadata?.first?.amount == 12.5)
    #expect(report.products?.first?.impacts?.first?.value == "carbon")
    #expect(report.products?.first?.impacts?.first?.amount == 1.25)
    #expect(report.products?.first?.impacts?.first?.details?.first?.value == "electricity")
    #expect(report.products?.first?.impacts?.first?.details?.first?.amount == 0.75)
}

@Test("Client builds organization environmental impact path")
func clientBuildsOrganizationEnvironmentalImpactPath() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let request = try client.http.makeRequest("GET", path: "/env-impact/2026-04")

    #expect(request.url?.path == "/v2/env-impact/2026-04")
}
