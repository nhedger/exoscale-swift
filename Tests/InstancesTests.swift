@testable import Exoscale
import Foundation
import Testing

private let instanceJSON = """
{
  "id": "i-1",
  "name": "web-1",
  "state": "running",
  "created-at": "2026-10-01T08:30:00Z",
  "instance-type": {"id": "type-1"},
  "template": {"id": "tpl-1", "name": "Ubuntu 26.04"},
  "disk-size": 50,
  "disk-encrypted": true,
  "labels": {"env": "prod"},
  "public-ip": "203.0.113.10",
  "ipv6-address": "2001:db8::10",
  "public-ip-assignment": "dual",
  "mac-address": "06:00:00:00:00:01",
  "security-groups": [{"id": "sg-1"}],
  "anti-affinity-groups": [{"id": "aag-1"}],
  "elastic-ips": [{"id": "eip-1"}],
  "private-networks": [{"id": "pn-1", "mac-address": "06:00:00:00:00:02"}],
  "vpc": {"id": "vpc-1", "name": "main", "subnets": [{"id": "sub-1", "name": "a", "ipv4": "10.0.0.5"}]},
  "ip-forwarding": true,
  "ssh-keys": [{"name": "laptop", "fingerprint": "aa:bb"}],
  "user-data": "I2Nsb3VkLWNvbmZpZw==",
  "manager": {"id": "pool-1", "type": "instance-pool"},
  "deploy-target": {"id": "dt-1"},
  "snapshots": [{"id": "snap-1"}],
  "secureboot-enabled": false,
  "tpm-enabled": true,
  "application-consistent-snapshot-enabled": true
}
"""

@Test("Instances decode every field the API returns")
func instanceDecoding() async throws {
    let stub = try Stub(json: instanceJSON)
    let instance = try await stub.exoscale.instances.get(id: "i-1")

    #expect(try stub.request.endpoint == "GET /instance/i-1")
    #expect(instance == Exoscale.Instance(
        id: "i-1",
        name: "web-1",
        state: .running,
        createdAt: Date(timeIntervalSince1970: 1_790_843_400),
        instanceType: .init(id: "type-1"),
        template: .init(id: "tpl-1", name: "Ubuntu 26.04"),
        diskSize: 50,
        diskEncrypted: true,
        labels: ["env": "prod"],
        publicIP: "203.0.113.10",
        ipv6Address: "2001:db8::10",
        publicIPAssignment: .dual,
        macAddress: "06:00:00:00:00:01",
        securityGroups: [.init(id: "sg-1")],
        antiAffinityGroups: [.init(id: "aag-1")],
        elasticIPs: [.init(id: "eip-1")],
        privateNetworks: [.init(id: "pn-1", macAddress: "06:00:00:00:00:02")],
        vpc: .init(id: "vpc-1", name: "main", subnets: [.init(id: "sub-1", name: "a", ipv4: "10.0.0.5")]),
        ipForwarding: true,
        sshKeys: [.init(name: "laptop")],
        userData: "I2Nsb3VkLWNvbmZpZw==",
        manager: .init(id: "pool-1", type: .instancePool),
        deployTarget: .init(id: "dt-1"),
        snapshots: [.init(id: "snap-1")],
        secureBootEnabled: false,
        tpmEnabled: true,
        applicationConsistentSnapshotEnabled: true
    ))
}

@Test("Listing sends its filters and accepts a missing list")
func listInstances() async throws {
    let stub = try Stub(
        StubResponse(body: #"{"instances":[{"id":"i-1","name":"web-1","state":"stopped"},{"id":"i-2"}]}"#),
        StubResponse(body: "{}")
    )
    let instances = try await stub.exoscale.instances.list(
        instancePoolID: "pool-1",
        ipAddress: "203.0.113.10",
        labels: ["tier": "web", "env": "prod"]
    )
    let none = try await stub.exoscale.instances.list()

    #expect(instances == [.init(id: "i-1", name: "web-1", state: .stopped), .init(id: "i-2")])
    #expect(none.isEmpty)
    #expect(stub.requests[0].endpoint == "GET /instance")
    #expect(stub.requests[0].formDecodedQuery == [
        "manager-id": "pool-1",
        "manager-type": "instance-pool",
        "ip-address": "203.0.113.10",
        "labels": "env:prod,tier:web"
    ])
    #expect(stub.requests[1].url?.query == nil)
}

