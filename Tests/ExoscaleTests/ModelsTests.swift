import Foundation
import Testing

@testable import Exoscale

@Test("CreateModelRequest encodes request body")
func createModelRequestEncodesRequestBody() throws {
    let request = CreateModelRequest(name: "openai/gpt-oss-120b", huggingfaceToken: "hf_token")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "openai/gpt-oss-120b")
    #expect(object["huggingface-token"] == "hf_token")
}

@Test("ListModelsResponse decodes AI models")
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

    let response = try JSONDecoder().decode(ListModelsResponse.self, from: data)

    #expect(response.models.count == 1)
    #expect(response.models[0].updatedAt == "2026-04-27T10:00:00Z")
    #expect(response.models[0].name == "openai/gpt-oss-120b")
    #expect(response.models[0].state == .ready)
    #expect(response.models[0].id == "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb")
    #expect(response.models[0].modelSize == 123456)
    #expect(response.models[0].createdAt == "2026-04-27T09:00:00Z")
}
