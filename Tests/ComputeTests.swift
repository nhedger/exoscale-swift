@testable import Exoscale
import Foundation
import Testing

@Test("Compute calls send the expected requests", arguments: [
    Call("list instance types", "GET /instance-type", response: "{}") { _ = try await $0.instanceTypes.list() },
    Call("get instance type", "GET /instance-type/t-1", response: #"{"id":"t-1"}"#) {
        _ = try await $0.instanceTypes.get(id: "t-1")
    },
    Call("list deploy targets", "GET /deploy-target", response: "{}") { _ = try await $0.deployTargets.list() },
    Call("get deploy target", "GET /deploy-target/dt-1", response: #"{"id":"dt-1"}"#) {
        _ = try await $0.deployTargets.get(id: "dt-1")
    },
    Call("list SSH keys", "GET /ssh-key", response: "{}") { _ = try await $0.sshKeys.list() },
    Call("get SSH key", "GET /ssh-key/my%20laptop", response: #"{"name":"my laptop"}"#) {
        _ = try await $0.sshKeys.get(name: "my laptop")
    },
    Call("register SSH key", "POST /ssh-key", body: #"{"name":"laptop","public-key":"ssh-ed25519 AAAA"}"#) {
        _ = try await $0.sshKeys.register(name: "laptop", publicKey: "ssh-ed25519 AAAA")
    },
    Call("delete SSH key", "DELETE /ssh-key/laptop") { _ = try await $0.sshKeys.delete(name: "laptop") },
    Call("list templates", "GET /template", query: ["visibility": "private", "family": "ubuntu"], response: "{}") {
        _ = try await $0.templates.list(visibility: .private, family: "ubuntu")
    },
    Call("get template", "GET /template/tpl-1", response: #"{"id":"tpl-1"}"#) {
        _ = try await $0.templates.get(id: "tpl-1")
    },
    Call(
        "register template",
        "POST /template",
        body: #"{"boot-mode":"uefi","checksum":"abc","name":"base","password-enabled":false,"#
            + #""ssh-key-enabled":true,"url":"https://example.com/base.qcow2"}"#
    ) {
        _ = try await $0.templates.register(
            name: "base",
            url: "https://example.com/base.qcow2",
            checksum: "abc",
            sshKeyEnabled: true,
            passwordEnabled: false,
            bootMode: .uefi
        )
    },
    Call("update template", "PUT /template/tpl-1", body: #"{"description":"Base image"}"#) {
        _ = try await $0.templates.update(id: "tpl-1", description: "Base image")
    },
    Call("copy template", "POST /template/tpl-1", body: #"{"target-zone":{"name":"de-fra-1"}}"#) {
        _ = try await $0.templates.copy(id: "tpl-1", to: .deFra1)
    },
    Call("delete template", "DELETE /template/tpl-1") { _ = try await $0.templates.delete(id: "tpl-1") },
    Call("list anti-affinity groups", "GET /anti-affinity-group", response: "{}") {
        _ = try await $0.antiAffinityGroups.list()
    },
    Call("get anti-affinity group", "GET /anti-affinity-group/aag-1", response: #"{"id":"aag-1"}"#) {
        _ = try await $0.antiAffinityGroups.get(id: "aag-1")
    },
    Call("create anti-affinity group", "POST /anti-affinity-group", body: #"{"name":"web"}"#) {
        _ = try await $0.antiAffinityGroups.create(name: "web")
    },
    Call("delete anti-affinity group", "DELETE /anti-affinity-group/aag-1") {
        _ = try await $0.antiAffinityGroups.delete(id: "aag-1")
    },
    Call("list snapshots", "GET /snapshot", response: "{}") { _ = try await $0.snapshots.list() },
    Call("get snapshot", "GET /snapshot/s-1", response: #"{"id":"s-1"}"#) { _ = try await $0.snapshots.get(id: "s-1") },
    Call("export snapshot", "POST /snapshot/s-1:export") { _ = try await $0.snapshots.export(id: "s-1") },
    Call("promote snapshot", "POST /snapshot/s-1:promote", body: #"{"default-user":"ubuntu","name":"golden"}"#) {
        _ = try await $0.snapshots.promote(id: "s-1", name: "golden", defaultUser: "ubuntu")
    },
    Call("delete snapshot", "DELETE /snapshot/s-1") { _ = try await $0.snapshots.delete(id: "s-1") }
])
func computeCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Instance types decode the fields the API returns")
func decodeInstanceTypes() async throws {
    let types = try await decode(
        #"{"instance-types":[{"id":"t-1","family":"gpua30","size":"medium","cpus":8,"gpus":1,"#
            + #""memory":34359738368,"authorized":true,"zones":["ch-gva-2","es-mad-1"]}]}"#,
        from: "/instance-type"
    ) { try await $0.instanceTypes.list() }
    #expect(types == [.init(
        id: "t-1",
        family: .gpuA30,
        size: .medium,
        cpus: 8,
        gpus: 1,
        memory: 34_359_738_368,
        authorized: true,
        zones: [.chGva2, .esMad1]
    )])
}

