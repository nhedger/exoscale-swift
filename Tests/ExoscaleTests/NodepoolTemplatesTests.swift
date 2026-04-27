import Foundation
import Testing

@testable import Exoscale

@Test("ActiveNodepoolTemplateResponse decodes active template")
func activeNodepoolTemplateResponseDecodesActiveTemplate() throws {
    let data = Data(
        """
        {
          "active-template": "11111111-1111-1111-1111-111111111111"
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ActiveNodepoolTemplateResponse.self, from: data)

    #expect(response.activeTemplate == "11111111-1111-1111-1111-111111111111")
}

@Test("Client builds active nodepool template path")
func clientBuildsActiveNodepoolTemplatePath() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let request = try client.http.makeRequest(
        "GET",
        path: "/sks-template/1.31.1/\(NodepoolTemplatesResource.Variant.nvidia.rawValue)"
    )

    #expect(request.url?.path == "/v2/sks-template/1.31.1/nvidia")
}