@Test("Creating an instance sends references as objects and leaves out unset fields")
func createInstance() async throws {
    let stub = try Stub(json: #"{"id":"op-1","state":"pending","reference":{"id":"i-1"}}"#)
    let operation = try await stub.exoscale.instances.create(
        name: "web-1",
        instanceTypeID: "type-1",
        templateID: "tpl-1",
        diskSize: 50,
        sshKeys: ["laptop"],
        securityGroupIDs: ["sg-1"],
        publicIPAssignment: .ipv4,
        labels: ["env": "prod"],
        vpc: .init(id: "vpc-1", subnets: [.init(id: "sub-1")]),
        ipForwarding: true,
        autoStart: false
    )

    #expect(operation.reference?.id == "i-1")
    let request = try stub.request
    #expect(request.endpoint == "POST /instance")
    #expect(request.hasValidSignature())
    let body = try #require(request.jsonBody)
    #expect(Set(body.keys) == [
        "name", "instance-type", "template", "disk-size", "ssh-keys", "security-groups",
        "public-ip-assignment", "labels", "vpc", "ip-forwarding", "auto-start"
    ])
    #expect(body["instance-type"] as? [String: String] == ["id": "type-1"])
    #expect(body["ssh-keys"] as? [[String: String]] == [["name": "laptop"]])
    #expect(body["security-groups"] as? [[String: String]] == [["id": "sg-1"]])
    #expect(body["public-ip-assignment"] as? String == "inet4")
    #expect(body["auto-start"] as? Bool == false)
    let vpc = try #require(body["vpc"] as? [String: Any])
    #expect(vpc["id"] as? String == "vpc-1")
    #expect(vpc["subnets"] as? [[String: String]] == [["id": "sub-1"]])
}

