import Foundation
import Testing
@testable import Exoscale

@Test("Credentials require a key and secret")
func credentialsValidation() throws {
    #expect(throws: ExoscaleError.missingAPIKey) {
        try ExoscaleCredentials(apiKey: "", apiSecret: "secret")
    }

    #expect(throws: ExoscaleError.missingAPISecret) {
        try ExoscaleCredentials(apiKey: "key", apiSecret: "")
    }
}

@Test("Credentials can be built from environment variables")
func credentialsFromEnvironment() throws {
    let credentials = try ExoscaleCredentials(environment: [
        "EXOSCALE_API_KEY": "key",
        "EXOSCALE_API_SECRET": "secret",
    ])

    #expect(credentials.apiKey == "key")
}

@Test("Environment credentials still validate missing values")
func credentialsFromEnvironmentValidation() throws {
    #expect(throws: ExoscaleError.missingAPIKey) {
        try ExoscaleCredentials(environment: ["EXOSCALE_API_SECRET": "secret"])
    }

    #expect(throws: ExoscaleError.missingAPISecret) {
        try ExoscaleCredentials(environment: ["EXOSCALE_API_KEY": "key"])
    }
}

@Test("Interceptor matches the documented signing format")
func interceptorSignsDocumentedExample() throws {
    let credentials = try ExoscaleCredentials(apiKey: "example-key", apiSecret: "example-secret")
    let interceptor = ExoscaleRequestInterceptor(
        credentials: credentials,
        expirationInterval: 0,
        now: { Date(timeIntervalSince1970: 1_599_140_767) }
    )

    var request = URLRequest(
        url: try #require(
            URL(string: "https://api-ch-gva-2.exoscale.com/v2/resource/a02baf5a-a3e4-49a0-857b-8a08d276c1c0?p2=v2&p1=v1")
        )
    )
    request.httpMethod = "GET"

    let adapted = try interceptor.adapt(request)

    #expect(
        adapted.value(forHTTPHeaderField: "Authorization")
            == "EXO2-HMAC-SHA256 credential=example-key,signed-query-args=p1;p2,expires=1599140767,signature=vPVxcXrf2my0TLdJ8WPIGa/vLld+FiJN+xtMs/vofHg="
    )
}

@Test("Interceptor signs the existing request body without modifying it")
func interceptorPreservesBody() throws {
    let credentials = try ExoscaleCredentials(apiKey: "example-key", apiSecret: "example-secret")
    let interceptor = ExoscaleRequestInterceptor(
        credentials: credentials,
        expirationInterval: 0,
        now: { Date(timeIntervalSince1970: 1_599_140_767) }
    )

    let body = Data("{\"name\":\"my-security-group\"}".utf8)

    var request = URLRequest(url: try #require(URL(string: "https://api-ch-gva-2.exoscale.com/v2/security-group")))
    request.httpMethod = "POST"
    request.httpBody = body
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let adapted = try interceptor.adapt(request)

    #expect(adapted.httpBody == body)
    #expect(adapted.value(forHTTPHeaderField: "Authorization") == "EXO2-HMAC-SHA256 credential=example-key,expires=1599140767,signature=edcMQSdrqtsF1iT0nXKHkAXTaNHlcPm76hHXVOyKe6k=")
}

@Test("Interceptor sorts and filters signed query arguments")
func interceptorSortsAndFiltersQueryArguments() throws {
    let credentials = try ExoscaleCredentials(apiKey: "example-key", apiSecret: "example-secret")
    let interceptor = ExoscaleRequestInterceptor(
        credentials: credentials,
        expirationInterval: 0,
        now: { Date(timeIntervalSince1970: 1_700_000_000) }
    )

    var request = URLRequest(
        url: try #require(
            URL(string: "https://api-ch-gva-2.exoscale.com/v2/instance?labels=env%3Aprod&manager-id=a&manager-id=b&empty&ip-address=203.0.113.10")
        )
    )
    request.httpMethod = "GET"

    let adapted = try interceptor.adapt(request)
    let authorization = try #require(adapted.value(forHTTPHeaderField: "Authorization"))

    #expect(authorization.contains("signed-query-args=empty;ip-address;labels"))
    #expect(!authorization.contains("manager-id"))
}

@Test("Client builds URLs under the configured zone endpoint")
func clientBuildsRequestsFromZoneEndpoint() throws {
    let client = ExoscaleClient(
        credentials: try ExoscaleCredentials(apiKey: "key", apiSecret: "secret"),
        zone: .chGva2
    )

    let request = try client.makeRequest(
        "GET",
        path: "/instance",
        query: ["labels": "env:prod", "ip-address": "203.0.113.10"],
        body: nil,
        headers: ["Accept": "application/json"]
    )

    #expect(client.zone == .chGva2)
    #expect(client.baseURL == ExoscaleZone.chGva2.apiEndpoint)
    #expect(request.url?.absoluteString == "https://api-ch-gva-2.exoscale.com/v2/instance?ip-address=203.0.113.10&labels=env:prod")
    #expect(request.httpMethod == "GET")
    #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
}

@Test("Zone supports arbitrary raw values")
func zoneSupportsArbitraryRawValues() {
    let zone = ExoscaleZone(rawValue: "custom-zone-1")

    #expect(zone.rawValue == "custom-zone-1")
    #expect(zone.apiEndpoint == URL(string: "https://api-custom-zone-1.exoscale.com/v2"))
}
