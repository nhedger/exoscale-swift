@testable import Exoscale
import Foundation
import Testing

@Test("Block storage calls send the expected requests", arguments: [
    Call("list", "GET /block-storage", query: ["instance-id": "i-1"], response: "{}") {
        _ = try await $0.blockStorage.list(instanceID: "i-1")
    },
    Call("get", "GET /block-storage/vol-1", response: #"{"id":"vol-1"}"#) {
        _ = try await $0.blockStorage.get(id: "vol-1")
    },
    Call("create", "POST /block-storage", body: #"{"name":"data","size":100}"#) {
        _ = try await $0.blockStorage.create(name: "data", size: 100)
    },
    Call("restore", "POST /block-storage", body: #"{"block-storage-snapshot":{"id":"bss-1"},"name":"restored"}"#) {
        _ = try await $0.blockStorage.create(name: "restored", fromSnapshot: "bss-1")
    },
    Call("update", "PUT /block-storage/vol-1", body: #"{"labels":{"env":"prod"}}"#) {
        _ = try await $0.blockStorage.update(id: "vol-1", labels: ["env": "prod"])
    },
    Call(
        "resize",
        "PUT /block-storage/vol-1:resize-volume",
        body: #"{"size":200}"#,
        response: #"{"id":"vol-1","size":200}"#
    ) {
        _ = try await $0.blockStorage.resize(id: "vol-1", size: 200)
    },
    Call("delete", "DELETE /block-storage/vol-1") { _ = try await $0.blockStorage.delete(id: "vol-1") },
    Call("attach", "PUT /block-storage/vol-1:attach", body: #"{"instance":{"id":"i-1"}}"#) {
        _ = try await $0.blockStorage.attach(id: "vol-1", toInstance: "i-1")
    },
    Call("detach", "PUT /block-storage/vol-1:detach") { _ = try await $0.blockStorage.detach(id: "vol-1") },
    Call("create snapshot", "POST /block-storage/vol-1:create-snapshot", body: #"{"name":"nightly"}"#) {
        _ = try await $0.blockStorage.createSnapshot(of: "vol-1", name: "nightly")
    },
    Call("list snapshots", "GET /block-storage-snapshot", response: "{}") { _ = try await $0.blockStorage.snapshots() },
    Call("get snapshot", "GET /block-storage-snapshot/bss-1", response: #"{"id":"bss-1"}"#) {
        _ = try await $0.blockStorage.snapshot(id: "bss-1")
    },
    Call("update snapshot", "PUT /block-storage-snapshot/bss-1", body: #"{"name":"weekly"}"#) {
        _ = try await $0.blockStorage.updateSnapshot(id: "bss-1", name: "weekly")
    },
    Call("delete snapshot", "DELETE /block-storage-snapshot/bss-1") {
        _ = try await $0.blockStorage.deleteSnapshot(id: "bss-1")
    }
])
func blockStorageCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Platform calls send the expected requests", arguments: [
    Call("bucket usage", "GET /sos-buckets-usage", response: "{}") { _ = try await $0.objectStorage.bucketUsage() },
    Call(
        "presigned URL",
        "GET /sos/assets/presigned-url",
        query: ["key": "reports/q3+q4.pdf"],
        response: #"{"url":"https://sos-ch-gva-2.exo.io/assets/reports"}"#
    ) {
        _ = try await $0.objectStorage.presignedURL(bucket: "assets", key: "reports/q3+q4.pdf")
    },
    Call("zones", "GET /zone", response: "{}") { _ = try await $0.zones.list() },
    Call("quotas", "GET /quota", response: "{}") { _ = try await $0.quotas.list() },
    Call("quota", "GET /quota/instance", response: #"{"resource":"instance"}"#) {
        _ = try await $0.quotas.get(resource: "instance")
    }
])
func platformCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Block storage volumes and snapshots decode")
func decodeBlockStorage() async throws {
    let volume = try await decode(
        #"{"id":"vol-1","name":"data","state":"attached","size":100,"blocksize":4096,"encrypted":true,"#
            + #""instance":{"id":"i-1"},"block-storage-snapshots":[{"id":"bss-1"}],"labels":{"env":"prod"}}"#,
        from: "/block-storage/vol-1"
    ) { try await $0.blockStorage.get(id: "vol-1") }
    #expect(volume == .init(
        id: "vol-1",
        name: "data",
        state: .attached,
        size: 100,
        blockSize: 4096,
        encrypted: true,
        instance: .init(id: "i-1"),
        snapshots: [.init(id: "bss-1")],
        labels: ["env": "prod"]
    ))

    let snapshot = try await decode(
        #"{"id":"bss-1","name":"nightly","state":"created","size":12,"volume-size":100,"#
            + #""block-storage-volume":{"id":"vol-1"}}"#,
        from: "/block-storage-snapshot/bss-1"
    ) { try await $0.blockStorage.snapshot(id: "bss-1") }
    #expect(snapshot == .init(
        id: "bss-1",
        name: "nightly",
        state: .created,
        size: 12,
        volumeSize: 100,
        volume: .init(id: "vol-1")
    ))
}

@Test("Bucket usage, zones and quotas decode")
func decodePlatform() async throws {
    let usage = try await decode(
        #"{"sos-buckets-usage":[{"name":"assets","zone-name":"de-fra-1","size":1024}]}"#,
        from: "/sos-buckets-usage"
    ) { try await $0.objectStorage.bucketUsage() }
    #expect(usage == [.init(name: "assets", zone: .deFra1, size: 1024)])

    let zones = try await decode(
        #"{"zones":[{"name":"es-mad-1","api-endpoint":"https://api-es-mad-1.exoscale.com/v2"}]}"#,
        from: "/zone"
    ) { try await $0.zones.list() }
    #expect(zones == [.init(name: .esMad1, apiEndpoint: "https://api-es-mad-1.exoscale.com/v2")])

    let quota = try await decode(#"{"resource":"gpu","usage":0,"limit":-1}"#, from: "/quota/gpu") {
        try await $0.quotas.get(resource: "gpu")
    }
    #expect(quota == .init(resource: "gpu", usage: 0, limit: -1))
}
