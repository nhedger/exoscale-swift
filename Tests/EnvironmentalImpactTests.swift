@testable import Exoscale
import Foundation
import Testing

private let reportBody = """
{
  "impact": { "gwp": { "unit": "kgCO2e", "value": 12.5 } },
  "zones": {
    "ch-gva-2": {
      "impact": { "gwp": { "unit": "kgCO2e", "value": 12.5 } },
      "resources": {
        "compute": {
          "impact": { "gwp": { "unit": "kgCO2e", "value": 12.5 } },
          "usage": { "unit": "hours", "value": 720 },
          "resources": {
            "compute:ch-gva-2:instance:standard:medium": {
              "impact": { "gwp": { "unit": "kgCO2e", "value": 12.5 } },
              "usage": { "unit": "hours", "value": 720 },
              "resources": {}
            }
          }
        }
      }
    }
  }
}
"""

private func jsonObject(_ data: Data?) throws -> [String: Any] {
    let data = try #require(data)
    return try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
}

@Test("The impact report sends its period and decodes the zone and catalog breakdown")
func impactReportRequestAndDecoding() async throws {
    let transport = ScriptedTransport([ScriptedResponse(body: Data(reportBody.utf8))])

    let report = try await transport.exoscale().organization.impactReport(from: "2026-09-01", to: "2026-09-30")

    let request = try #require(transport.requests.first)
    #expect(request.httpMethod == "GET")
    #expect(request.url?.path == "/v2/environmental-impact/report")
    #expect(try formDecodedQuery(of: #require(request.url)) == ["from": "2026-09-01", "to": "2026-09-30"])
    #expect(try hasValidSignature(request, secret: "secret"))

    let gwp = Exoscale.ImpactValue(unit: "kgCO2e", value: 12.5)
    let instance = Exoscale.ImpactBreakdown.ResourceImpact(
        impact: ["gwp": gwp],
        usage: Exoscale.ImpactValue(unit: "hours", value: 720)
    )
    let compute = Exoscale.ImpactBreakdown.ResourceImpact(
        impact: ["gwp": gwp],
        usage: Exoscale.ImpactValue(unit: "hours", value: 720),
        resources: ["compute:ch-gva-2:instance:standard:medium": instance]
    )
    #expect(report == Exoscale.ImpactBreakdown(
        impact: ["gwp": gwp],
        zones: ["ch-gva-2": .init(impact: ["gwp": gwp], resources: ["compute": compute])]
    ))
}

@Test("The impact report omits a period that is not given")
func impactReportWithoutPeriod() async throws {
    let transport = ScriptedTransport([ScriptedResponse(body: Data(#"{"impact":{},"zones":{}}"#.utf8))])

    let report = try await transport.exoscale().organization.impactReport()

    #expect(report == Exoscale.ImpactBreakdown())
    #expect(transport.requests.first?.url?.query == nil)
}

@Test("The impact estimate posts its SKU and metadata and decodes indicators per SKU")
func impactEstimateRequestAndDecoding() async throws {
    let body = """
    {
      "impact": {
        "compute:ch-gva-2:instance:standard:medium": { "gwp": { "unit": "kgCO2e", "value": 0.02 } },
        "compute:de-fra-1:instance:standard:medium": { "gwp": { "unit": "kgCO2e", "value": 0.05 } }
      }
    }
    """
    let transport = ScriptedTransport([ScriptedResponse(body: Data(body.utf8))])

    let estimate = try await transport.exoscale().organization.impactEstimate(
        sku: "compute:*:instance:standard:medium",
        metadata: ["disk-size": .integer(50)]
    )

    let request = try #require(transport.requests.first)
    #expect(request.httpMethod == "POST")
    #expect(request.url?.path == "/v2/environmental-impact/estimate")
    #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
    #expect(try hasValidSignature(request, secret: "secret"))
    let sent = try jsonObject(request.httpBody)
    #expect(sent["sku"] as? String == "compute:*:instance:standard:medium")
    #expect(sent["metadata"] as? [String: Int] == ["disk-size": 50])

    #expect(estimate.impact == [
        "compute:ch-gva-2:instance:standard:medium": ["gwp": .init(unit: "kgCO2e", value: 0.02)],
        "compute:de-fra-1:instance:standard:medium": ["gwp": .init(unit: "kgCO2e", value: 0.05)]
    ])
}

@Test("An impact estimate in the published spec's shape is keyed by the requested SKU")
func impactEstimateSingleIndicatorSet() async throws {
    let body = #"{"impact":{"gwp":{"unit":"kgCO2e","value":0.02}}}"#
    let transport = ScriptedTransport([ScriptedResponse(body: Data(body.utf8))])
    let sku = "compute:ch-gva-2:instance:standard:medium"

    let estimate = try await transport.exoscale().organization.impactEstimate(sku: sku)

    #expect(estimate.impact == [sku: ["gwp": .init(unit: "kgCO2e", value: 0.02)]])
    #expect(try jsonObject(transport.requests.first?.httpBody).keys.sorted() == ["sku"])
}

@Test("Environmental impact errors carry the API's detail")
func impactErrorDetail() async throws {
    let body = #"{"title":"Bad Request","status":400,"detail":"to is before from"}"#
    let transport = ScriptedTransport([ScriptedResponse(statusCode: 400, body: Data(body.utf8))])

    do {
        _ = try await transport.exoscale().organization.impactReport(from: "2026-09-30", to: "2026-09-01")
        Issue.record("Expected the API error")
    } catch let error as Exoscale.ApiError {
        #expect(error.message == "to is before from")
    }
}
