import Foundation
import Testing

@testable import Exoscale

@Test("ListSOSBucketsUsageResponse decodes SOS buckets usage")
func listSOSBucketsUsageResponseDecodesSOSBucketsUsage() throws {
    let data = Data(
        """
        {
          "sos-buckets-usage": [
            {
              "name": "assets",
              "created-at": "2026-04-27T10:00:00Z",
              "zone-name": "ch-gva-2",
              "size": 1024
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListSOSBucketsUsageResponse.self, from: data)
    let usage = try #require(response.sosBucketsUsage.first)

    #expect(usage.name == "assets")
    #expect(usage.createdAt == "2026-04-27T10:00:00Z")
    #expect(usage.zoneName == .chGva2)
    #expect(usage.size == 1024)
}

@Test("SOSPresignedURL decodes URL")
func sosPresignedURLDecodesURL() throws {
    let data = Data(#"{"url":"https://sos.example.com/assets/object.txt?signature=abc"}"#.utf8)

    let response = try JSONDecoder().decode(Exoscale.SOSPresignedURL.self, from: data)

    #expect(response.url == "https://sos.example.com/assets/object.txt?signature=abc")
}

@Test("Client builds SOS presigned URL query")
func clientBuildsSOSPresignedURLQuery() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let request = try client.http.makeRequest(
        "GET",
        path: "/sos/assets/presigned-url",
        query: ["key": "images/logo.png"]
    )

    let url = try #require(request.url)
    let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    let queryItems = Dictionary(uniqueKeysWithValues: try #require(components.queryItems).map { ($0.name, $0.value) })

    #expect(url.path == "/v2/sos/assets/presigned-url")
    #expect(queryItems["key"] == "images/logo.png")
}
