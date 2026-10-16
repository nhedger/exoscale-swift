@testable import Exoscale
import Foundation
import Testing

@Test("EncryptBody encodes request body")
func encryptRequestEncodesRequestBody() throws {
    let request = EncryptBody(
        encryptionContext: "Y29udGV4dA==",
        plaintext: "cGxhaW50ZXh0"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["encryption-context"] == "Y29udGV4dA==")
    #expect(object["plaintext"] == "cGxhaW50ZXh0")
}

@Test("DecryptBody encodes request body")
func decryptRequestEncodesRequestBody() throws {
    let request = DecryptBody(
        encryptionContext: "Y29udGV4dA==",
        ciphertext: "Y2lwaGVydGV4dA=="
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["encryption-context"] == "Y29udGV4dA==")
    #expect(object["ciphertext"] == "Y2lwaGVydGV4dA==")
}

@Test("GenerateDataKeyBody encodes request body")
func generateDataKeyRequestEncodesRequestBody() throws {
    let request = GenerateDataKeyBody(
        keySpec: .aes256,
        bytesCount: 32,
        encryptionContext: "Y29udGV4dA=="
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["key-spec"] as? String == "AES-256")
    #expect(object["bytes-count"] as? Int == 32)
    #expect(object["encryption-context"] as? String == "Y29udGV4dA==")
}

@Test("ReEncryptBody encodes request body")
func reEncryptRequestEncodesRequestBody() throws {
    let request = ReEncryptBody(
        sourceKeyID: "11111111-1111-1111-1111-111111111111",
        destinationKeyID: "22222222-2222-2222-2222-222222222222",
        ciphertext: "Y2lwaGVydGV4dA==",
        sourceEncryptionContext: "c291cmNl",
        destinationEncryptionContext: "ZGVzdGluYXRpb24="
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let source = try #require(object["source"] as? [String: String])
    let destination = try #require(object["destination"] as? [String: String])

    #expect(source["key"] == "11111111-1111-1111-1111-111111111111")
    #expect(source["encryption-context"] == "c291cmNl")
    #expect(source["ciphertext"] == "Y2lwaGVydGV4dA==")
    #expect(destination["key"] == "22222222-2222-2222-2222-222222222222")
    #expect(destination["encryption-context"] == "ZGVzdGluYXRpb24=")
}

@Test("Crypto responses decode values")
func cryptoResponsesDecodeValues() throws {
    let encryptResponse = try JSONDecoder().decode(
        EncryptData.self,
        from: Data(#"{"ciphertext":"Y2lwaGVydGV4dA=="}"#.utf8)
    )
    let decryptResponse = try JSONDecoder().decode(
        DecryptData.self,
        from: Data(#"{"plaintext":"cGxhaW50ZXh0"}"#.utf8)
    )
    let reEncryptResponse = try JSONDecoder().decode(
        ReEncryptData.self,
        from: Data(#"{"ciphertext":"cmUtZW5jcnlwdGVk"}"#.utf8)
    )
    let dataKey = try JSONDecoder().decode(
        Exoscale.CryptoDataKey.Payload.self,
        from: Data(#"{"plaintext":"cGxhaW50ZXh0","ciphertext":"Y2lwaGVydGV4dA=="}"#.utf8)
    )

    #expect(encryptResponse.ciphertext == "Y2lwaGVydGV4dA==")
    #expect(decryptResponse.plaintext == "cGxhaW50ZXh0")
    #expect(reEncryptResponse.ciphertext == "cmUtZW5jcnlwdGVk")
    #expect(dataKey.plaintext == "cGxhaW50ZXh0")
    #expect(dataKey.ciphertext == "Y2lwaGVydGV4dA==")
}

@Test("Client builds crypto paths")
func clientBuildsCryptoPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let encryptRequest = try client.http.makeRequest("POST", path: "/kms-key/key-id/encrypt")
    let decryptRequest = try client.http.makeRequest("POST", path: "/kms-key/key-id/decrypt")
    let generateDataKeyRequest = try client.http.makeRequest("POST", path: "/kms-key/key-id/generate-data-key")
    let reEncryptRequest = try client.http.makeRequest("POST", path: "/kms-key/key-id/re-encrypt")

    #expect(encryptRequest.url?.path == "/v2/kms-key/key-id/encrypt")
    #expect(decryptRequest.url?.path == "/v2/kms-key/key-id/decrypt")
    #expect(generateDataKeyRequest.url?.path == "/v2/kms-key/key-id/generate-data-key")
    #expect(reEncryptRequest.url?.path == "/v2/kms-key/key-id/re-encrypt")
}
