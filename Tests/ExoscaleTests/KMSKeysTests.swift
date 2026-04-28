import Foundation
import Testing

@testable import Exoscale

@Test("CreateKMSKeyRequest encodes request body")
func createKMSKeyRequestEncodesRequestBody() throws {
    let request = CreateKMSKeyRequest(
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
    let rotationData = try JSONEncoder().encode(EnableKMSKeyRotationRequest(rotationPeriod: 365))
    let rotationObject = try #require(JSONSerialization.jsonObject(with: rotationData) as? [String: Int])

    let replicateData = try JSONEncoder().encode(ReplicateKMSKeyRequest(zone: .deFra1))
    let replicateObject = try #require(JSONSerialization.jsonObject(with: replicateData) as? [String: String])

    let scheduleData = try JSONEncoder().encode(ScheduleKMSKeyDeletionRequest(delayDays: 14))
    let scheduleObject = try #require(JSONSerialization.jsonObject(with: scheduleData) as? [String: Int])

    #expect(rotationObject["rotation-period"] == 365)
    #expect(replicateObject["zone"] == "de-fra-1")
    #expect(scheduleObject["delay-days"] == 14)
}

@Test("ListKMSKeysResponse decodes KMS keys")
func listKMSKeysResponseDecodesKMSKeys() throws {
    let data = Data(
        """
        {
          "kms-keys": [
            {
              "zone": "ch-gva-2",
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "payments-key",
              "description": "Encrypt payment records",
              "usage": "encrypt-decrypt",
              "source": "exoscale-kms",
              "status": "enabled",
              "status-since": "2026-04-27T10:00:00Z",
              "material": {
                "version": 2,
                "created-at": "2026-04-27T09:00:00Z",
                "automatic": false
              },
              "rotation": {
                "manual-count": 1,
                "automatic": true,
                "rotation-period": 365,
                "next-at": "2027-04-27T09:00:00Z"
              },
              "multi-zone": true,
              "origin-zone": "ch-gva-2",
              "replicas": ["de-fra-1"],
              "replicas-status": [
                {
                  "zone": "de-fra-1",
                  "last-applied-watermark": 42,
                  "last-failure": {
                    "attempted-watermark": 41,
                    "error": "temporary failure",
                    "failed-at": "2026-04-27T08:00:00Z"
                  }
                }
              ],
              "created-at": "2026-04-27T09:00:00Z",
              "revision": {
                "at": "2026-04-27T10:00:00Z",
                "seq": 3
              }
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListKMSKeysResponse.self, from: data)
    let key = try #require(response.kmsKeys.first)

    #expect(key.zone == "ch-gva-2")
    #expect(key.id == "11111111-1111-1111-1111-111111111111")
    #expect(key.name == "payments-key")
    #expect(key.description == "Encrypt payment records")
    #expect(key.usage == .encryptDecrypt)
    #expect(key.source == .exoscaleKMS)
    #expect(key.status == .enabled)
    #expect(key.statusSince == "2026-04-27T10:00:00Z")
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
    #expect(key.createdAt == "2026-04-27T09:00:00Z")
    #expect(key.revision?.seq == 3)
}

@Test("KMS key responses decode values")
func kmsKeyResponsesDecodeValues() throws {
    let rotationResponse = try JSONDecoder().decode(
        KMSKeyRotationResponse.self,
        from: Data(
            #"{"rotation":{"manual-count":2,"automatic":true,"rotation-period":180,"next-at":"2026-10-27T09:00:00Z"}}"#.utf8
        )
    )
    let rotationsResponse = try JSONDecoder().decode(
        ListKMSKeyRotationsResponse.self,
        from: Data(#"{"rotations":[{"version":3,"rotated-at":"2026-04-27T09:00:00Z","automatic":false}]}"#.utf8)
    )
    let actionResponse = try JSONDecoder().decode(
        KMSKeyActionResponse.self,
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
