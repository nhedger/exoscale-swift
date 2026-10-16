@testable import Exoscale
import Foundation
import Testing

@Test("CreateKMSKeyBody encodes request body")
func createKMSKeyRequestEncodesRequestBody() throws {
    let request = CreateKMSKeyBody(
        name: "payments-key",
        description: "Encrypt payment records",
        usage: .encryptDecrypt,
        multiZone: true
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "payments-key")
    #expect(object["description"] as? String == "Encrypt payment records")
    #expect(object["usage"] as? String == "encrypt-decrypt")
    #expect(object["multi-zone"] as? Bool == true)
}

@Test("KMS key action requests encode request bodies")
func kmsKeyActionRequestsEncodeRequestBodies() throws {
    let rotationData = try JSONEncoder().encode(EnableKMSKeyRotationBody(rotationPeriod: 365))
    let rotationObject = try #require(JSONSerialization.jsonObject(with: rotationData) as? [String: Int])

    let replicateData = try JSONEncoder().encode(ReplicateKMSKeyBody(zone: .deFra1))
    let replicateObject = try #require(JSONSerialization.jsonObject(with: replicateData) as? [String: String])

    let scheduleData = try JSONEncoder().encode(ScheduleKMSKeyDeletionBody(delayDays: 14))
    let scheduleObject = try #require(JSONSerialization.jsonObject(with: scheduleData) as? [String: Int])

    #expect(rotationObject["rotation-period"] == 365)
    #expect(replicateObject["zone"] == "de-fra-1")
    #expect(scheduleObject["delay-days"] == 14)
}

@Test("ListKMSKeysData decodes KMS keys")
func listKMSKeysResponseDecodesKMSKeys() throws {
    let data = KMSKeysFixtures.data

    let response = try Exoscale.jsonDecoder().decode(ListKMSKeysData.self, from: data)
    let key = try #require(response.kmsKeys.first)

    #expect(key.zone == "ch-gva-2")
    #expect(key.id == "11111111-1111-1111-1111-111111111111")
    #expect(key.name == "payments-key")
    #expect(key.description == "Encrypt payment records")
    #expect(key.usage == .encryptDecrypt)
    #expect(key.source == .exoscaleKMS)
    #expect(key.status == .enabled)
    #expect(key.statusSince == Date(timeIntervalSince1970: 1_777_284_000))
    #expect(key.material?.version == 2)
    #expect(key.material?.automatic == false)
    #expect(key.rotation?.manualCount == 1)
    #expect(key.rotation?.automatic == true)
    #expect(key.rotation?.rotationPeriod == 365)
    #expect(key.multiZone == true)
    #expect(key.originZone == "ch-gva-2")
    #expect(key.replicas == ["de-fra-1"])
    #expect(key.replicasStatus?.first?.lastAppliedWatermark == 42)
    #expect(key.replicasStatus?.first?.lastFailure?.error == "temporary failure")
    #expect(key.createdAt == Date(timeIntervalSince1970: 1_777_280_400))
    #expect(key.revision?.seq == 3)
}

@Test("KMS key responses decode values")
func kmsKeyResponsesDecodeValues() throws {
    let rotationResponse = try Exoscale.jsonDecoder().decode(
        KMSKeyRotationData.self,
        from: KMSKeysFixtures.rotationResponse
    )
    let rotationsResponse = try Exoscale.jsonDecoder().decode(
        ListKMSKeyRotationsData.self,
        from: Data(#"{"rotations":[{"version":3,"rotated-at":"2026-04-27T09:00:00Z","automatic":false}]}"#.utf8)
    )
    let actionResponse = try JSONDecoder().decode(
        KMSKeyActionData.self,
        from: Data(#"{"status":"target-registered"}"#.utf8)
    )

    #expect(rotationResponse.rotation.manualCount == 2)
    #expect(rotationResponse.rotation.rotationPeriod == 180)
    #expect(rotationsResponse.rotations.first?.version == 3)
    #expect(rotationsResponse.rotations.first?.automatic == false)
    #expect(actionResponse.status == .targetRegistered)
}

@Test("Client builds KMS key paths")
func clientBuildsKMSKeyPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let listRequest = try client.http.makeRequest("GET", path: "/kms-key")
    let enableRequest = try client.http.makeRequest("POST", path: "/kms-key/key-id/enable")
    let rotationsRequest = try client.http.makeRequest("GET", path: "/kms-key/key-id/list-key-rotations")
    let replicateRequest = try client.http.makeRequest("POST", path: "/kms-key/key-id/replicate")
    let scheduleRequest = try client.http.makeRequest("POST", path: "/kms-key/key-id/schedule-deletion")

    #expect(listRequest.url?.path == "/v2/kms-key")
    #expect(enableRequest.url?.path == "/v2/kms-key/key-id/enable")
    #expect(rotationsRequest.url?.path == "/v2/kms-key/key-id/list-key-rotations")
    #expect(replicateRequest.url?.path == "/v2/kms-key/key-id/replicate")
    #expect(scheduleRequest.url?.path == "/v2/kms-key/key-id/schedule-deletion")
}
