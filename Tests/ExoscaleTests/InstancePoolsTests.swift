import Foundation
import Testing

@testable import Exoscale

@Test("CreateInstancePoolRequest encodes request body")
func createInstancePoolRequestEncodesRequestBody() throws {
    let request = CreateInstancePoolRequest(
        applicationConsistentSnapshotEnabled: true,
        antiAffinityGroups: [InstanceIDReference(id: "11111111-1111-1111-1111-111111111111")],
        description: "web workers",
        publicIPAssignment: .dual,
        labels: ["env": "prod"],
        securityGroups: [InstanceIDReference(id: "22222222-2222-2222-2222-222222222222")],
        elasticIPs: [InstanceIDReference(id: "33333333-3333-3333-3333-333333333333")],
        name: "web-pool",
        instanceType: InstanceIDReference(id: "44444444-4444-4444-4444-444444444444"),
        minAvailable: 2,
        privateNetworks: [InstanceIDReference(id: "55555555-5555-5555-5555-555555555555")],
        template: InstanceIDReference(id: "66666666-6666-6666-6666-666666666666"),
        size: 3,
        sshKey: InstanceSSHKeyReference(name: "legacy-key"),
        instancePrefix: "web",
        userData: "dXNlci1kYXRh",
        deployTarget: InstanceIDReference(id: "77777777-7777-7777-7777-777777777777"),
        ipv6Enabled: true,
        diskSize: 50,
        sshKeys: [InstanceSSHKeyReference(name: "main-key")]
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["application-consistent-snapshot-enabled"] as? Bool == true)
    #expect(object["description"] as? String == "web workers")
    #expect(object["public-ip-assignment"] as? String == "dual")
    #expect((object["labels"] as? [String: String])?["env"] == "prod")
    #expect(object["name"] as? String == "web-pool")
    #expect(object["min-available"] as? Int == 2)
    #expect(object["size"] as? Int == 3)
    #expect(object["instance-prefix"] as? String == "web")
    #expect(object["user-data"] as? String == "dXNlci1kYXRh")
    #expect(object["ipv6-enabled"] as? Bool == true)
    #expect(object["disk-size"] as? Int == 50)

    let antiAffinityGroup = try #require((object["anti-affinity-groups"] as? [[String: String]])?.first)
    let securityGroup = try #require((object["security-groups"] as? [[String: String]])?.first)
    let elasticIP = try #require((object["elastic-ips"] as? [[String: String]])?.first)
    let instanceType = try #require(object["instance-type"] as? [String: String])
    let privateNetwork = try #require((object["private-networks"] as? [[String: String]])?.first)
    let template = try #require(object["template"] as? [String: String])
    let sshKey = try #require(object["ssh-key"] as? [String: String])
    let deployTarget = try #require(object["deploy-target"] as? [String: String])
    let sshKeys = try #require(object["ssh-keys"] as? [[String: String]])

    #expect(antiAffinityGroup["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(securityGroup["id"] == "22222222-2222-2222-2222-222222222222")
    #expect(elasticIP["id"] == "33333333-3333-3333-3333-333333333333")
    #expect(instanceType["id"] == "44444444-4444-4444-4444-444444444444")
    #expect(privateNetwork["id"] == "55555555-5555-5555-5555-555555555555")
    #expect(template["id"] == "66666666-6666-6666-6666-666666666666")
    #expect(sshKey["name"] == "legacy-key")
    #expect(deployTarget["id"] == "77777777-7777-7777-7777-777777777777")
    #expect(sshKeys.first?["name"] == "main-key")
}

@Test("UpdateInstancePoolRequest encodes request body")
func updateInstancePoolRequestEncodesRequestBody() throws {
    let request = UpdateInstancePoolRequest(
        applicationConsistentSnapshotEnabled: false,
        antiAffinityGroups: [InstanceIDReference(id: "11111111-1111-1111-1111-111111111111")],
        description: "updated web workers",
        publicIPAssignment: .inet4,
        labels: ["env": "staging"],
        securityGroups: [InstanceIDReference(id: "22222222-2222-2222-2222-222222222222")],
        elasticIPs: [InstanceIDReference(id: "33333333-3333-3333-3333-333333333333")],
        name: "web-pool-updated",
        instanceType: InstanceIDReference(id: "44444444-4444-4444-4444-444444444444"),
        minAvailable: 1,
        privateNetworks: [InstanceIDReference(id: "55555555-5555-5555-5555-555555555555")],
        template: InstanceIDReference(id: "66666666-6666-6666-6666-666666666666"),
        sshKey: InstanceSSHKeyReference(name: "legacy-key"),
        instancePrefix: "node",
        userData: "bmV3LXVzZXItZGF0YQ==",
        deployTarget: InstanceIDReference(id: "77777777-7777-7777-7777-777777777777"),
        ipv6Enabled: false,
        diskSize: 100,
        sshKeys: [InstanceSSHKeyReference(name: "main-key")]
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["application-consistent-snapshot-enabled"] as? Bool == false)
    #expect(object["description"] as? String == "updated web workers")
    #expect(object["public-ip-assignment"] as? String == "inet4")
    #expect((object["labels"] as? [String: String])?["env"] == "staging")
    #expect(object["name"] as? String == "web-pool-updated")
    #expect(object["min-available"] as? Int == 1)
    #expect(object["instance-prefix"] as? String == "node")
    #expect(object["user-data"] as? String == "bmV3LXVzZXItZGF0YQ==")
    #expect(object["ipv6-enabled"] as? Bool == false)
    #expect(object["disk-size"] as? Int == 100)
    #expect(object["size"] == nil)

    let instanceType = try #require(object["instance-type"] as? [String: String])
    let template = try #require(object["template"] as? [String: String])
    let sshKey = try #require(object["ssh-key"] as? [String: String])

    #expect(instanceType["id"] == "44444444-4444-4444-4444-444444444444")
    #expect(template["id"] == "66666666-6666-6666-6666-666666666666")
    #expect(sshKey["name"] == "legacy-key")
}

