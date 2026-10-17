public extension Exoscale {
    /// Instance pools: groups of identical instances kept at a given size.
    struct InstancePools: Sendable {
        let client: HTTPClient

        /// Lists the instance pools.
        public func list() async throws -> [InstancePool] {
            try await client.send(.get, "/instance-pool", unwrapping: "instance-pools")
        }

        /// Retrieves an instance pool.
        public func get(id: String) async throws -> InstancePool {
            try await client.send(.get, "/instance-pool/\(id)")
        }

        /// Creates an instance pool.
        ///
        /// - Parameters:
        ///   - name: The pool's name.
        ///   - size: The number of instances to keep.
        ///   - instanceTypeID: The instance type of the pool's instances.
        ///   - templateID: The template to create the instances from.
        ///   - diskSize: The size of the instances' root disks, in GiB, from 10 to 51,200.
        ///   - description: The pool's description.
        ///   - instancePrefix: The prefix of the instances' names.
        ///   - minAvailable: The minimum number of instances kept running during updates.
        ///   - sshKeys: The names of the SSH keys to install.
        ///   - securityGroupIDs: The security groups to put the instances in.
        ///   - antiAffinityGroupIDs: The anti-affinity groups to put the instances in.
        ///   - elasticIPIDs: The Elastic IPs to attach to the instances.
        ///   - privateNetworkIDs: The private networks to attach the instances to.
        ///   - deployTargetID: The dedicated hypervisor to run the instances on.
        ///   - publicIPAssignment: Which public addresses the instances get.
        ///   - ipv6Enabled: Whether the instances get a public IPv6 address.
        ///   - labels: Labels to attach to the pool.
        ///   - userData: Base64-encoded cloud-init user data.
        ///   - applicationConsistentSnapshotEnabled: Whether snapshots ask the guest to flush its
        ///     file systems first.
        public func create(
            name: String,
            size: Int,
            instanceTypeID: String,
            templateID: String,
            diskSize: Int,
            description: String? = nil,
            instancePrefix: String? = nil,
            minAvailable: Int? = nil,
            sshKeys: [String]? = nil,
            securityGroupIDs: [String]? = nil,
            antiAffinityGroupIDs: [String]? = nil,
            elasticIPIDs: [String]? = nil,
            privateNetworkIDs: [String]? = nil,
            deployTargetID: String? = nil,
            publicIPAssignment: Instance.PublicIPAssignment? = nil,
            ipv6Enabled: Bool? = nil,
            labels: [String: String]? = nil,
            userData: String? = nil,
            applicationConsistentSnapshotEnabled: Bool? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/instance-pool", body: [
                "name": name,
                "size": size,
                "instance-type": ["id": instanceTypeID],
                "template": ["id": templateID],
                "disk-size": diskSize,
                "description": description,
                "instance-prefix": instancePrefix,
                "min-available": minAvailable,
                "ssh-keys": sshKeys?.map { ["name": $0] },
                "security-groups": securityGroupIDs?.map { ["id": $0] },
                "anti-affinity-groups": antiAffinityGroupIDs?.map { ["id": $0] },
                "elastic-ips": elasticIPIDs?.map { ["id": $0] },
                "private-networks": privateNetworkIDs?.map { ["id": $0] },
                "deploy-target": deployTargetID.map { ["id": $0] },
                "public-ip-assignment": publicIPAssignment,
                "ipv6-enabled": ipv6Enabled,
                "labels": labels,
                "user-data": userData,
                "application-consistent-snapshot-enabled": applicationConsistentSnapshotEnabled
            ] as JSONBody)
        }

        /// Updates an instance pool. Only the values passed are changed; existing instances keep
        /// their settings until they are replaced. Use ``reset(_:id:)`` to clear a setting.
        public func update(
            id: String,
            name: String? = nil,
            description: String? = nil,
            instanceTypeID: String? = nil,
            templateID: String? = nil,
            diskSize: Int? = nil,
            instancePrefix: String? = nil,
            minAvailable: Int? = nil,
            sshKeys: [String]? = nil,
            securityGroupIDs: [String]? = nil,
            antiAffinityGroupIDs: [String]? = nil,
            elasticIPIDs: [String]? = nil,
            privateNetworkIDs: [String]? = nil,
            deployTargetID: String? = nil,
            publicIPAssignment: Instance.PublicIPAssignment? = nil,
            ipv6Enabled: Bool? = nil,
            labels: [String: String]? = nil,
            userData: String? = nil,
            applicationConsistentSnapshotEnabled: Bool? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/instance-pool/\(id)", body: [
                "name": name,
                "description": description,
                "instance-type": instanceTypeID.map { ["id": $0] },
                "template": templateID.map { ["id": $0] },
                "disk-size": diskSize,
                "instance-prefix": instancePrefix,
                "min-available": minAvailable,
                "ssh-keys": sshKeys?.map { ["name": $0] },
                "security-groups": securityGroupIDs?.map { ["id": $0] },
                "anti-affinity-groups": antiAffinityGroupIDs?.map { ["id": $0] },
                "elastic-ips": elasticIPIDs?.map { ["id": $0] },
                "private-networks": privateNetworkIDs?.map { ["id": $0] },
                "deploy-target": deployTargetID.map { ["id": $0] },
                "public-ip-assignment": publicIPAssignment,
                "ipv6-enabled": ipv6Enabled,
                "labels": labels,
                "user-data": userData,
                "application-consistent-snapshot-enabled": applicationConsistentSnapshotEnabled
            ] as JSONBody)
        }

        /// Resets a setting of an instance pool to its default, such as removing all its labels.
        public func reset(_ field: InstancePool.Field, id: String) async throws -> Operation {
            try await client.send(.delete, "/instance-pool/\(id)/\(field)")
        }

        /// Changes the number of instances in a pool.
        public func scale(id: String, size: Int) async throws -> Operation {
            try await client.send(.put, "/instance-pool/\(id):scale", body: ["size": size] as JSONBody)
        }

        /// Removes specific instances from a pool, deleting them and shrinking the pool.
        public func evict(instanceIDs: [String], from id: String) async throws -> Operation {
            try await client.send(.put, "/instance-pool/\(id):evict", body: ["instances": instanceIDs] as JSONBody)
        }

        /// Deletes an instance pool and its instances.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/instance-pool/\(id)")
        }
    }
}
