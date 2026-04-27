import Foundation
import Testing

@testable import Exoscale

@Test("CreateSKSNodepoolRequest encodes request body")
func createSKSNodepoolRequestEncodesRequestBody() throws {
    let request = CreateSKSNodepoolRequest(
        antiAffinityGroups: [SKSNodepoolReference(id: "11111111-1111-1111-1111-111111111111")],
        description: "worker pool",
        publicIPAssignment: .dual,
        labels: ["pool": "workers"],
        taints: ["dedicated": .init(value: "gpu", effect: .noSchedule)],
        securityGroups: [SKSNodepoolReference(id: "22222222-2222-2222-2222-222222222222")],
        name: "workers",
        instanceType: SKSNodepoolReference(id: "33333333-3333-3333-3333-333333333333"),
        privateNetworks: [SKSNodepoolReference(id: "44444444-4444-4444-4444-444444444444")],
        size: 3,
        kubeletImageGC: .init(highThreshold: 85, lowThreshold: 80, minAge: "2m"),
        instancePrefix: "worker",
        deployTarget: SKSNodepoolReference(id: "55555555-5555-5555-5555-555555555555"),
        addons: [.storageLVM],
        diskSize: 50
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["description"] as? String == "worker pool")
    #expect(object["public-ip-assignment"] as? String == "dual")
    #expect((object["labels"] as? [String: String])?["pool"] == "workers")
    #expect(object["name"] as? String == "workers")
    #expect(object["size"] as? Int == 3)
    #expect(object["instance-prefix"] as? String == "worker")
    #expect(object["addons"] as? [String] == ["storage-lvm"])
    #expect(object["disk-size"] as? Int == 50)

    let antiAffinityGroups = try #require(object["anti-affinity-groups"] as? [[String: String]])
    let taints = try #require(object["taints"] as? [String: [String: String]])
    let securityGroups = try #require(object["security-groups"] as? [[String: String]])
    let instanceType = try #require(object["instance-type"] as? [String: String])
    let privateNetworks = try #require(object["private-networks"] as? [[String: String]])
    let kubeletImageGC = try #require(object["kubelet-image-gc"] as? [String: Any])
    let deployTarget = try #require(object["deploy-target"] as? [String: String])

    #expect(antiAffinityGroups.first?["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(taints["dedicated"]?["value"] == "gpu")
    #expect(taints["dedicated"]?["effect"] == "NoSchedule")
    #expect(securityGroups.first?["id"] == "22222222-2222-2222-2222-222222222222")
    #expect(instanceType["id"] == "33333333-3333-3333-3333-333333333333")
    #expect(privateNetworks.first?["id"] == "44444444-4444-4444-4444-444444444444")
    #expect(kubeletImageGC["high-threshold"] as? Int == 85)
    #expect(kubeletImageGC["low-threshold"] as? Int == 80)
    #expect(kubeletImageGC["min-age"] as? String == "2m")
    #expect(deployTarget["id"] == "55555555-5555-5555-5555-555555555555")
}

@Test("UpdateSKSNodepoolRequest encodes request body")
func updateSKSNodepoolRequestEncodesRequestBody() throws {
    let request = UpdateSKSNodepoolRequest(
        antiAffinityGroups: [SKSNodepoolReference(id: "11111111-1111-1111-1111-111111111111")],
        description: "updated worker pool",
        publicIPAssignment: .inet4,
        labels: ["pool": "updated"],
        taints: ["dedicated": .init(value: "cpu", effect: .noExecute)],
        securityGroups: [SKSNodepoolReference(id: "22222222-2222-2222-2222-222222222222")],
        name: "workers-updated",
        instanceType: SKSNodepoolReference(id: "33333333-3333-3333-3333-333333333333"),
        privateNetworks: [SKSNodepoolReference(id: "44444444-4444-4444-4444-444444444444")],
        kubeletImageGC: .init(highThreshold: 90, lowThreshold: 75, minAge: "5m"),
        instancePrefix: "node",
        deployTarget: SKSNodepoolReference(id: "55555555-5555-5555-5555-555555555555"),
        diskSize: 100
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["description"] as? String == "updated worker pool")
    #expect(object["public-ip-assignment"] as? String == "inet4")
    #expect((object["labels"] as? [String: String])?["pool"] == "updated")
    #expect(object["name"] as? String == "workers-updated")
    #expect(object["instance-prefix"] as? String == "node")
    #expect(object["disk-size"] as? Int == 100)
    #expect(object["size"] == nil)
    #expect(object["addons"] == nil)

    let taints = try #require(object["taints"] as? [String: [String: String]])
    let instanceType = try #require(object["instance-type"] as? [String: String])

    #expect(taints["dedicated"]?["value"] == "cpu")
    #expect(taints["dedicated"]?["effect"] == "NoExecute")
    #expect(instanceType["id"] == "33333333-3333-3333-3333-333333333333")
}

@Test("SKS nodepool action requests encode request bodies")
func sksNodepoolActionRequestsEncodeRequestBodies() throws {
    let scaleData = try JSONEncoder().encode(ScaleSKSNodepoolRequest(size: 5))
    let scaleObject = try #require(JSONSerialization.jsonObject(with: scaleData) as? [String: Int])

    let evictData = try JSONEncoder().encode(
        EvictSKSNodepoolMembersRequest(instances: ["11111111-1111-1111-1111-111111111111"])
    )
    let evictObject = try #require(JSONSerialization.jsonObject(with: evictData) as? [String: [String]])

    #expect(scaleObject["size"] == 5)
    #expect(evictObject["instances"] == ["11111111-1111-1111-1111-111111111111"])
}

@Test("Client builds SKS nodepool action paths")
func clientBuildsSKSNodepoolActionPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let scaleRequest = try client.http.makeRequest(
        "PUT",
        path: "/sks-cluster/cluster-id/nodepool/nodepool-id:scale"
    )
    let evictRequest = try client.http.makeRequest(
        "PUT",
        path: "/sks-cluster/cluster-id/nodepool/nodepool-id:evict"
    )

    #expect(scaleRequest.url?.path == "/v2/sks-cluster/cluster-id/nodepool/nodepool-id:scale")
    #expect(evictRequest.url?.path == "/v2/sks-cluster/cluster-id/nodepool/nodepool-id:evict")
}
