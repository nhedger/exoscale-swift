import Foundation

/// Access to Instance Pool API operations.
public struct InstancePoolsResource {
    public enum Field: String, Sendable {
        case antiAffinityGroups = "anti-affinity-groups"
        case description
        case labels
        case securityGroups = "security-groups"
        case elasticIPs = "elastic-ips"
        case privateNetworks = "private-networks"
        case sshKey = "ssh-key"
        case userData = "user-data"
        case deployTarget = "deploy-target"
        case ipv6Enabled = "ipv6-enabled"
    }

    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists Instance Pools.
    ///
    /// - Returns: The Instance Pools returned by the API.
    public func list() async throws -> [Exoscale.InstancePool] {
        let response = try await http.get(path: "/instance-pool", as: ListInstancePoolsResponse.self)
        return response.instancePools
    }

    /// Creates an Instance Pool.
    ///
    /// - Parameters:
    ///   - name: The Instance Pool name.
    ///   - size: The number of instances.
    ///   - instanceTypeID: The instance type identifier.
    ///   - templateID: The template identifier.
    ///   - diskSize: The instance disk size in GiB.
    ///   - applicationConsistentSnapshotEnabled: Optional application-consistent snapshot flag.
    ///   - antiAffinityGroupIDs: Optional anti-affinity group identifiers.
    ///   - description: Optional Instance Pool description.
    ///   - publicIPAssignment: Optional public IP assignment mode.
    ///   - labels: Optional Instance Pool labels.
    ///   - securityGroupIDs: Optional security group identifiers.
    ///   - elasticIPIDs: Optional Elastic IP identifiers.
    ///   - minAvailable: Optional minimum number of running instances.
    ///   - privateNetworkIDs: Optional private network identifiers.
    ///   - sshKeyName: Optional legacy SSH key name.
    ///   - instancePrefix: Optional managed instance name prefix.
    ///   - userData: Optional base64-encoded cloud-init user data.
    ///   - deployTargetID: Optional deploy target identifier.
    ///   - ipv6Enabled: Optional deprecated IPv6 flag.
    ///   - sshKeyNames: Optional SSH key names.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        name: String,
        size: Int,
        instanceTypeID: String,
        templateID: String,
        diskSize: Int,
        applicationConsistentSnapshotEnabled: Bool? = nil,
        antiAffinityGroupIDs: [String]? = nil,
        description: String? = nil,
        publicIPAssignment: Exoscale.InstancePool.PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        securityGroupIDs: [String]? = nil,
        elasticIPIDs: [String]? = nil,
        minAvailable: Int? = nil,
        privateNetworkIDs: [String]? = nil,
        sshKeyName: String? = nil,
        instancePrefix: String? = nil,
        userData: String? = nil,
        deployTargetID: String? = nil,
        ipv6Enabled: Bool? = nil,
        sshKeyNames: [String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateInstancePoolRequest(
                applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                antiAffinityGroups: antiAffinityGroupIDs?.map(InstanceIDReference.init(id:)),
                description: description,
                publicIPAssignment: publicIPAssignment,
                labels: labels,
                securityGroups: securityGroupIDs?.map(InstanceIDReference.init(id:)),
                elasticIPs: elasticIPIDs?.map(InstanceIDReference.init(id:)),
                name: name,
                instanceType: InstanceIDReference(id: instanceTypeID),
                minAvailable: minAvailable,
                privateNetworks: privateNetworkIDs?.map(InstanceIDReference.init(id:)),
                template: InstanceIDReference(id: templateID),
                size: size,
                sshKey: sshKeyName.map(InstanceSSHKeyReference.init(name:)),
                instancePrefix: instancePrefix,
                userData: userData,
                deployTarget: deployTargetID.map(InstanceIDReference.init(id:)),
                ipv6Enabled: ipv6Enabled,
                diskSize: diskSize,
                sshKeys: sshKeyNames?.map(InstanceSSHKeyReference.init(name:))
            )
        )

