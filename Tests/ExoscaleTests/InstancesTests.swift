import Foundation
import Testing

@testable import Exoscale

@Test("serializeLabels encodes labels deterministically")
func serializeLabelsEncodesLabelsDeterministically() {
    #expect(serializeLabels(nil) == nil)
    #expect(serializeLabels([:]) == nil)
    #expect(serializeLabels(["tier": "web", "env": "prod"]) == "env:prod,tier:web")
}

@Test("Client encodes instance list filters")
func clientEncodesInstanceListFilters() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let request = try client.http.makeRequest(
        "GET",
        path: "/instance",
        query: [
            "manager-id": "pool-id",
            "manager-type": "instance-pool",
            "ip-address": "203.0.113.10",
            "labels": serializeLabels([
                "tier": "web",
                "env": "prod",
            ]),
        ]
    )

    let url = try #require(request.url)
    let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    let queryItems = Dictionary(uniqueKeysWithValues: try #require(components.queryItems).map { ($0.name, $0.value) })

    #expect(queryItems["manager-id"] == "pool-id")
    #expect(queryItems["manager-type"] == "instance-pool")
    #expect(queryItems["ip-address"] == "203.0.113.10")
    #expect(queryItems["labels"] == "env:prod,tier:web")
}

@Test("CreateInstanceRequest encodes request body")
func createInstanceRequestEncodesRequestBody() throws {
    let request = CreateInstanceRequest(
        applicationConsistentSnapshotEnabled: true,
        antiAffinityGroups: [InstanceIDReference(id: "11111111-1111-1111-1111-111111111111")],
        publicIPAssignment: .dual,
        labels: ["env": "prod"],
        autoStart: true,
        securityGroups: [InstanceIDReference(id: "22222222-2222-2222-2222-222222222222")],
        name: "web-1",
        instanceType: InstanceIDReference(id: "33333333-3333-3333-3333-333333333333"),
        template: InstanceIDReference(id: "44444444-4444-4444-4444-444444444444"),
        secureBootEnabled: true,
        sshKey: InstanceSSHKeyReference(name: "legacy-key"),
        userData: "dXNlci1kYXRh",
        tpmEnabled: true,
        deployTarget: InstanceIDReference(id: "55555555-5555-5555-5555-555555555555"),
        ipv6Enabled: true,
        diskSize: 50,
        sshKeys: [InstanceSSHKeyReference(name: "main-key")]
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["application-consistent-snapshot-enabled"] as? Bool == true)
    #expect(object["public-ip-assignment"] as? String == "dual")
    #expect((object["labels"] as? [String: String])?["env"] == "prod")
    #expect(object["auto-start"] as? Bool == true)
    #expect(object["name"] as? String == "web-1")
    #expect(object["secureboot-enabled"] as? Bool == true)
    #expect(object["user-data"] as? String == "dXNlci1kYXRh")
    #expect(object["tpm-enabled"] as? Bool == true)
    #expect(object["ipv6-enabled"] as? Bool == true)
    #expect(object["disk-size"] as? Int == 50)

    let antiAffinityGroup = try #require((object["anti-affinity-groups"] as? [[String: String]])?.first)
    let securityGroup = try #require((object["security-groups"] as? [[String: String]])?.first)
    let instanceType = try #require(object["instance-type"] as? [String: String])
    let template = try #require(object["template"] as? [String: String])
    let sshKey = try #require(object["ssh-key"] as? [String: String])
    let deployTarget = try #require(object["deploy-target"] as? [String: String])
    let sshKeys = try #require(object["ssh-keys"] as? [[String: String]])

    #expect(antiAffinityGroup["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(securityGroup["id"] == "22222222-2222-2222-2222-222222222222")
    #expect(instanceType["id"] == "33333333-3333-3333-3333-333333333333")
    #expect(template["id"] == "44444444-4444-4444-4444-444444444444")
    #expect(sshKey["name"] == "legacy-key")
    #expect(deployTarget["id"] == "55555555-5555-5555-5555-555555555555")
    #expect(sshKeys.first?["name"] == "main-key")
}