@Test("Templates decode the fields the API returns")
func decodeTemplates() async throws {
    let template = try await decode(
        #"{"id":"tpl-1","name":"Ubuntu","family":"ubuntu","visibility":"public","boot-mode":"uefi","#
            + #""default-user":"ubuntu","ssh-key-enabled":true,"password-enabled":false,"size":10737418240,"#
            + #""created-at":"2026-01-02T03:04:05Z"}"#,
        from: "/template/tpl-1"
    ) { try await $0.templates.get(id: "tpl-1") }
    #expect(template == .init(
        id: "tpl-1",
        name: "Ubuntu",
        family: "ubuntu",
        visibility: .public,
        size: 10_737_418_240,
        bootMode: .uefi,
        defaultUser: "ubuntu",
        sshKeyEnabled: true,
        passwordEnabled: false,
        createdAt: Date(timeIntervalSince1970: 1_767_323_045)
    ))
}

@Test("Snapshots decode the fields the API returns")
func decodeSnapshots() async throws {
    let snapshot = try await decode(
        #"{"id":"s-1","name":"daily","state":"exported","size":50,"instance":{"id":"i-1"},"#
            + #""application-consistent":true,"export":{"presigned-url":"https://sos/x","md5sum":"abc"}}"#,
        from: "/snapshot/s-1"
    ) { try await $0.snapshots.get(id: "s-1") }
    #expect(snapshot == .init(
        id: "s-1",
        name: "daily",
        state: .exported,
        size: 50,
        instance: .init(id: "i-1"),
        applicationConsistent: true,
        export: .init(presignedURL: "https://sos/x", md5sum: "abc")
    ))
}

@Test("Anti-affinity groups decode the fields the API returns")
func decodeAntiAffinityGroups() async throws {
    let group = try await decode(
        #"{"id":"aag-1","name":"web","description":"Web tier","instances":[{"id":"i-1"},{"id":"i-2"}]}"#,
        from: "/anti-affinity-group/aag-1"
    ) { try await $0.antiAffinityGroups.get(id: "aag-1") }
    #expect(group == .init(
        id: "aag-1",
        name: "web",
        description: "Web tier",
        instances: [.init(id: "i-1"), .init(id: "i-2")]
    ))
}

@Test("SSH keys decode the fields the API returns")
func decodeSSHKeys() async throws {
    let key = try await decode(#"{"name":"laptop","fingerprint":"aa:bb"}"#, from: "/ssh-key/laptop") {
        try await $0.sshKeys.get(name: "laptop")
    }
    #expect(key == .init(name: "laptop", fingerprint: "aa:bb"))
}

@Test("Deploy targets decode the fields the API returns")
func decodeDeployTargets() async throws {
    let target = try await decode(
        #"{"id":"dt-1","name":"dedicated-1","type":"dedicated"}"#,
        from: "/deploy-target/dt-1"
    ) {
        try await $0.deployTargets.get(id: "dt-1")
    }
    #expect(target == .init(id: "dt-1", name: "dedicated-1", type: .dedicated))
}
