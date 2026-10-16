@testable import Exoscale
import Foundation
import Testing

@Test("CreateModelBody encodes request body")
func createModelRequestEncodesRequestBody() throws {
    let request = CreateModelBody(name: "openai/gpt-oss-120b", huggingfaceToken: "hf_token")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "openai/gpt-oss-120b")
    #expect(object["huggingface-token"] == "hf_token")
}

@Test("ListModelsData decodes AI models")
func listModelsResponseDecodesAIModels() throws {
    let data = Data(
        """
        {
          "models": [
            {
              "updated-at": "2026-04-27T10:00:00Z",
              "name": "openai/gpt-oss-120b",
              "state": "ready",
              "id": "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb",
              "model-size": 123456,
              "created-at": "2026-04-27T09:00:00Z"
            }
          ]
        }
        """.utf8
    )

    let response = try Exoscale.jsonDecoder().decode(ListModelsData.self, from: data)

    #expect(response.models.count == 1)
    #expect(response.models[0].updatedAt == Date(timeIntervalSince1970: 1_777_284_000))
    #expect(response.models[0].name == "openai/gpt-oss-120b")
    #expect(response.models[0].state == .ready)
    #expect(response.models[0].id == "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb")
    #expect(response.models[0].modelSize == 123_456)
    #expect(response.models[0].createdAt == Date(timeIntervalSince1970: 1_777_280_400))
}