@Test("Instance Pool action requests encode request bodies")
func instancePoolActionRequestsEncodeRequestBodies() throws {
    let scaleData = try JSONEncoder().encode(ScaleInstancePoolRequest(size: 5))
    let scaleObject = try #require(JSONSerialization.jsonObject(with: scaleData) as? [String: Int])

    let evictData = try JSONEncoder().encode(
        EvictInstancePoolMembersRequest(instances: ["11111111-1111-1111-1111-111111111111"])
    )
    let evictObject = try #require(JSONSerialization.jsonObject(with: evictData) as? [String: [String]])

    #expect(scaleObject["size"] == 5)
    #expect(evictObject["instances"] == ["11111111-1111-1111-1111-111111111111"])
}

@Test("ListInstancePoolsResponse decodes Instance Pools")
func listInstancePoolsResponseDecodesInstancePools() throws {
    let data = Data(
        """
        {
          "instance-pools": [
            {
              "application-consistent-snapshot-enabled": true,
              "anti-affinity-groups": [
                { "id": "22222222-2222-2222-2222-222222222222" }
              ],
              "description": "web workers",
              "public-ip-assignment": "dual",
              "labels": { "env": "prod" },
              "security-groups": [
                { "id": "33333333-3333-3333-3333-333333333333" }
              ],
              "elastic-ips": [
                { "id": "44444444-4444-4444-4444-444444444444" }
              ],
              "name": "web-pool",
              "instance-type": {
                "id": "55555555-5555-5555-5555-555555555555"
              },
              "min-available": 2,
              "private-networks": [
                { "id": "66666666-6666-6666-6666-666666666666" }
              ],
              "template": {
                "id": "77777777-7777-7777-7777-777777777777"
              },
              "state": "running",
              "size": 3,
              "ssh-key": {
                "name": "legacy-key"
              },
              "instance-prefix": "web",
              "user-data": "dXNlci1kYXRh",
              "manager": {
                "id": "88888888-8888-8888-8888-888888888888",
                "type": "instance-pool"
              },
              "instances": [
                { "id": "99999999-9999-9999-9999-999999999999" }
              ],
              "deploy-target": {
                "id": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
              },
              "ipv6-enabled": true,
              "id": "11111111-1111-1111-1111-111111111111",
              "disk-size": 50,
              "ssh-keys": [
                { "name": "main-key" }
              ]
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListInstancePoolsResponse.self, from: data)
    let instancePool = try #require(response.instancePools.first)

    #expect(instancePool.applicationConsistentSnapshotEnabled == true)
    #expect(instancePool.antiAffinityGroups?.first?.id == "22222222-2222-2222-2222-222222222222")
    #expect(instancePool.description == "web workers")
    #expect(instancePool.publicIPAssignment == .dual)
    #expect(instancePool.labels == ["env": "prod"])
    #expect(instancePool.securityGroups?.first?.id == "33333333-3333-3333-3333-333333333333")
    #expect(instancePool.elasticIPs?.first?.id == "44444444-4444-4444-4444-444444444444")
    #expect(instancePool.name == "web-pool")
    #expect(instancePool.instanceType?.id == "55555555-5555-5555-5555-555555555555")
    #expect(instancePool.minAvailable == 2)
    #expect(instancePool.privateNetworks?.first?.id == "66666666-6666-6666-6666-666666666666")
    #expect(instancePool.template?.id == "77777777-7777-7777-7777-777777777777")
    #expect(instancePool.state == .running)
    #expect(instancePool.size == 3)
    #expect(instancePool.sshKey?.name == "legacy-key")
    #expect(instancePool.instancePrefix == "web")
    #expect(instancePool.userData == "dXNlci1kYXRh")
    #expect(instancePool.manager?.type == .instancePool)
    #expect(instancePool.instances?.first?.id == "99999999-9999-9999-9999-999999999999")
    #expect(instancePool.deployTarget?.id == "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")
    #expect(instancePool.ipv6Enabled == true)
    #expect(instancePool.id == "11111111-1111-1111-1111-111111111111")
    #expect(instancePool.diskSize == 50)
    #expect(instancePool.sshKeys?.first?.name == "main-key")
}

@Test("Client builds Instance Pool action paths")
func clientBuildsInstancePoolActionPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let resetFieldRequest = try client.http.makeRequest("DELETE", path: "/instance-pool/pool-id/labels")
    let scaleRequest = try client.http.makeRequest("PUT", path: "/instance-pool/pool-id:scale")
    let evictRequest = try client.http.makeRequest("PUT", path: "/instance-pool/pool-id:evict")

    #expect(resetFieldRequest.url?.path == "/v2/instance-pool/pool-id/labels")
    #expect(scaleRequest.url?.path == "/v2/instance-pool/pool-id:scale")
    #expect(evictRequest.url?.path == "/v2/instance-pool/pool-id:evict")
}
