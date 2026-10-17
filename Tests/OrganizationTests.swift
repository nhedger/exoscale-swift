@testable import Exoscale
import Foundation
import Testing

@Test("Organization calls send the expected requests", arguments: [
    Call("get", "GET /organization", response: #"{"id":"org-1"}"#) { _ = try await $0.organization.get() },
    Call("live balance", "GET /live-balance") { _ = try await $0.organization.liveBalance() },
    Call("usage", "GET /usage-report", query: ["period": "2026-09"], response: "{}") {
        _ = try await $0.organization.usage(period: "2026-09")
    },
    Call("focus report", "GET /focus-report/2026-09") { _ = try await $0.organization.focusReport(period: "2026-09") },
    Call(
        "impact report",
        "GET /environmental-impact/report",
        query: ["from": "2026-09-01", "to": "2026-09-30"],
        response: #"{"impact":{},"zones":{}}"#
    ) {
        _ = try await $0.environmentalImpact.report(from: "2026-09-01", to: "2026-09-30")
    },
    Call(
        "impact estimate",
        "POST /environmental-impact/estimate",
        body: #"{"metadata":{"disk-size":50},"sku":"compute:*:instance:standard:medium"}"#,
        response: #"{"impact":{}}"#
    ) {
        _ = try await $0.environmentalImpact.estimate(
            sku: "compute:*:instance:standard:medium",
            metadata: ["disk-size": 50]
        )
    }
])
func organizationCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Organization details, balance, usage and FOCUS reports decode")
func decodeOrganization() async throws {
    let organization = try await decode(
        #"{"id":"org-1","name":"Example","city":"Geneva","country":"CH","currency":"CHF","balance":12.5}"#,
        from: "/organization"
    ) { try await $0.organization.get() }
    #expect(organization == .init(id: "org-1", name: "Example", city: "Geneva", country: "CH", currency: "CHF"))

    let balance = try await decode(#"{"balance":-12.5,"currency":"EUR"}"#, from: "/live-balance") {
        try await $0.organization.liveBalance()
    }
    #expect(balance == .init(balance: -12.5, currency: "EUR"))

    let usage = try await decode(
        #"{"usage":[{"product":"compute","variable":"instance-hours","quantity":"12.5","unit":"hours"}]}"#,
        from: "/usage-report"
    ) { try await $0.organization.usage() }
    #expect(usage == [.init(product: "compute", variable: "instance-hours", quantity: "12.5", unit: "hours")])

    let report = try await decode(
        #"{"presigned_url":"https://sos/report.csv","expires_in":3600}"#,
        from: "/focus-report/2026-09"
    ) { try await $0.organization.focusReport(period: "2026-09") }
    #expect(report == .init(presignedURL: "https://sos/report.csv", expiresIn: 3600))
}

@Test("Impact reports decode the zone and catalog tree")
func decodeImpactReport() async throws {
    let gwp = Exoscale.ImpactValue(unit: "kgCO2e", value: 12.5)
    let hours = Exoscale.ImpactValue(unit: "hours", value: 720)
    let impact = #"{"gwp":{"unit":"kgCO2e","value":12.5}}"#
    let usage = #"{"unit":"hours","value":720}"#
    let skuJSON = #"{"impact":"# + impact + #","usage":"# + usage + #","resources":{}}"#
    let computeJSON = #"{"impact":"# + impact + #","usage":"# + usage
        + #","resources":{"compute:ch-gva-2:instance:standard:medium":"# + skuJSON + "}}"
    let report = try await decode(
        #"{"impact":"# + impact + #","zones":{"ch-gva-2":{"impact":"# + impact
            + #","resources":{"compute":"# + computeJSON + "}}}}",
        from: "/environmental-impact/report"
    ) { try await $0.environmentalImpact.report() }

    let sku = Exoscale.ImpactReport.ResourceImpact(impact: ["gwp": gwp], usage: hours)
    let compute = Exoscale.ImpactReport.ResourceImpact(
        impact: ["gwp": gwp],
        usage: hours,
        resources: ["compute:ch-gva-2:instance:standard:medium": sku]
    )
    #expect(report == .init(
        impact: ["gwp": gwp],
        zones: ["ch-gva-2": .init(impact: ["gwp": gwp], resources: ["compute": compute])]
    ))
}

@Test("Impact estimates are keyed by SKU, then by indicator")
func decodeImpactEstimate() async throws {
    let stub =
        try Stub(
            json: #"{"impact":{"compute:ch-gva-2:instance:standard:medium":{"gwp":{"unit":"kgCO2e","value":0.02}}}}"#
        )
    let estimate = try await stub.exoscale.environmentalImpact
        .estimate(sku: "compute:ch-gva-2:instance:standard:medium")
    #expect(estimate == ["compute:ch-gva-2:instance:standard:medium": ["gwp": .init(unit: "kgCO2e", value: 0.02)]])
}

@Test("Impact errors carry the API's detail")
func impactErrorDetail() async throws {
    let stub = try Stub(StubResponse(
        statusCode: 400,
        body: #"{"title":"Bad Request","status":400,"detail":"to is before from"}"#
    ))
    await #expect(throws: Exoscale.APIError.self) {
        try await stub.exoscale.environmentalImpact.report(from: "2026-09-30", to: "2026-09-01")
    }
    do {
        _ = try await stub.exoscale.environmentalImpact.report()
    } catch let error as Exoscale.APIError {
        #expect(error.message == "to is before from")
    }
}

@Test("JSON values decode and encode every JSON type")
func jsonValues() throws {
    let json = #"{"array":[1,2.5,"three",true,null],"nested":{"key":"value"}}"#
    let value = try JSON.decoder().decode(Exoscale.JSONValue.self, from: Data(json.utf8))
    #expect(value == ["array": [1, 2.5, "three", true, nil], "nested": ["key": "value"]])
    #expect(try String(bytes: JSON.encoder().encode(value), encoding: .utf8) == json)
}
