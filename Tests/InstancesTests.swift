@testable import Exoscale
import Foundation
import Testing

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
                "env": "prod"
            ])
        ]
    )

    let url = try #require(request.url)
    let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    let queryItems = try Dictionary(uniqueKeysWithValues: #require(components.queryItems).map { ($0.name, $0.value) })

    #expect(queryItems["manager-id"] == "pool-id")
    #expect(queryItems["manager-type"] == "instance-pool")
    #expect(queryItems["ip-address"] == "203.0.113.10")
    #expect(queryItems["labels"] == "env:prod,tier:web")
}

@Test("CreateInstanceBody encodes request body")
func createInstanceRequestEncodesRequestBody() throws {
    let request = CreateInstanceBody(
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
        sshKeys: [InstanceSSHKeyReference(name: "main-key")],
        ipForwarding: true
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
    #expect(object["ip-forwarding"] as? Bool == true)

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

@Test("UpdateInstanceBody encodes request body")
func updateInstanceRequestEncodesRequestBody() throws {
    let request = UpdateInstanceBody(
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
        ResetInstanceBody(
            template: InstanceIDReference(id: "11111111-1111-1111-1111-111111111111"),
            diskSize: 100
        )
    )
    let resetObject = try #require(JSONSerialization.jsonObject(with: resetData) as? [String: Any])
    let resetTemplate = try #require(resetObject["template"] as? [String: String])

    #expect(resetTemplate["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(resetObject["disk-size"] as? Int == 100)

    let resizeData = try JSONEncoder().encode(ResizeInstanceDiskBody(diskSize: 200))
    let resizeObject = try #require(JSONSerialization.jsonObject(with: resizeData) as? [String: Int])
    #expect(resizeObject["disk-size"] == 200)

    let scaleData = try JSONEncoder().encode(
        ScaleInstanceBody(instanceType: InstanceIDReference(id: "22222222-2222-2222-2222-222222222222"))
    )
    let scaleObject = try #require(JSONSerialization.jsonObject(with: scaleData) as? [String: [String: String]])
    #expect(scaleObject["instance-type"]?["id"] == "22222222-2222-2222-2222-222222222222")

    let startData = try JSONEncoder().encode(StartInstanceBody(rescueProfile: .netbootEFI))
    let startObject = try #require(JSONSerialization.jsonObject(with: startData) as? [String: String])
    #expect(startObject["rescue-profile"] == "netboot-efi")

    let revertData = try JSONEncoder().encode(
        RevertInstanceSnapshotBody(id: "33333333-3333-3333-3333-333333333333")
    )
    let revertObject = try #require(JSONSerialization.jsonObject(with: revertData) as? [String: String])
    #expect(revertObject["id"] == "33333333-3333-3333-3333-333333333333")
}

@Test("Instance one-off responses decode values")
func instanceOneOffResponsesDecodeValues() throws {
    let console = try JSONDecoder().decode(
        Exoscale.InstanceConsoleProxyURL.Payload.self,
        from: InstancesFixtures.console
    )
    let password = try JSONDecoder().decode(
        Exoscale.InstancePassword.Payload.self,
        from: Data(#"{"password":"secret-password"}"#.utf8)
    )

    #expect(console.url == "wss://console.example.com/session")
    #expect(console.host == "console.example.com")
    #expect(console.path == "/session")
    #expect(password.password == "secret-password")
}

@Test("ListInstancesData decodes instances")
func listInstancesResponseDecodesInstances() throws {
    let data = InstancesFixtures.data

    let response = try Exoscale.jsonDecoder().decode(ListInstancesData.self, from: data)

    #expect(response.instances.count == 1)
    #expect(response.instances[0].publicIpAssignment == .dual)
    #expect(response.instances[0].id == "11111111-1111-1111-1111-111111111111")
    #expect(response.instances[0].name == "web-1")
    #expect(response.instances[0].instanceType?.size == .medium)
    #expect(response.instances[0].instanceType?.family == .standard)
    #expect(response.instances[0].privateNetworks?.first?.macAddress == "02:00:00:00:00:20")
    #expect(response.instances[0].template?.bootMode == .uefi)
    #expect(response.instances[0].template?.visibility == .public)
    #expect(response.instances[0].state == .running)
    #expect(response.instances[0].sshKey?.name == "main-key")
    #expect(response.instances[0].publicIp == "203.0.113.10")
    #expect(response.instances[0].ipv6Address == "2001:db8::10")
    #expect(response.instances[0].macAddress == "02:00:00:00:00:10")
    #expect(response.instances[0].manager?.type == .instancePool)
    #expect(response.instances[0].sshKeys?.first?.fingerprint == "aa:bb:cc")
    #expect(response.instances[0].createdAt == Date(timeIntervalSince1970: 1_777_284_000))
    #expect(response.instances[0].labels == ["env": "prod"])
}

@Test("ListInstancesData keeps unknown instance type size and family")
func listInstancesResponseKeepsUnknownInstanceTypeSizeAndFamily() throws {
    let data = InstancesFixtures.data2

    let response = try Exoscale.jsonDecoder().decode(ListInstancesData.self, from: data)

    #expect(response.instances.count == 1)
    #expect(response.instances[0].instanceType?.size == .unknown("future-size"))
    #expect(response.instances[0].instanceType?.family == .unknown("future-family"))
}

@Test(
    "Instance creation sends ip-forwarding only when it is set",
    arguments: [(Bool?.none, Bool?.none), (true, true), (false, false)]
)
func createInstanceSendsIPForwardingOnlyWhenSet(ipForwarding: Bool?, sent: Bool?) async throws {
    let operation = #"{"id":"op-1","state":"pending"}"#
    let transport = ScriptedTransport([ScriptedResponse(body: Data(operation.utf8))])

    _ = try await transport.exoscale().instances.create(
        diskSize: 10,
        instanceTypeID: "33333333-3333-3333-3333-333333333333",
        templateID: "44444444-4444-4444-4444-444444444444",
        ipForwarding: ipForwarding
    )

    let body = try #require(transport.requests.first?.httpBody)
    let object = try #require(JSONSerialization.jsonObject(with: body) as? [String: Any])
    #expect(object.keys.contains("ip-forwarding") == (sent != nil))
    #expect(object["ip-forwarding"] as? Bool == sent)
}