@Test("UpdateInstanceRequest encodes request body")
func updateInstanceRequestEncodesRequestBody() throws {
    let request = UpdateInstanceRequest(
        name: "web-2",
        userData: "bmV3LXVzZXItZGF0YQ==",
        publicIPAssignment: .inet4,
        labels: ["env": "staging"],
        applicationConsistentSnapshotEnabled: false
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "web-2")
    #expect(object["user-data"] as? String == "bmV3LXVzZXItZGF0YQ==")
    #expect(object["public-ip-assignment"] as? String == "inet4")
    #expect((object["labels"] as? [String: String])?["env"] == "staging")
    #expect(object["application-consistent-snapshot-enabled"] as? Bool == false)
}

@Test("Instance action requests encode request bodies")
func instanceActionRequestsEncodeRequestBodies() throws {
    let resetData = try JSONEncoder().encode(
        ResetInstanceRequest(
            template: InstanceIDReference(id: "11111111-1111-1111-1111-111111111111"),
            diskSize: 100
        )
    )
    let resetObject = try #require(JSONSerialization.jsonObject(with: resetData) as? [String: Any])
    let resetTemplate = try #require(resetObject["template"] as? [String: String])

    #expect(resetTemplate["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(resetObject["disk-size"] as? Int == 100)

    let resizeData = try JSONEncoder().encode(ResizeInstanceDiskRequest(diskSize: 200))
    let resizeObject = try #require(JSONSerialization.jsonObject(with: resizeData) as? [String: Int])
    #expect(resizeObject["disk-size"] == 200)

    let scaleData = try JSONEncoder().encode(
        ScaleInstanceRequest(instanceType: InstanceIDReference(id: "22222222-2222-2222-2222-222222222222"))
    )
    let scaleObject = try #require(JSONSerialization.jsonObject(with: scaleData) as? [String: [String: String]])
    #expect(scaleObject["instance-type"]?["id"] == "22222222-2222-2222-2222-222222222222")

    let startData = try JSONEncoder().encode(StartInstanceRequest(rescueProfile: .netbootEFI))
    let startObject = try #require(JSONSerialization.jsonObject(with: startData) as? [String: String])
    #expect(startObject["rescue-profile"] == "netboot-efi")

    let revertData = try JSONEncoder().encode(
        RevertInstanceSnapshotRequest(id: "33333333-3333-3333-3333-333333333333")
    )
    let revertObject = try #require(JSONSerialization.jsonObject(with: revertData) as? [String: String])
    #expect(revertObject["id"] == "33333333-3333-3333-3333-333333333333")
}

