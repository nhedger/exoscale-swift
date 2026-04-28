import Foundation
import Testing

@testable import Exoscale

@Test("CreateAPIKeyRequest encodes request body")
func createAPIKeyRequestEncodesRequestBody() throws {
    let request = CreateAPIKeyRequest(roleID: "11111111-1111-1111-1111-111111111111", name: "ci-key")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["role-id"] == "11111111-1111-1111-1111-111111111111")
    #expect(object["name"] == "ci-key")
}

@Test("ListAPIKeysResponse decodes API keys")
func listAPIKeysResponseDecodesAPIKeys() throws {
    let data = Data(
        """
        {
          "api-keys": [
            {
              "name": "ci-key",
              "key": "EXOabc123",
              "role-id": "11111111-1111-1111-1111-111111111111"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListAPIKeysResponse.self, from: data)

    #expect(response.apiKeys.count == 1)
    #expect(response.apiKeys[0].name == "ci-key")
    #expect(response.apiKeys[0].key == "EXOabc123")
    #expect(response.apiKeys[0].roleID == "11111111-1111-1111-1111-111111111111")
}

@Test("APIKeyWithSecret decodes created API key")
func apiKeyWithSecretDecodesCreatedAPIKey() throws {
    let data = Data(
        """
        {
          "name": "ci-key",
          "key": "EXOabc123",
          "secret": "secret-value",
          "role-id": "11111111-1111-1111-1111-111111111111"
        }
        """.utf8
    )

    let apiKey = try JSONDecoder().decode(Exoscale.APIKeyWithSecret.self, from: data)

    #expect(apiKey.name == "ci-key")
    #expect(apiKey.key == "EXOabc123")
    #expect(apiKey.secret == "secret-value")
    #expect(apiKey.roleID == "11111111-1111-1111-1111-111111111111")
}
