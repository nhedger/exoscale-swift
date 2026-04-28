import Foundation
import Testing

@testable import Exoscale

@Test("CreateSKSClusterRequest encodes request body")
func createSKSClusterRequestEncodesRequestBody() throws {
    let request = CreateSKSClusterRequest(
        description: "production cluster",
        labels: ["env": "prod"],
        cni: .cilium,
        autoUpgrade: true,
        networking: .init(
            clusterCIDR: "192.168.0.0/16",
            serviceClusterIPRange: "10.96.0.0/12",
            nodeCIDRMaskSizeIPv4: 24,
            nodeCIDRMaskSizeIPv6: 64
        ),
        oidc: .init(
            clientID: "kubernetes",
            issuerURL: "https://issuer.example.com",
            usernameClaim: "email",
            usernamePrefix: "oidc:",
            groupsClaim: "groups",
            groupsPrefix: "oidc:",
            requiredClaim: ["aud": "kubernetes"]
        ),
        name: "prod-sks",
        createDefaultSecurityGroup: true,
        enableKubeProxy: false,
        level: .pro,
        featureGates: ["ExampleFeature"],
        addons: [.metricsServer, .karpenter],
        audit: .init(
            endpoint: "https://audit.example.com",
            bearerToken: "token",
            initialBackoff: "10s"
        ),
        version: "1.31.1"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["description"] as? String == "production cluster")
    #expect((object["labels"] as? [String: String])?["env"] == "prod")
    #expect(object["cni"] as? String == "cilium")
    #expect(object["auto-upgrade"] as? Bool == true)
    #expect(object["name"] as? String == "prod-sks")
    #expect(object["create-default-security-group"] as? Bool == true)
    #expect(object["enable-kube-proxy"] as? Bool == false)
    #expect(object["level"] as? String == "pro")
    #expect(object["feature-gates"] as? [String] == ["ExampleFeature"])
    #expect(object["addons"] as? [String] == ["metrics-server", "karpenter"])
    #expect(object["version"] as? String == "1.31.1")

    let networking = try #require(object["networking"] as? [String: Any])
    #expect(networking["cluster-cidr"] as? String == "192.168.0.0/16")
    #expect(networking["service-cluster-ip-range"] as? String == "10.96.0.0/12")
    #expect(networking["node-cidr-mask-size-ipv4"] as? Int == 24)
    #expect(networking["node-cidr-mask-size-ipv6"] as? Int == 64)

    let oidc = try #require(object["oidc"] as? [String: Any])
    #expect(oidc["client-id"] as? String == "kubernetes")
    #expect(oidc["issuer-url"] as? String == "https://issuer.example.com")
    #expect((oidc["required-claim"] as? [String: String])?["aud"] == "kubernetes")

    let audit = try #require(object["audit"] as? [String: String])
    #expect(audit["endpoint"] == "https://audit.example.com")
    #expect(audit["bearer-token"] == "token")
    #expect(audit["initial-backoff"] == "10s")
}

@Test("UpdateSKSClusterRequest encodes request body")
func updateSKSClusterRequestEncodesRequestBody() throws {
    let request = UpdateSKSClusterRequest(
        description: "updated cluster",
        labels: ["env": "staging"],
        autoUpgrade: false,
        oidc: .init(clientID: "kubernetes", issuerURL: "https://issuer.example.com"),
        name: "staging-sks",
        enableOperatorsCA: true,
        featureGates: ["AnotherFeature"],
        addons: [.exoscaleCloudController, .exoscaleContainerStorageInterface],
        audit: .init(
            endpoint: "https://audit.example.com",
            bearerToken: "token",
            initialBackoff: "20s",
            enabled: true
        )
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["description"] as? String == "updated cluster")
    #expect((object["labels"] as? [String: String])?["env"] == "staging")
    #expect(object["auto-upgrade"] as? Bool == false)
    #expect(object["name"] as? String == "staging-sks")
    #expect(object["enable-operators-ca"] as? Bool == true)
    #expect(object["feature-gates"] as? [String] == ["AnotherFeature"])
    #expect(object["addons"] as? [String] == ["exoscale-cloud-controller", "exoscale-container-storage-interface"])

    let audit = try #require(object["audit"] as? [String: Any])
    #expect(audit["endpoint"] as? String == "https://audit.example.com")
    #expect(audit["bearer-token"] as? String == "token")
    #expect(audit["initial-backoff"] as? String == "20s")
    #expect(audit["enabled"] as? Bool == true)
}