@Test("Instance one-off responses decode values")
func instanceOneOffResponsesDecodeValues() throws {
    let console = try JSONDecoder().decode(
        Exoscale.InstanceConsoleProxyURL.self,
        from: Data(
            """
            {
              "url": "wss://console.example.com/session",
              "host": "console.example.com",
              "path": "/session"
            }
            """.utf8
        )
    )
    let password = try JSONDecoder().decode(
        Exoscale.InstancePassword.self,
        from: Data(#"{"password":"secret-password"}"#.utf8)
    )

    #expect(console.url == "wss://console.example.com/session")
    #expect(console.host == "console.example.com")
    #expect(console.path == "/session")
    #expect(password.password == "secret-password")
}

@Test("ListInstancesResponse decodes instances")
func listInstancesResponseDecodesInstances() throws {
    let data = Data(
        """
        {
          "instances": [
            {
              "application-consistent-snapshot-enabled": true,
              "anti-affinity-groups": [
                { "id": "22222222-2222-2222-2222-222222222222" }
              ],
              "public-ip-assignment": "dual",
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "web-1",
              "instance-type": {
                "id": "33333333-3333-3333-3333-333333333333",
                "size": "medium",
                "family": "standard",
                "cpus": 2,
                "gpus": 0,
                "authorized": false,
                "memory": 4096,
                "zones": ["ch-gva-2"]
              },
              "private-networks": [
                {
                  "id": "44444444-4444-4444-4444-444444444444",
                  "mac-address": "02:00:00:00:00:20"
                }
              ],
              "template": {
                "id": "55555555-5555-5555-5555-555555555555",
                "name": "Linux template",
                "boot-mode": "uefi",
                "visibility": "public"
              },
              "state": "running",
              "secureboot-enabled": true,
              "ssh-key": {
                "name": "main-key",
                "fingerprint": "aa:bb:cc"
              },
              "user-data": "dXNlci1kYXRh",
              "public-ip": "203.0.113.10",
              "ipv6-address": "2001:db8::10",
              "mac-address": "02:00:00:00:00:10",
              "manager": {
                "id": "66666666-6666-6666-6666-666666666666",
                "type": "instance-pool"
              },
              "tpm-enabled": true,
              "deploy-target": {
                "id": "77777777-7777-7777-7777-777777777777"
              },
              "snapshots": [
                { "id": "88888888-8888-8888-8888-888888888888" }
              ],
              "disk-size": 50,
              "ssh-keys": [
                {
                  "name": "main-key",
                  "fingerprint": "aa:bb:cc"
                }
              ],
              "created-at": "2026-04-27T10:00:00Z",
              "labels": {
                "env": "prod"
              }
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListInstancesResponse.self, from: data)

    #expect(response.instances.count == 1)
    #expect(response.instances[0].applicationConsistentSnapshotEnabled == true)
    #expect(response.instances[0].antiAffinityGroups?.first?.id == "22222222-2222-2222-2222-222222222222")
    #expect(response.instances[0].publicIpAssignment == .dual)
    #expect(response.instances[0].id == "11111111-1111-1111-1111-111111111111")
    #expect(response.instances[0].name == "web-1")
    #expect(response.instances[0].instanceType?.size == .medium)
    #expect(response.instances[0].instanceType?.family == .standard)
    #expect(response.instances[0].privateNetworks?.first?.macAddress == "02:00:00:00:00:20")
    #expect(response.instances[0].template?.bootMode == .uefi)
    #expect(response.instances[0].template?.visibility == .public)
    #expect(response.instances[0].state == .running)
    #expect(response.instances[0].secureBootEnabled == true)
    #expect(response.instances[0].sshKey?.name == "main-key")
    #expect(response.instances[0].userData == "dXNlci1kYXRh")
    #expect(response.instances[0].publicIp == "203.0.113.10")
    #expect(response.instances[0].ipv6Address == "2001:db8::10")
    #expect(response.instances[0].macAddress == "02:00:00:00:00:10")
    #expect(response.instances[0].manager?.type == .instancePool)
    #expect(response.instances[0].tpmEnabled == true)
    #expect(response.instances[0].deployTarget?.id == "77777777-7777-7777-7777-777777777777")
    #expect(response.instances[0].snapshots?.first?.id == "88888888-8888-8888-8888-888888888888")
    #expect(response.instances[0].diskSize == 50)
    #expect(response.instances[0].sshKeys?.first?.fingerprint == "aa:bb:cc")
    #expect(response.instances[0].createdAt == "2026-04-27T10:00:00Z")
    #expect(response.instances[0].labels == ["env": "prod"])
}

@Test("ListInstancesResponse tolerates unknown instance type size and family")
func listInstancesResponseToleratesUnknownInstanceTypeSizeAndFamily() throws {
    let data = Data(
        """
        {
          "instances": [
            {
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "web-1",
              "instance-type": {
                "size": "future-size",
                "family": "future-family"
              }
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListInstancesResponse.self, from: data)

    #expect(response.instances.count == 1)
    #expect(response.instances[0].instanceType?.size == nil)
    #expect(response.instances[0].instanceType?.family == nil)
}