        return try await http.post(path: "/instance-pool", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves an Instance Pool by identifier.
    ///
    /// - Parameter id: The Instance Pool identifier.
    /// - Returns: The Instance Pool returned by the API.
    public func get(id: String) async throws -> Exoscale.InstancePool {
        try await http.get(path: "/instance-pool/\(id)", as: Exoscale.InstancePool.self)
    }

    /// Updates an Instance Pool.
    ///
    /// - Parameters:
    ///   - id: The Instance Pool identifier.
    ///   - applicationConsistentSnapshotEnabled: Optional application-consistent snapshot flag.
    ///   - antiAffinityGroupIDs: Optional anti-affinity group identifiers.
    ///   - description: Optional Instance Pool description.
    ///   - publicIPAssignment: Optional public IP assignment mode.
    ///   - labels: Optional Instance Pool labels.
    ///   - securityGroupIDs: Optional security group identifiers.
    ///   - elasticIPIDs: Optional Elastic IP identifiers.
    ///   - name: Optional Instance Pool name.
    ///   - instanceTypeID: Optional instance type identifier.
    ///   - minAvailable: Optional minimum number of running instances.
    ///   - privateNetworkIDs: Optional private network identifiers.
    ///   - templateID: Optional template identifier.
    ///   - sshKeyName: Optional legacy SSH key name.
    ///   - instancePrefix: Optional managed instance name prefix.
    ///   - userData: Optional base64-encoded cloud-init user data.
    ///   - deployTargetID: Optional deploy target identifier.
    ///   - ipv6Enabled: Optional deprecated IPv6 flag.
    ///   - diskSize: Optional instance disk size in GiB.
    ///   - sshKeyNames: Optional SSH key names.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        applicationConsistentSnapshotEnabled: Bool? = nil,
        antiAffinityGroupIDs: [String]? = nil,
        description: String? = nil,
        publicIPAssignment: Exoscale.InstancePool.PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        securityGroupIDs: [String]? = nil,
        elasticIPIDs: [String]? = nil,
        name: String? = nil,
        instanceTypeID: String? = nil,
        minAvailable: Int? = nil,
        privateNetworkIDs: [String]? = nil,
        templateID: String? = nil,
        sshKeyName: String? = nil,
        instancePrefix: String? = nil,
        userData: String? = nil,
        deployTargetID: String? = nil,
        ipv6Enabled: Bool? = nil,
        diskSize: Int? = nil,
        sshKeyNames: [String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateInstancePoolRequest(
                applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                antiAffinityGroups: antiAffinityGroupIDs?.map(InstanceIDReference.init(id:)),
                description: description,
                publicIPAssignment: publicIPAssignment,
                labels: labels,
                securityGroups: securityGroupIDs?.map(InstanceIDReference.init(id:)),
                elasticIPs: elasticIPIDs?.map(InstanceIDReference.init(id:)),
                name: name,
                instanceType: instanceTypeID.map(InstanceIDReference.init(id:)),
                minAvailable: minAvailable,
                privateNetworks: privateNetworkIDs?.map(InstanceIDReference.init(id:)),
                template: templateID.map(InstanceIDReference.init(id:)),
                sshKey: sshKeyName.map(InstanceSSHKeyReference.init(name:)),
                instancePrefix: instancePrefix,
                userData: userData,
                deployTarget: deployTargetID.map(InstanceIDReference.init(id:)),
                ipv6Enabled: ipv6Enabled,
                diskSize: diskSize,
                sshKeys: sshKeyNames?.map(InstanceSSHKeyReference.init(name:))
            )
        )

        return try await http.put(path: "/instance-pool/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes an Instance Pool.
    ///
    /// - Parameter id: The Instance Pool identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/instance-pool/\(id)", as: Exoscale.Operation.self)
    }

    /// Resets an Instance Pool field to its default value.
    ///
    /// - Parameters:
    ///   - id: The Instance Pool identifier.
    ///   - field: The Instance Pool field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetField(id: String, field: Field) async throws -> Exoscale.Operation {
        try await http.delete(path: "/instance-pool/\(id)/\(field.rawValue)", as: Exoscale.Operation.self)
    }

    /// Evicts compute instances from an Instance Pool.
    ///
    /// - Parameters:
    ///   - id: The Instance Pool identifier.
    ///   - instanceIDs: The compute instance identifiers to evict.
    /// - Returns: The asynchronous operation returned by the API.
    public func evictMembers(id: String, instanceIDs: [String]) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(EvictInstancePoolMembersRequest(instances: instanceIDs))
        return try await http.put(path: "/instance-pool/\(id):evict", body: body, as: Exoscale.Operation.self)
    }

    /// Scales an Instance Pool.
    ///
    /// - Parameters:
    ///   - id: The Instance Pool identifier.
    ///   - size: The target number of instances.
    /// - Returns: The asynchronous operation returned by the API.
    public func scale(id: String, size: Int) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ScaleInstancePoolRequest(size: size))
        return try await http.put(path: "/instance-pool/\(id):scale", body: body, as: Exoscale.Operation.self)
    }
}
