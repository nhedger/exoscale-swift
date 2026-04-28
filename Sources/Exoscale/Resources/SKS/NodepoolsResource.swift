import Foundation

/// Access to SKS nodepool API operations.
public struct NodepoolsResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Creates an SKS nodepool in a cluster.
    ///
    /// - Parameters:
    ///   - clusterID: The SKS cluster identifier.
    ///   - name: The nodepool name.
    ///   - size: The number of instances.
    ///   - diskSize: The instance disk size in GiB.
    ///   - instanceTypeID: The instance type identifier.
    ///   - antiAffinityGroupIDs: Optional anti-affinity group identifiers.
    ///   - description: Optional nodepool description.
    ///   - publicIPAssignment: Optional public IP assignment mode.
    ///   - labels: Optional nodepool labels.
    ///   - taints: Optional nodepool taints.
    ///   - securityGroupIDs: Optional security group identifiers.
    ///   - privateNetworkIDs: Optional private network identifiers.
    ///   - kubeletImageGC: Optional kubelet image garbage-collection settings.
    ///   - instancePrefix: Optional managed instance name prefix.
    ///   - deployTargetID: Optional deploy target identifier.
    ///   - addons: Optional nodepool addons.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        clusterID: String,
        name: String,
        size: Int,
        diskSize: Int,
        instanceTypeID: String,
        antiAffinityGroupIDs: [String]? = nil,
        description: String? = nil,
        publicIPAssignment: Exoscale.SKSNodepool.PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        taints: [String: Exoscale.SKSNodepool.Taint]? = nil,
        securityGroupIDs: [String]? = nil,
        privateNetworkIDs: [String]? = nil,
        kubeletImageGC: Exoscale.SKSNodepool.KubeletImageGC? = nil,
        instancePrefix: String? = nil,
        deployTargetID: String? = nil,
        addons: [Exoscale.SKSNodepool.Addon]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateSKSNodepoolRequest(
                antiAffinityGroups: antiAffinityGroupIDs?.map(SKSNodepoolReference.init(id:)),
                description: description,
                publicIPAssignment: publicIPAssignment,
                labels: labels,
                taints: taints,
                securityGroups: securityGroupIDs?.map(SKSNodepoolReference.init(id:)),
                name: name,
                instanceType: SKSNodepoolReference(id: instanceTypeID),
                privateNetworks: privateNetworkIDs?.map(SKSNodepoolReference.init(id:)),
                size: size,
                kubeletImageGC: kubeletImageGC,
                instancePrefix: instancePrefix,
                deployTarget: deployTargetID.map(SKSNodepoolReference.init(id:)),
                addons: addons,
                diskSize: diskSize
            )
        )

        return try await http.post(
            path: "/sks-cluster/\(clusterID)/nodepool",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Retrieves an SKS nodepool by identifier.
    ///
    /// - Parameters:
    ///   - clusterID: The SKS cluster identifier.
    ///   - id: The nodepool identifier.
    /// - Returns: The SKS nodepool returned by the API.
    public func get(clusterID: String, id: String) async throws -> Exoscale.SKSNodepool {
        try await http.get(path: "/sks-cluster/\(clusterID)/nodepool/\(id)", as: Exoscale.SKSNodepool.self)
    }

    /// Updates an SKS nodepool.
    ///
    /// - Parameters:
    ///   - clusterID: The SKS cluster identifier.
    ///   - id: The nodepool identifier.
    ///   - antiAffinityGroupIDs: Optional anti-affinity group identifiers.
    ///   - description: Optional nodepool description.
    ///   - publicIPAssignment: Optional public IP assignment mode.
    ///   - labels: Optional nodepool labels.
    ///   - taints: Optional nodepool taints.
    ///   - securityGroupIDs: Optional security group identifiers.
    ///   - name: Optional nodepool name.
    ///   - instanceTypeID: Optional instance type identifier.
    ///   - privateNetworkIDs: Optional private network identifiers.
    ///   - kubeletImageGC: Optional kubelet image garbage-collection settings.
    ///   - instancePrefix: Optional managed instance name prefix.
    ///   - deployTargetID: Optional deploy target identifier.
    ///   - diskSize: Optional instance disk size in GiB.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        clusterID: String,
        id: String,
        antiAffinityGroupIDs: [String]? = nil,
        description: String? = nil,
        publicIPAssignment: Exoscale.SKSNodepool.PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        taints: [String: Exoscale.SKSNodepool.Taint]? = nil,
        securityGroupIDs: [String]? = nil,
        name: String? = nil,
        instanceTypeID: String? = nil,
        privateNetworkIDs: [String]? = nil,
        kubeletImageGC: Exoscale.SKSNodepool.KubeletImageGC? = nil,
        instancePrefix: String? = nil,
        deployTargetID: String? = nil,
        diskSize: Int? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateSKSNodepoolRequest(
                antiAffinityGroups: antiAffinityGroupIDs?.map(SKSNodepoolReference.init(id:)),
                description: description,
                publicIPAssignment: publicIPAssignment,
                labels: labels,
                taints: taints,
                securityGroups: securityGroupIDs?.map(SKSNodepoolReference.init(id:)),
                name: name,
                instanceType: instanceTypeID.map(SKSNodepoolReference.init(id:)),
                privateNetworks: privateNetworkIDs?.map(SKSNodepoolReference.init(id:)),
                kubeletImageGC: kubeletImageGC,
                instancePrefix: instancePrefix,
                deployTarget: deployTargetID.map(SKSNodepoolReference.init(id:)),
                diskSize: diskSize
            )
        )

        return try await http.put(
            path: "/sks-cluster/\(clusterID)/nodepool/\(id)",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Deletes an SKS nodepool.
    ///
    /// - Parameters:
    ///   - clusterID: The SKS cluster identifier.
    ///   - id: The nodepool identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(clusterID: String, id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/sks-cluster/\(clusterID)/nodepool/\(id)", as: Exoscale.Operation.self)
    }

    /// Evicts compute instances from an SKS nodepool.
    ///
    /// - Parameters:
    ///   - clusterID: The SKS cluster identifier.
    ///   - id: The nodepool identifier.
    ///   - instanceIDs: The compute instance identifiers to evict.
    /// - Returns: The asynchronous operation returned by the API.
    public func evictMembers(
        clusterID: String,
        id: String,
        instanceIDs: [String]
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(EvictSKSNodepoolMembersRequest(instances: instanceIDs))
        return try await http.put(
            path: "/sks-cluster/\(clusterID)/nodepool/\(id):evict",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Scales an SKS nodepool.
    ///
    /// - Parameters:
    ///   - clusterID: The SKS cluster identifier.
    ///   - id: The nodepool identifier.
    ///   - size: The target number of instances.
    /// - Returns: The asynchronous operation returned by the API.
    public func scale(clusterID: String, id: String, size: Int) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ScaleSKSNodepoolRequest(size: size))
        return try await http.put(
            path: "/sks-cluster/\(clusterID)/nodepool/\(id):scale",
            body: body,
            as: Exoscale.Operation.self
        )
    }
}