@Test("Updating sends only the values passed")
func updateInstance() async throws {
    let stub = try Stub(json: #"{"id":"op-1"}"#)
    _ = try await stub.exoscale.instances.update(id: "i-1", name: "web-2", labels: [:])
    let request = try stub.request
    #expect(request.endpoint == "PUT /instance/i-1")
    #expect(request.bodyText == #"{"labels":{},"name":"web-2"}"#)
}

/// An action, the endpoint it calls and the body it sends.
private struct Action: Sendable, CustomTestStringConvertible {
    let testDescription: String
    let endpoint: String
    var body: String?
    let call: @Sendable (Exoscale.Instances) async throws -> Exoscale.Operation
}

private let actions = [
    Action(testDescription: "start", endpoint: "PUT /instance/i-1:start", body: "{}") {
        try await $0.start(id: "i-1")
    },
    Action(testDescription: "rescue", endpoint: "PUT /instance/i-1:start", body: #"{"rescue-profile":"netboot-efi"}"#) {
        try await $0.start(id: "i-1", rescueProfile: .netbootEFI)
    },
    Action(testDescription: "stop", endpoint: "PUT /instance/i-1:stop") { try await $0.stop(id: "i-1") },
    Action(testDescription: "reboot", endpoint: "PUT /instance/i-1:reboot") { try await $0.reboot(id: "i-1") },
    Action(testDescription: "scale", endpoint: "PUT /instance/i-1:scale", body: #"{"instance-type":{"id":"type-2"}}"#) {
        try await $0.scale(id: "i-1", instanceTypeID: "type-2")
    },
    Action(testDescription: "resize disk", endpoint: "PUT /instance/i-1:resize-disk", body: #"{"disk-size":100}"#) {
        try await $0.resizeDisk(id: "i-1", size: 100)
    },
    Action(testDescription: "reset", endpoint: "PUT /instance/i-1:reset", body: #"{"template":{"id":"tpl-2"}}"#) {
        try await $0.reset(id: "i-1", templateID: "tpl-2")
    },
    Action(testDescription: "reset password", endpoint: "PUT /instance/i-1:reset-password") {
        try await $0.resetPassword(id: "i-1")
    },
    Action(testDescription: "create snapshot", endpoint: "POST /instance/i-1:create-snapshot") {
        try await $0.createSnapshot(id: "i-1")
    },
    Action(testDescription: "revert", endpoint: "POST /instance/i-1:revert-snapshot", body: #"{"id":"snap-1"}"#) {
        try await $0.revert(id: "i-1", toSnapshot: "snap-1")
    },
    Action(testDescription: "protect", endpoint: "PUT /instance/i-1:add-protection") { try await $0.protect(id: "i-1")
    },
    Action(testDescription: "unprotect", endpoint: "PUT /instance/i-1:remove-protection") {
        try await $0.unprotect(id: "i-1")
    },
    Action(testDescription: "enable TPM", endpoint: "POST /instance/i-1:enable-tpm") {
        try await $0.enableTPM(id: "i-1")
    },
    Action(testDescription: "remove labels", endpoint: "DELETE /instance/i-1/labels") {
        try await $0.removeLabels(id: "i-1")
    },
    Action(testDescription: "delete", endpoint: "DELETE /instance/i-1") { try await $0.delete(id: "i-1") }
]

@Test("Actions call their endpoint with the right body", arguments: actions)
private func instanceActions(action: Action) async throws {
    let stub = try Stub(json: #"{"id":"op-1","state":"pending"}"#)
    let operation = try await action.call(stub.exoscale.instances)
    let request = try stub.request

    #expect(operation.id == "op-1")
    #expect(request.endpoint == action.endpoint)
    #expect(request.bodyText == action.body)
    #expect(request.hasValidSignature())
}

@Test("Passwords and console URLs are unwrapped from their responses")
func passwordAndConsole() async throws {
    let password = try Stub(json: #"{"password":"hunter2"}"#)
    #expect(try await password.exoscale.instances.password(id: "i-1") == "hunter2")
    #expect(try password.request.endpoint == "GET /instance/i-1:password")

    let console = try Stub(json: #"{"url":"https://console.exoscale.com/v1/i-1?signature=x","host":"h","path":"p"}"#)
    #expect(try await console.exoscale.instances.consoleURL(id: "i-1")
        .absoluteString == "https://console.exoscale.com/v1/i-1?signature=x")
    #expect(try console.request.endpoint == "GET /console/i-1")

    let missing = try Stub(json: "{}")
    await #expect(throws: Exoscale.ClientError.invalidResponse) {
        try await missing.exoscale.instances.consoleURL(id: "i-1")
    }
}

@Test("Unknown states and assignments decode instead of failing")
func unknownValues() async throws {
    let stub = try Stub(json: #"{"id":"i-1","state":"hibernating","public-ip-assignment":"ipv6-only"}"#)
    let instance = try await stub.exoscale.instances.get(id: "i-1")
    #expect(instance.state?.rawValue == "hibernating")
    #expect(instance.publicIPAssignment?.rawValue == "ipv6-only")
}

@Test("Timestamps decode with or without fractional seconds")
func fractionalTimestamps() async throws {
    let stub = try Stub(json: #"{"instances":[{"id":"i-1","created-at":"2026-10-01T08:30:00.5Z"}]}"#)
    let instances = try await stub.exoscale.instances.list()
    #expect(instances.first?.createdAt == Date(timeIntervalSince1970: 1_790_843_400.5))
}