@Test("SKS cluster action requests encode request bodies")
func sksClusterActionRequestsEncodeRequestBodies() throws {
    let kubeconfigRequest = GenerateSKSClusterKubeconfigRequest(
        ttl: 3600,
        user: "admin",
        groups: ["system:masters"]
    )
    let kubeconfigData = try JSONEncoder().encode(kubeconfigRequest)
    let kubeconfigObject = try #require(JSONSerialization.jsonObject(with: kubeconfigData) as? [String: Any])

    #expect(kubeconfigObject["ttl"] as? Int == 3600)
    #expect(kubeconfigObject["user"] as? String == "admin")
    #expect(kubeconfigObject["groups"] as? [String] == ["system:masters"])

    let upgradeData = try JSONEncoder().encode(UpgradeSKSClusterRequest(version: "1.32.0"))
    let upgradeObject = try #require(JSONSerialization.jsonObject(with: upgradeData) as? [String: String])

    #expect(upgradeObject["version"] == "1.32.0")
}

@Test("ListSKSClustersResponse decodes clusters")
func listSKSClustersResponseDecodesClusters() throws {
    let data = Data(
        """
        {
          "sks-clusters": [
            {
              "description": "production cluster",
              "labels": { "env": "prod" },
              "cni": "cilium",
              "auto-upgrade": true,
              "name": "prod-sks",
              "enable-operators-ca": true,
              "default-security-group-id": "11111111-1111-1111-1111-111111111111",
              "state": "running",
              "enable-kube-proxy": false,
              "nodepools": [
                {
                  "anti-affinity-groups": [
                    { "id": "22222222-2222-2222-2222-222222222222" }
                  ],
                  "description": "workers",
                  "public-ip-assignment": "dual",
                  "labels": { "pool": "workers" },
                  "taints": {
                    "dedicated": {
                      "value": "gpu",
                      "effect": "NoSchedule"
                    }
                  },
                  "security-groups": [
                    { "id": "33333333-3333-3333-3333-333333333333" }
                  ],
                  "name": "workers",
                  "instance-type": { "id": "44444444-4444-4444-4444-444444444444" },
                  "private-networks": [
                    { "id": "55555555-5555-5555-5555-555555555555" }
                  ],
                  "template": { "id": "66666666-6666-6666-6666-666666666666" },
                  "state": "running",
                  "size": 3,
                  "kubelet-image-gc": {
                    "high-threshold": 85,
                    "low-threshold": 80,
                    "min-age": "2m"
                  },
                  "instance-pool": { "id": "77777777-7777-7777-7777-777777777777" },
                  "instance-prefix": "worker",
                  "deploy-target": { "id": "88888888-8888-8888-8888-888888888888" },
                  "addons": ["storage-lvm"],
                  "id": "99999999-9999-9999-9999-999999999999",
                  "disk-size": 50,
                  "version": "1.31.1",
                  "created-at": "2026-04-27T10:00:00Z"
                }
              ],
              "level": "pro",
              "feature-gates": ["ExampleFeature"],
              "addons": ["metrics-server", "karpenter"],
              "id": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
              "audit": {
                "endpoint": "https://audit.example.com",
                "enabled": true,
                "initial-backoff": "10s"
              },
              "version": "1.31.1",
              "created-at": "2026-04-27T10:00:00Z",
              "endpoint": "https://api.prod-sks.example.com"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListSKSClustersResponse.self, from: data)
    let cluster = try #require(response.clusters.first)
    let nodepool = try #require(cluster.nodepools?.first)

    #expect(cluster.id == "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")
    #expect(cluster.name == "prod-sks")
    #expect(cluster.description == "production cluster")
    #expect(cluster.labels == ["env": "prod"])
    #expect(cluster.cni == .cilium)
    #expect(cluster.autoUpgrade == true)
    #expect(cluster.enableOperatorsCA == true)
    #expect(cluster.defaultSecurityGroupID == "11111111-1111-1111-1111-111111111111")
    #expect(cluster.state == .running)
    #expect(cluster.enableKubeProxy == false)
    #expect(cluster.level == .pro)
    #expect(cluster.featureGates == ["ExampleFeature"])
    #expect(cluster.addons == [.metricsServer, .karpenter])
    #expect(cluster.audit?.enabled == true)
    #expect(cluster.version == "1.31.1")
    #expect(cluster.endpoint == "https://api.prod-sks.example.com")

    #expect(nodepool.id == "99999999-9999-9999-9999-999999999999")
    #expect(nodepool.antiAffinityGroups?.first?.id == "22222222-2222-2222-2222-222222222222")
    #expect(nodepool.publicIPAssignment == .dual)
    #expect(nodepool.taints?["dedicated"]?.effect == .noSchedule)
    #expect(nodepool.instanceType?.id == "44444444-4444-4444-4444-444444444444")
    #expect(nodepool.privateNetworks?.first?.id == "55555555-5555-5555-5555-555555555555")
    #expect(nodepool.template?.id == "66666666-6666-6666-6666-666666666666")
    #expect(nodepool.kubeletImageGC?.highThreshold == 85)
    #expect(nodepool.instancePool?.id == "77777777-7777-7777-7777-777777777777")
    #expect(nodepool.deployTarget?.id == "88888888-8888-8888-8888-888888888888")
    #expect(nodepool.addons == [.storageLVM])
    #expect(nodepool.diskSize == 50)
}

@Test("SKS cluster responses decode values")
func sksClusterResponsesDecodeValues() throws {
    let kubeconfigResponse = try JSONDecoder().decode(
        GenerateSKSClusterKubeconfigResponse.self,
        from: Data(#"{"kubeconfig":"base64-kubeconfig"}"#.utf8)
    )
    let certificateResponse = try JSONDecoder().decode(
        GetSKSClusterAuthorityCertificateResponse.self,
        from: Data(#"{"cacert":"base64-cert"}"#.utf8)
    )
    let versionsResponse = try JSONDecoder().decode(
        ListSKSClusterVersionsResponse.self,
        from: Data(#"{"sks-cluster-versions":["1.31.1","1.32.0"]}"#.utf8)
    )
    let deprecatedResources = try JSONDecoder().decode(
        [Exoscale.SKSClusterDeprecatedResource].self,
        from: Data(
            #"[{"group":"apps","version":"v1beta1","resource":"deployments","subresource":"scale","removed-release":"1.16"}]"#.utf8
        )
    )

    #expect(kubeconfigResponse.kubeconfig == "base64-kubeconfig")
    #expect(certificateResponse.caCert == "base64-cert")
    #expect(versionsResponse.versions == ["1.31.1", "1.32.0"])
    #expect(deprecatedResources.first?.removedRelease == "1.16")
}

@Test("JSONValue decodes SKS cluster inspection payloads")
func jsonValueDecodesSKSClusterInspectionPayloads() throws {
    let data = Data(
        """
        {
          "checks": {
            "dns": {
              "ok": true,
              "retries": 2
            }
          },
          "messages": ["ok"],
          "score": 0.5,
          "empty": null
        }
        """.utf8
    )

    let inspection = try JSONDecoder().decode([String: Exoscale.JSONValue].self, from: data)

    #expect(inspection["checks"] == .object([
        "dns": .object([
            "ok": .bool(true),
            "retries": .integer(2),
        ]),
    ]))
    #expect(inspection["messages"] == .array([.string("ok")]))
    #expect(inspection["score"] == .double(0.5))
    #expect(inspection["empty"] == .null)
}

@Test("Client encodes SKS cluster versions query")
func clientEncodesSKSClusterVersionsQuery() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let request = try client.http.makeRequest(
        "GET",
        path: "/sks-cluster-version",
        query: ["include-deprecated": "true"]
    )

    let url = try #require(request.url)
    let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    let queryItems = Dictionary(uniqueKeysWithValues: try #require(components.queryItems).map { ($0.name, $0.value) })

    #expect(queryItems["include-deprecated"] == "true")
}
