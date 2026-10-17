@testable import Exoscale
import Foundation
import Testing

@Test("Instance pool calls send the expected requests", arguments: [
    Call("list", "GET /instance-pool", response: "{}") { _ = try await $0.instancePools.list() },
    Call("get", "GET /instance-pool/pool-1", response: #"{"id":"pool-1"}"#) {
        _ = try await $0.instancePools.get(id: "pool-1")
    },
    Call(
        "create",
        "POST /instance-pool",
        body: #"{"disk-size":20,"instance-type":{"id":"type-1"},"name":"web","private-networks":[{"id":"pn-1"}],"#
            + #""size":3,"ssh-keys":[{"name":"laptop"}],"template":{"id":"tpl-1"}}"#
    ) {
        _ = try await $0.instancePools.create(
            name: "web",
            size: 3,
            instanceTypeID: "type-1",
            templateID: "tpl-1",
            diskSize: 20,
            sshKeys: ["laptop"],
            privateNetworkIDs: ["pn-1"]
        )
    },
    Call("update", "PUT /instance-pool/pool-1", body: #"{"min-available":1,"template":{"id":"tpl-2"}}"#) {
        _ = try await $0.instancePools.update(id: "pool-1", templateID: "tpl-2", minAvailable: 1)
    },
    Call("reset", "DELETE /instance-pool/pool-1/security-groups") {
        _ = try await $0.instancePools.reset(.securityGroups, id: "pool-1")
    },
    Call("scale", "PUT /instance-pool/pool-1:scale", body: #"{"size":5}"#) {
        _ = try await $0.instancePools.scale(id: "pool-1", size: 5)
    },
    Call("evict", "PUT /instance-pool/pool-1:evict", body: #"{"instances":["i-1","i-2"]}"#) {
        _ = try await $0.instancePools.evict(instanceIDs: ["i-1", "i-2"], from: "pool-1")
    },
    Call("delete", "DELETE /instance-pool/pool-1") { _ = try await $0.instancePools.delete(id: "pool-1") }
])
func instancePoolCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Instance pools decode their state, members and error reason")
func decodeInstancePools() async throws {
    let pool = try await decode(
        #"{"id":"pool-1","name":"web","state":"error","size":3,"min-available":1,"#
            + #""error-reason":{"cause":"quota","type":"quota-exceeded","job-id":"job-1"},"#
            + #""instances":[{"id":"i-1"}],"instance-prefix":"web","instance-type":{"id":"type-1"},"#
            + #""template":{"id":"tpl-1"},"disk-size":20,"manager":{"id":"np-1","type":"sks-nodepool"},"#
            + #""private-networks":[{"id":"pn-1"}],"ssh-keys":[{"name":"laptop"}],"ipv6-enabled":true}"#,
        from: "/instance-pool/pool-1"
    ) { try await $0.instancePools.get(id: "pool-1") }
    #expect(pool == .init(
        id: "pool-1",
        name: "web",
        state: .error,
        errorReason: .init(cause: "quota", type: "quota-exceeded", jobID: "job-1"),
        size: 3,
        minAvailable: 1,
        instances: [.init(id: "i-1")],
        instancePrefix: "web",
        manager: .init(id: "np-1", type: .sksNodepool),
        instanceType: .init(id: "type-1"),
        template: .init(id: "tpl-1"),
        diskSize: 20,
        ipv6Enabled: true,
        privateNetworks: [.init(id: "pn-1")],
        sshKeys: [.init(name: "laptop")]
    ))
}
