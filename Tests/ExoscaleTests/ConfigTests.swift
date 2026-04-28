import Foundation
import Testing

@testable import Exoscale

@Test("Config stores explicit values and zone endpoints")
func configStoresExplicitValuesAndZoneDerivedEndpoints() throws {
    let config = try Exoscale.Config(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2,
        userAgent: "exoscale-swift-tests/1.0",
        environment: [:]
    )

    #expect(config.apiKey == "key")
    #expect(config.apiSecret == "secret")
    #expect(config.userAgent == "exoscale-swift-tests/1.0")
    #expect(config.zone == .chGva2)
    #expect(config.apiEndpoint == Exoscale.KnownZone.chGva2.apiEndpoint)
    #expect(config.sosEndpoint == Exoscale.KnownZone.chGva2.sosEndpoint)
}

@Test("Config uses static fallback zone and user agent")
func configUsesStaticFallbackZoneAndUserAgent() throws {
    let config = try Exoscale.Config(
        apiKey: "key",
        apiSecret: "secret",
        environment: [:]
    )

    #expect(config.userAgent == Exoscale.Config.fallbackUserAgent)
    #expect(config.zone == Exoscale.Config.fallbackZone)
    #expect(config.apiEndpoint == Exoscale.Config.fallbackZone.apiEndpoint)
    #expect(config.sosEndpoint == Exoscale.Config.fallbackZone.sosEndpoint)
}

@Test("Config resolves values from environment")
func configResolvesValuesFromEnvironment() throws {
    let config = try Exoscale.Config(environment: [
        "EXOSCALE_API_KEY": "key",
        "EXOSCALE_API_SECRET": "secret",
        "EXOSCALE_USER_AGENT": "exoscale-swift-tests/1.0",
        "EXOSCALE_ZONE": "at-vie-1",
    ])

    #expect(config.apiKey == "key")
    #expect(config.apiSecret == "secret")
    #expect(config.userAgent == "exoscale-swift-tests/1.0")
    #expect(config.zone == .atVie1)
    #expect(config.apiEndpoint == Exoscale.KnownZone.atVie1.apiEndpoint)
    #expect(config.sosEndpoint == Exoscale.KnownZone.atVie1.sosEndpoint)
}

@Test("Config explicit values override environment")
func configExplicitValuesOverrideEnvironment() throws {
    let config = try Exoscale.Config(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2,
        userAgent: "exoscale-swift-tests/1.0",
        environment: [
            "EXOSCALE_API_KEY": "env-key",
            "EXOSCALE_API_SECRET": "env-secret",
            "EXOSCALE_USER_AGENT": "env-agent",
            "EXOSCALE_ZONE": "at-vie-1",
        ]
    )

    #expect(config.apiKey == "key")
    #expect(config.apiSecret == "secret")
    #expect(config.userAgent == "exoscale-swift-tests/1.0")
    #expect(config.zone == .chGva2)
}

@Test("Config validates missing API key")
func configValidatesMissingAPIKey() throws {
    #expect(throws: Exoscale.Config.Error.missingAPIKey) {
        _ = try Exoscale.Config(environment: [:])
    }
}

@Test("Config validates missing API secret")
func configValidatesMissingAPISecret() throws {
    #expect(throws: Exoscale.Config.Error.missingAPISecret) {
        _ = try Exoscale.Config(apiKey: "key", environment: [:])
    }
}

@Test("Config validates invalid environment zone")
func configValidatesInvalidEnvironmentZone() throws {
    #expect(throws: Exoscale.Config.Error.invalidZone("invalid-zone")) {
        _ = try Exoscale.Config(
            apiKey: "key",
            apiSecret: "secret",
            environment: ["EXOSCALE_ZONE": "invalid-zone"]
        )
    }
}

@Test("Client can be initialized from config")
func clientInitializesFromConfig() throws {
    let client = try Exoscale(
        config: Exoscale.Config(
            apiKey: "key",
            apiSecret: "secret",
            zone: .atVie1,
            userAgent: "exoscale-swift-tests/1.0",
            environment: [:]
        )
    )

    #expect(client.config.zone == .atVie1)
    #expect(client.config.apiEndpoint == Exoscale.KnownZone.atVie1.apiEndpoint)
    #expect(client.config.userAgent == "exoscale-swift-tests/1.0")
}

@Test("User-Agent middleware applies the configured user agent")
func userAgentMiddlewareAppliesConfiguredUserAgent() throws {
    let middleware = ApplyUserAgent(userAgent: "exoscale-swift-tests/1.0")
    let request = URLRequest(url: try #require(URL(string: "https://api-ch-gva-2.exoscale.com/v2/instance")))

    let adapted = try middleware.adapt(request)

    #expect(adapted.value(forHTTPHeaderField: "User-Agent") == "exoscale-swift-tests/1.0")
}

@Test("User-Agent middleware preserves explicit user agent")
func userAgentMiddlewarePreservesExplicitUserAgent() throws {
    let middleware = ApplyUserAgent(userAgent: "exoscale-swift-tests/1.0")
    var request = URLRequest(url: try #require(URL(string: "https://api-ch-gva-2.exoscale.com/v2/instance")))
    request.setValue("custom-agent", forHTTPHeaderField: "User-Agent")

    let adapted = try middleware.adapt(request)

    #expect(adapted.value(forHTTPHeaderField: "User-Agent") == "custom-agent")
}

@Test("JSON content type middleware applies application/json for request bodies")
func jsonContentTypeMiddlewareAppliesApplicationJSON() throws {
    let middleware = ApplyJSONContentType()
    var request = URLRequest(url: try #require(URL(string: "https://api-ch-gva-2.exoscale.com/v2/ssh-key")))
    request.httpBody = Data("{}".utf8)

    let adapted = try middleware.adapt(request)

    #expect(adapted.value(forHTTPHeaderField: "Content-Type") == "application/json")
}

@Test("JSON content type middleware preserves explicit content type")
func jsonContentTypeMiddlewarePreservesExplicitContentType() throws {
    let middleware = ApplyJSONContentType()
    var request = URLRequest(url: try #require(URL(string: "https://api-ch-gva-2.exoscale.com/v2/ssh-key")))
    request.httpBody = Data("{}".utf8)
    request.setValue("application/custom", forHTTPHeaderField: "Content-Type")

    let adapted = try middleware.adapt(request)

    #expect(adapted.value(forHTTPHeaderField: "Content-Type") == "application/custom")
}

@Test("Client uses config fallback zone")
func clientUsesConfigFallbackZone() throws {
    let client = try Exoscale(
        config: Exoscale.Config(
            apiKey: "key",
            apiSecret: "secret",
            environment: [:]
        )
    )

    #expect(client.config.zone == Exoscale.Config.fallbackZone)
    #expect(client.config.apiEndpoint == Exoscale.Config.fallbackZone.apiEndpoint)
    #expect(client.config.userAgent == Exoscale.Config.fallbackUserAgent)
}

@Test("Client merges top-level values into config")
func clientMergesTopLevelValuesIntoConfig() throws {
    let client = try Exoscale(
        apiSecret: "secret",
        zone: .atVie1,
        config: Exoscale.Config(
            apiKey: "key",
            apiSecret: "config-secret",
            zone: .chGva2,
            userAgent: "exoscale-swift-tests/1.0",
            environment: [:]
        )
    )

    #expect(client.config.zone == .atVie1)
    #expect(client.config.apiEndpoint == Exoscale.KnownZone.atVie1.apiEndpoint)
    #expect(client.config.userAgent == "exoscale-swift-tests/1.0")
}
