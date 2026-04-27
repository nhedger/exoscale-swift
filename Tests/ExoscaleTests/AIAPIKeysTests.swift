import Foundation
import Testing

@testable import Exoscale

@Test("CreateAIAPIKeyRequest encodes request body")
func createAIAPIKeyRequestEncodesRequestBody() throws {
    let request = CreateAIAPIKeyRequest(name: "default-public-key", scope: "public")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "default-public-key")
    #expect(object["scope"] == "public")
}

@Test("UpdateAIAPIKeyRequest encodes request body")
func updateAIAPIKeyRequestEncodesRequestBody() throws {
    let request = UpdateAIAPIKeyRequest(name: "renamed-key", scope: "deployment-id")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "renamed-key")
    #expect(object["scope"] == "deployment-id")
}

@Test("ListAIAPIKeysResponse decodes AI API keys")
func listAIAPIKeysResponseDecodesAIAPIKeys() throws {
    let data = Data(
        """
        {
          "ai-api-keys": [
            {
              "updated-at": "2026-03-25T10:00:00Z",
              "name": "default-public-key",
              "scope": "public",
              "id": "11111111-1111-1111-1111-111111111111",
              "org-uuid": "22222222-2222-2222-2222-222222222222",
              "created-at": "2026-03-25T10:00:00Z"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListAIAPIKeysResponse.self, from: data)

    #expect(response.aiAPIKeys.count == 1)
    #expect(response.aiAPIKeys[0].updatedAt == "2026-03-25T10:00:00Z")
    #expect(response.aiAPIKeys[0].name == "default-public-key")
    #expect(response.aiAPIKeys[0].scope == "public")
    #expect(response.aiAPIKeys[0].id == "11111111-1111-1111-1111-111111111111")
    #expect(response.aiAPIKeys[0].orgUUID == "22222222-2222-2222-2222-222222222222")
    #expect(response.aiAPIKeys[0].createdAt == "2026-03-25T10:00:00Z")
}

@Test("AIAPIKeyWithValue decodes API key value")
func aiAPIKeyWithValueDecodesAPIKeyValue() throws {
    let data = Data(
        """
        {
          "updated-at": "2026-03-25T10:00:00Z",
          "name": "default-public-key",
          "scope": "public",
          "id": "11111111-1111-1111-1111-111111111111",
          "org-uuid": "22222222-2222-2222-2222-222222222222",
          "created-at": "2026-03-25T10:00:00Z",
          "value": "sk_live_123"
        }
        """.utf8
    )

    let apiKey = try JSONDecoder().decode(Exoscale.AIAPIKeyWithValue.self, from: data)

    #expect(apiKey.name == "default-public-key")
    #expect(apiKey.value == "sk_live_123")
}

@Test("DeleteAIAPIKeyResponse decodes delete confirmation")
func deleteAIAPIKeyResponseDecodesDeleteConfirmation() throws {
    let data = Data("{".utf8 + Data("\"deleted\":true}".utf8))
    let response = try JSONDecoder().decode(DeleteAIAPIKeyResponse.self, from: data)

    #expect(response.deleted == true)
}
