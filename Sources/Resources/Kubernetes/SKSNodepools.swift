public extension Exoscale {
    /// The node pools of one SKS cluster. List them with ``SKSCluster/nodepools``.
    struct SKSNodepools: Sendable {
        let client: HTTPClient
        /// The cluster's identifier.
        public let clusterID: String

        /// Retrieves a node pool.
        public func get(id: String) async throws -> SKSNodepool {
            try await client.send(.get, "/sks-cluster/\(clusterID)/nodepool/\(id)")
        }

        /// Creates a node pool.
        ///
        /// - Parameters:
        ///   - name: The node pool's name.
        ///   - size: The number of nodes.
        ///   - instanceTypeID: The instance type of the nodes.
        ///   - diskSize: The size of the nodes' root disks, in GiB.
        ///   - description: The node pool's description.
        ///   - instancePrefix: The prefix of the nodes' names.
        ///   - labels: Kubernetes labels to apply to the nodes.
        ///   - taints: Kubernetes taints to apply to the nodes, keyed by taint key.
        ///   - securityGroupIDs: The security groups to put the nodes in.
        ///   - antiAffinityGroupIDs: The anti-affinity groups to put the nodes in.
        ///   - privateNetworkIDs: The private networks to attach the nodes to.
        ///   - deployTargetID: The dedicated hypervisor to run the nodes on.
        ///   - publicIPAssignment: Which public addresses the nodes get.
        ///   - addons: The node pool's add-ons.
        ///   - kubeletImageGC: When the kubelet removes unused images.
        ///   - kubeletMaxPods: The maximum number of pods per node.
        ///   - cpuManagerConfig: How the kubelet assigns CPUs to pods.
        ///   - nvidiaMIGProfiles: The NVIDIA Multi-Instance GPU profile of each GPU model.
        public func create(
            name: String,
            size: Int,
            instanceTypeID: String,
            diskSize: Int,
            description: String? = nil,
            instancePrefix: String? = nil,
            labels: [String: String]? = nil,
            taints: [String: SKSNodepool.Taint]? = nil,
            securityGroupIDs: [String]? = nil,
            antiAffinityGroupIDs: [String]? = nil,
            privateNetworkIDs: [String]? = nil,
            deployTargetID: String? = nil,
            publicIPAssignment: Instance.PublicIPAssignment? = nil,
            addons: [SKSNodepool.Addon]? = nil,
            kubeletImageGC: SKSNodepool.KubeletImageGC? = nil,
            kubeletMaxPods: Int? = nil,
            cpuManagerConfig: SKSNodepool.CPUManagerConfig? = nil,
            nvidiaMIGProfiles: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/sks-cluster/\(clusterID)/nodepool", body: [
                "name": name,
                "size": size,
                "instance-type": ["id": instanceTypeID],
                "disk-size": diskSize,
                "description": description,
                "instance-prefix": instancePrefix,
                "labels": labels,
                "taints": taints,
                "security-groups": securityGroupIDs?.map { ["id": $0] },
                "anti-affinity-groups": antiAffinityGroupIDs?.map { ["id": $0] },
                "private-networks": privateNetworkIDs?.map { ["id": $0] },
                "deploy-target": deployTargetID.map { ["id": $0] },
                "public-ip-assignment": publicIPAssignment,
                "addons": addons,
                "kubelet-image-gc": kubeletImageGC,
                "kubelet-max-pods": kubeletMaxPods,
                "cpu-manager-config": cpuManagerConfig,
                "nvidia-mig-profiles": nvidiaMIGProfiles
            ] as JSONBody)
        }

        /// Updates a node pool. Only the values passed are changed; existing nodes keep their
        /// settings until they are replaced.
        public func update(
            id: String,
            name: String? = nil,
            description: String? = nil,
            instanceTypeID: String? = nil,
            diskSize: Int? = nil,
            instancePrefix: String? = nil,
            labels: [String: String]? = nil,
            taints: [String: SKSNodepool.Taint]? = nil,
            securityGroupIDs: [String]? = nil,
            antiAffinityGroupIDs: [String]? = nil,
            privateNetworkIDs: [String]? = nil,
            deployTargetID: String? = nil,
            publicIPAssignment: Instance.PublicIPAssignment? = nil,
            kubeletImageGC: SKSNodepool.KubeletImageGC? = nil,
            kubeletMaxPods: Int? = nil,
            cpuManagerConfig: SKSNodepool.CPUManagerConfig? = nil,
            nvidiaMIGProfiles: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/sks-cluster/\(clusterID)/nodepool/\(id)", body: [
                "name": name,
                "description": description,
                "instance-type": instanceTypeID.map { ["id": $0] },
                "disk-size": diskSize,
                "instance-prefix": instancePrefix,
                "labels": labels,
                "taints": taints,
                "security-groups": securityGroupIDs?.map { ["id": $0] },
                "anti-affinity-groups": antiAffinityGroupIDs?.map { ["id": $0] },
                "private-networks": privateNetworkIDs?.map { ["id": $0] },
                "deploy-target": deployTargetID.map { ["id": $0] },
                "public-ip-assignment": publicIPAssignment,
                "kubelet-image-gc": kubeletImageGC,
                "kubelet-max-pods": kubeletMaxPods,
                "cpu-manager-config": cpuManagerConfig,
                "nvidia-mig-profiles": nvidiaMIGProfiles
            ] as JSONBody)
        }

        /// Changes the number of nodes in a node pool.
        public func scale(id: String, size: Int) async throws -> Operation {
            try await client.send(
                .put,
                "/sks-cluster/\(clusterID)/nodepool/\(id):scale",
                body: ["size": size] as JSONBody
            )
        }

        /// Removes specific nodes from a node pool, deleting them and shrinking the pool.
        public func evict(instanceIDs: [String], from id: String) async throws -> Operation {
            try await client.send(
                .put,
                "/sks-cluster/\(clusterID)/nodepool/\(id):evict",
                body: ["instances": instanceIDs] as JSONBody
            )
        }

        /// Deletes a node pool and its nodes.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/sks-cluster/\(clusterID)/nodepool/\(id)")
        }
    }
}

public extension Exoscale.SKSNodepool {
    /// The kind of nodes a template is for.
    struct TemplateVariant: RawRepresentable, Hashable, Sendable {
        /// The variant as the API names it.
        public let rawValue: String

        /// Creates a variant, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Standard nodes.
        public static let standard = TemplateVariant(rawValue: "standard")
        /// Nodes with NVIDIA GPUs.
        public static let nvidia = TemplateVariant(rawValue: "nvidia")
    }
}
