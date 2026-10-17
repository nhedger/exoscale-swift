import Foundation

public extension Exoscale {
    /// Managed Kubernetes clusters (SKS).
    struct SKSClusters: Sendable {
        let client: HTTPClient

        /// Lists the clusters.
        public func list() async throws -> [SKSCluster] {
            try await client.send(.get, "/sks-cluster", unwrapping: "sks-clusters")
        }

        /// Retrieves a cluster.
        public func get(id: String) async throws -> SKSCluster {
            try await client.send(.get, "/sks-cluster/\(id)")
        }

        /// Lists the Kubernetes versions clusters can be created with.
        ///
        /// - Parameter includeDeprecated: Whether to include deprecated versions.
        public func versions(includeDeprecated: Bool = false) async throws -> [String] {
            try await client.send(
                .get,
                "/sks-cluster-version",
                query: ["include-deprecated": includeDeprecated ? "true" : nil],
                unwrapping: "sks-cluster-versions"
            )
        }

        /// Creates a cluster.
        ///
        /// - Parameters:
        ///   - name: The cluster's name.
        ///   - version: The Kubernetes version, from ``versions(includeDeprecated:)``.
        ///   - level: The service level.
        ///   - description: The cluster's description.
        ///   - cni: The container network plugin.
        ///   - addons: The add-ons to deploy.
        ///   - autoUpgrade: Whether to upgrade the control plane to new patch versions automatically.
        ///   - createDefaultSecurityGroup: Whether to create a security group for the nodes.
        ///   - enableKubeProxy: Whether to deploy the Kubernetes network proxy.
        ///   - networking: The pod and service networks.
        ///   - oidc: The OpenID Connect provider users authenticate with.
        ///   - audit: Where to send the API server's audit log.
        ///   - featureGates: Kubernetes alpha features to enable on the API server.
        ///   - karpenterFeatureGates: Karpenter controller feature gates to enable.
        ///   - allowedNetworks: The networks allowed to reach the API server, as CIDRs (experimental).
        ///   - labels: Labels to attach.
        public func create(
            name: String,
            version: String,
            level: SKSCluster.Level,
            description: String? = nil,
            cni: SKSCluster.CNI? = nil,
            addons: [SKSCluster.Addon]? = nil,
            autoUpgrade: Bool? = nil,
            createDefaultSecurityGroup: Bool? = nil,
            enableKubeProxy: Bool? = nil,
            networking: SKSCluster.Networking? = nil,
            oidc: SKSCluster.OIDC? = nil,
            audit: SKSCluster.Audit? = nil,
            featureGates: [String]? = nil,
            karpenterFeatureGates: [String]? = nil,
            allowedNetworks: [String]? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/sks-cluster", body: [
                "name": name,
                "version": version,
                "level": level,
                "description": description,
                "cni": cni,
                "addons": addons,
                "auto-upgrade": autoUpgrade,
                "create-default-security-group": createDefaultSecurityGroup,
                "enable-kube-proxy": enableKubeProxy,
                "networking": networking,
                "oidc": oidc,
                "audit": audit,
                "feature-gates": featureGates,
                "karpenter-feature-gates": karpenterFeatureGates,
                "allowed-networks": allowedNetworks,
                "labels": labels
            ] as JSONBody)
        }

        /// Updates a cluster. Only the values passed are changed.
        public func update(
            id: String,
            name: String? = nil,
            description: String? = nil,
            addons: [SKSCluster.Addon]? = nil,
            autoUpgrade: Bool? = nil,
            enableOperatorsCA: Bool? = nil,
            oidc: SKSCluster.OIDC? = nil,
            audit: SKSCluster.Audit? = nil,
            featureGates: [String]? = nil,
            karpenterFeatureGates: [String]? = nil,
            allowedNetworks: [String]? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/sks-cluster/\(id)", body: [
                "name": name,
                "description": description,
                "addons": addons,
                "auto-upgrade": autoUpgrade,
                "enable-operators-ca": enableOperatorsCA,
                "oidc": oidc,
                "audit": audit,
                "feature-gates": featureGates,
                "karpenter-feature-gates": karpenterFeatureGates,
                "allowed-networks": allowedNetworks,
                "labels": labels
            ] as JSONBody)
        }

        /// Upgrades a cluster's control plane to a new Kubernetes version.
        public func upgrade(id: String, toVersion version: String) async throws -> Operation {
            try await client.send(.put, "/sks-cluster/\(id)/upgrade", body: ["version": version] as JSONBody)
        }

        /// Upgrades a cluster from the starter to the pro service level.
        public func upgradeToPro(id: String) async throws -> Operation {
            try await client.send(.put, "/sks-cluster/\(id)/upgrade-service-level")
        }

        /// Deletes a cluster.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/sks-cluster/\(id)")
        }

        // MARK: Access

        /// Generates a kubeconfig file for a cluster.
        ///
        /// - Parameters:
        ///   - id: The cluster's identifier.
        ///   - user: The user name, also the client certificate's common name.
        ///   - groups: The groups, also the client certificate's organizations, such as `system:masters`.
        ///   - ttl: How long the client certificate stays valid, in seconds. The API defaults to 30 days.
        /// - Returns: The kubeconfig file's contents.
        public func kubeconfig(id: String, user: String, groups: [String], ttl: Int? = nil) async throws -> String {
            let response = try await client.send(
                .post,
                "/sks-cluster-kubeconfig/\(id)",
                body: ["user": user, "groups": groups, "ttl": ttl] as JSONBody,
                as: Kubeconfig.self
            )
            return try decodeBase64(response.kubeconfig)
        }

        /// Retrieves the certificate of one of a cluster's certificate authorities.
        ///
        /// - Returns: The certificate, in PEM format.
        public func certificate(of authority: SKSCluster.Authority, cluster id: String) async throws -> String {
            let response = try await client.send(
                .get,
                "/sks-cluster/\(id)/authority/\(authority)/cert",
                as: Certificate.self
            )
            return try decodeBase64(response.cacert)
        }

        // MARK: Maintenance

        /// Lists the Kubernetes APIs a cluster uses that future versions remove.
        public func deprecatedResources(id: String) async throws -> [SKSCluster.DeprecatedResource] {
            try await client.send(.get, "/sks-cluster-deprecated-resources/\(id)")
        }

        /// Retrieves the result of the latest automatic inspection of a cluster.
        public func inspection(id: String) async throws -> [String: JSONValue] {
            try await client.send(.get, "/sks-cluster/\(id)/inspection")
        }

        /// Rotates the credentials of the Exoscale cloud controller manager.
        public func rotateCCMCredentials(id: String) async throws -> Operation {
            try await client.send(.put, "/sks-cluster/\(id)/rotate-ccm-credentials")
        }

        /// Rotates the credentials of the Exoscale storage driver.
        public func rotateCSICredentials(id: String) async throws -> Operation {
            try await client.send(.put, "/sks-cluster/\(id)/rotate-csi-credentials")
        }

        /// Rotates the credentials of Karpenter.
        public func rotateKarpenterCredentials(id: String) async throws -> Operation {
            try await client.send(.put, "/sks-cluster/\(id)/rotate-karpenter-credentials")
        }

        /// Rotates the operators' certificate authority.
        public func rotateOperatorsCA(id: String) async throws -> Operation {
            try await client.send(.put, "/sks-cluster/\(id)/rotate-operators-ca")
        }

        // MARK: Karpenter

        /// Generates a minimal Karpenter `NodePool` manifest for a cluster.
        public func karpenterNodepoolManifest(id: String) async throws -> String {
            let response = try await client.send(
                .put,
                "/sks-cluster/\(id)/generate-karpenter-nodepool",
                as: KarpenterNodepool.self
            )
            guard let manifest = response.nodepool else {
                throw ClientError.invalidResponse
            }
            return manifest
        }

        /// Generates a Karpenter `ExoscaleNodeClass` manifest for a cluster, including its default
        /// security group.
        public func karpenterNodeClassManifest(id: String) async throws -> String {
            let response = try await client.send(
                .put,
                "/sks-cluster/\(id)/generate-karpenter-exoscale-nodeclass",
                as: KarpenterNodeClass.self
            )
            guard let manifest = response.exoscaleNodeclass else {
                throw ClientError.invalidResponse
            }
            return manifest
        }

        /// Retrieves the template node pools of a Kubernetes version are created from.
        ///
        /// - Parameters:
        ///   - kubernetesVersion: The Kubernetes version.
        ///   - variant: Standard nodes or NVIDIA GPU nodes.
        /// - Returns: The template's identifier.
        public func activeTemplate(
            kubernetesVersion: String,
            variant: SKSNodepool.TemplateVariant = .standard
        ) async throws -> String {
            let response = try await client.send(
                .get,
                "/sks-template/\(kubernetesVersion)/\(variant)",
                as: ActiveTemplate.self
            )
            guard let template = response.activeTemplate else {
                throw ClientError.invalidResponse
            }
            return template
        }

        // MARK: Node pools

        /// The node pools of a cluster.
        public func nodepools(in clusterID: String) -> SKSNodepools {
            SKSNodepools(client: client, clusterID: clusterID)
        }
    }
}

private func decodeBase64(_ value: String?) throws -> String {
    guard let value, let data = Data(base64Encoded: value), let text = String(data: data, encoding: .utf8) else {
        throw Exoscale.ClientError.invalidResponse
    }
    return text
}

private struct Kubeconfig: Decodable {
    let kubeconfig: String?
}

private struct Certificate: Decodable {
    let cacert: String?
}

private struct KarpenterNodepool: Decodable {
    let nodepool: String?
}

private struct KarpenterNodeClass: Decodable {
    let exoscaleNodeclass: String?

    enum CodingKeys: String, CodingKey {
        case exoscaleNodeclass = "exoscale-nodeclass"
    }
}

private struct ActiveTemplate: Decodable {
    let activeTemplate: String?

    enum CodingKeys: String, CodingKey {
        case activeTemplate = "active-template"
    }
}
