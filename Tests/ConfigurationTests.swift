@testable import Exoscale
import Foundation
import Testing

@Test("The environment provides credentials, zone and User-Agent")
func configurationFromEnvironment() throws {
    let configuration = try Exoscale.Configuration.fromEnvironment([
        "EXOSCALE_API_KEY": "EXOkey",
        "EXOSCALE_API_SECRET": "secret",
        "EXOSCALE_ZONE": "de-fra-1",
        "EXOSCALE_USER_AGENT": "my-app"
    ])
    #expect(configuration.apiKey == "EXOkey")
    #expect(configuration.apiSecret == "secret")
    #expect(configuration.zone == .deFra1)
    #expect(configuration.userAgent == "my-app")
}

@Test("Zone and User-Agent default when the environment doesn't set them")
func configurationDefaults() throws {
    let configuration = try Exoscale.Configuration.fromEnvironment([
        "EXOSCALE_API_KEY": "EXOkey",
        "EXOSCALE_API_SECRET": "secret",
        "EXOSCALE_ZONE": ""
    ])
    #expect(configuration.zone == .chGva2)
    #expect(configuration.userAgent == Exoscale.Configuration.defaultUserAgent)
}

@Test("Missing or empty credentials are rejected", arguments: [
    [:],
    ["EXOSCALE_API_KEY": "EXOkey"],
    ["EXOSCALE_API_KEY": "", "EXOSCALE_API_SECRET": "secret"]
] as [[String: String]])
func configurationMissingCredentials(environment: [String: String]) {
    #expect(throws: Exoscale.ClientError.missingCredentials) {
        try Exoscale.Configuration.fromEnvironment(environment)
    }
}

@Test("Descriptions and mirrors never contain the API secret")
func configurationRedactsSecret() {
    let configuration = Exoscale.Configuration(apiKey: "EXOkey", apiSecret: "top-secret")
    var dumped = ""
    dump(configuration, to: &dumped)
    for text in [configuration.description, configuration.debugDescription, String(reflecting: configuration), dumped] {
        #expect(!text.contains("top-secret"))
        #expect(text.contains("EXOkey"))
    }
}

@Test("Zones map to their API endpoint", arguments: [
    (Exoscale.Zone.chGva2, "https://api-ch-gva-2.exoscale.com/v2"),
    (.esMad1, "https://api-es-mad-1.exoscale.com/v2"),
    ("xx-new-9", "https://api-xx-new-9.exoscale.com/v2")
])
func zoneEndpoints(zone: Exoscale.Zone, endpoint: String) {
    #expect(zone.apiEndpoint?.absoluteString == endpoint)
}

@Test("A zone that can't be part of a hostname is rejected", arguments: ["", "CH-GVA-2", "ch_gva", "evil.com/x", "-ch"])
func invalidZones(zone: String) {
    #expect(throws: Exoscale.ClientError.invalidZone(zone)) {
        try Exoscale(apiKey: "EXOkey", apiSecret: "secret", zone: Exoscale.Zone(rawValue: zone))
    }
}
