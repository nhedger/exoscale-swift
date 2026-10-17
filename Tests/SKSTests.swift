@testable import Exoscale
import Foundation
import Testing

private let kubeconfig = "apiVersion: v1\nkind: Config\n"
private let kubeconfigResponse = #"{"kubeconfig":"\#(Data(kubeconfig.utf8).base64EncodedString())"}"#

@Test("SKS cluster calls send the expected requests", arguments: [
    Call("list", "GET /sks-cluster", response: "{}") { _ = try await $0.sksClusters.list() },
    Call("get", "GET /sks-cluster/c-1", response: #"{"id":"c-1"}"#) { _ = try await $0.sksClusters.get(id: "c-1") },
    Call("versions", "GET /sks-cluster-version", query: ["include-deprecated": "true"], response: "{}") {
        _ = try await $0.sksClusters.versions(includeDeprecated: true)
    },
    Call(
        "create",
        "POST /sks-cluster",
        body: #"{"addons":["exoscale-cloud-controller","karpenter"],"cni":"cilium","level":"pro","name":"prod","#
            + #""oidc":{"client-id":"sks","issuer-url":"https://id.example.com"},"version":"1.34.1"}"#
    ) {
        _ = try await $0.sksClusters.create(
            name: "prod",
            version: "1.34.1",
            level: .pro,
            cni: .cilium,
            addons: [.cloudController, .karpenter],
            oidc: .init(clientID: "sks", issuerURL: "https://id.example.com")
        )
    },
    Call("update", "PUT /sks-cluster/c-1", body: #"{"audit":{"enabled":false},"auto-upgrade":true}"#) {
        _ = try await $0.sksClusters.update(id: "c-1", autoUpgrade: true, audit: .init(enabled: false))
    },
    Call("upgrade", "PUT /sks-cluster/c-1/upgrade", body: #"{"version":"1.35.0"}"#) {
        _ = try await $0.sksClusters.upgrade(id: "c-1", toVersion: "1.35.0")
    },
    Call("upgrade to pro", "PUT /sks-cluster/c-1/upgrade-service-level") {
        _ = try await $0.sksClusters.upgradeToPro(id: "c-1")
    },
    Call("delete", "DELETE /sks-cluster/c-1") { _ = try await $0.sksClusters.delete(id: "c-1") },
    Call(
        "kubeconfig",
        "POST /sks-cluster-kubeconfig/c-1",
        body: #"{"groups":["system:masters"],"ttl":3600,"user":"admin"}"#,
        response: kubeconfigResponse
    ) {
        _ = try await $0.sksClusters.kubeconfig(id: "c-1", user: "admin", groups: ["system:masters"], ttl: 3600)
    },
    Call("certificate", "GET /sks-cluster/c-1/authority/control-plane/cert", response: #"{"cacert":"Q0VSVA=="}"#) {
        _ = try await $0.sksClusters.certificate(of: .controlPlane, cluster: "c-1")
    },
    Call("deprecated resources", "GET /sks-cluster-deprecated-resources/c-1", response: "[]") {
        _ = try await $0.sksClusters.deprecatedResources(id: "c-1")
    },
    Call("inspection", "GET /sks-cluster/c-1/inspection", response: "{}") {
        _ = try await $0.sksClusters.inspection(id: "c-1")
    },
    Call("rotate CCM", "PUT /sks-cluster/c-1/rotate-ccm-credentials") {
        _ = try await $0.sksClusters.rotateCCMCredentials(id: "c-1")
    },
    Call("rotate CSI", "PUT /sks-cluster/c-1/rotate-csi-credentials") {
        _ = try await $0.sksClusters.rotateCSICredentials(id: "c-1")
    },
    Call("rotate Karpenter", "PUT /sks-cluster/c-1/rotate-karpenter-credentials") {
        _ = try await $0.sksClusters.rotateKarpenterCredentials(id: "c-1")
    },
    Call("rotate operators CA", "PUT /sks-cluster/c-1/rotate-operators-ca") {
        _ = try await $0.sksClusters.rotateOperatorsCA(id: "c-1")
    },
    Call(
        "Karpenter node pool",
        "PUT /sks-cluster/c-1/generate-karpenter-nodepool",
        response: #"{"nodepool":"kind: NodePool"}"#
    ) {
        _ = try await $0.sksClusters.karpenterNodepoolManifest(id: "c-1")
    },
    Call(
        "Karpenter node class",
        "PUT /sks-cluster/c-1/generate-karpenter-exoscale-nodeclass",
        response: #"{"exoscale-nodeclass":"kind: ExoscaleNodeClass"}"#
    ) {
        _ = try await $0.sksClusters.karpenterNodeClassManifest(id: "c-1")
    },
    Call("active template", "GET /sks-template/1.34.1/nvidia", response: #"{"active-template":"tpl-1"}"#) {
        _ = try await $0.sksClusters.activeTemplate(kubernetesVersion: "1.34.1", variant: .nvidia)
    }
])
func sksClusterCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("SKS node pool calls send the expected requests", arguments: [
    Call("get", "GET /sks-cluster/c-1/nodepool/np-1", response: #"{"id":"np-1"}"#) {
        _ = try await $0.sksClusters.nodepools(in: "c-1").get(id: "np-1")
    },
    Call(
        "create",
        "POST /sks-cluster/c-1/nodepool",
        body: #"{"disk-size":50,"instance-type":{"id":"type-1"},"kubelet-max-pods":200,"name":"workers","size":3,"#
            + #""taints":{"gpu":{"effect":"NoSchedule","value":"true"}}}"#
    ) {
        _ = try await $0.sksClusters.nodepools(in: "c-1").create(
            name: "workers",
            size: 3,
            instanceTypeID: "type-1",
            diskSize: 50,
            taints: ["gpu": .init(value: "true", effect: .noSchedule)],
            kubeletMaxPods: 200
        )
    },
    Call(
        "update",
        "PUT /sks-cluster/c-1/nodepool/np-1",
        body: #"{"cpu-manager-config":{"cpu-manager-policy":"static","kube-reserved":{"cpu":"200m"}}}"#
    ) {
        _ = try await $0.sksClusters.nodepools(in: "c-1").update(
            id: "np-1",
            cpuManagerConfig: .init(policy: .static, kubeReserved: .init(cpu: "200m"))
        )
    },
    Call("scale", "PUT /sks-cluster/c-1/nodepool/np-1:scale", body: #"{"size":5}"#) {
        _ = try await $0.sksClusters.nodepools(in: "c-1").scale(id: "np-1", size: 5)
    },
    Call("evict", "PUT /sks-cluster/c-1/nodepool/np-1:evict", body: #"{"instances":["i-1"]}"#) {
        _ = try await $0.sksClusters.nodepools(in: "c-1").evict(instanceIDs: ["i-1"], from: "np-1")
    },
    Call("delete", "DELETE /sks-cluster/c-1/nodepool/np-1") {
        _ = try await $0.sksClusters.nodepools(in: "c-1").delete(id: "np-1")
    }
])
func sksNodepoolCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Kubeconfigs and certificates are decoded from base64")
func base64Responses() async throws {
    let stub = try Stub(json: kubeconfigResponse)
    #expect(try await stub.exoscale.sksClusters.kubeconfig(id: "c-1", user: "admin", groups: []) == kubeconfig)

    let invalid = try Stub(json: #"{"cacert":"not base64!"}"#)
    await #expect(throws: Exoscale.ClientError.invalidResponse) {
        try await invalid.exoscale.sksClusters.certificate(of: .kubelet, cluster: "c-1")
    }
}

@Test("SKS clusters decode with their node pools")
func decodeSKSClusters() async throws {
    let cluster = try await decode(
        #"{"id":"c-1","name":"prod","state":"running","version":"1.34.1","level":"pro","cni":"calico","#
            + #""endpoint":"https://c-1.sks-ch-gva-2.exo.io:443","auto-upgrade":true,"addons":["metrics-server"],"#
            + #""audit":{"endpoint":"https://audit.example.com","enabled":true,"initial-backoff":"10s"},"#
            + #""nodepools":[{"id":"np-1","name":"workers","state":"degraded","size":3,"#
            + #""instance-pool":{"id":"pool-1"},"#
            + #""taints":{"gpu":{"value":"true","effect":"NoExecute"}},"addons":["storage-lvm"],"#
            + #""kubelet-image-gc":{"high-threshold":85,"low-threshold":80,"min-age":"2m"},"#
            + #""nvidia-mig-profiles":{"a30.24gb":"1g.6gb"}}]}"#,
        from: "/sks-cluster/c-1"
    ) { try await $0.sksClusters.get(id: "c-1") }
    #expect(cluster == .init(
        id: "c-1",
        name: "prod",
        state: .running,
        version: "1.34.1",
        level: .pro,
        cni: .calico,
        endpoint: "https://c-1.sks-ch-gva-2.exo.io:443",
        autoUpgrade: true,
        addons: [.metricsServer],
        audit: .init(endpoint: "https://audit.example.com", initialBackoff: "10s", enabled: true),
        nodepools: [.init(
            id: "np-1",
            name: "workers",
            state: .degraded,
            size: 3,
            instancePool: .init(id: "pool-1"),
            taints: ["gpu": .init(value: "true", effect: .noExecute)],
            addons: [.storageLVM],
            kubeletImageGC: .init(highThreshold: 85, lowThreshold: 80, minAge: "2m"),
            nvidiaMIGProfiles: ["a30.24gb": "1g.6gb"]
        )]
    ))
}
