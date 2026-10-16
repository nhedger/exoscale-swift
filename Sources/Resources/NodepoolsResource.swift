import Foundation

/// Access to SKS nodepool API operations.
public struct NodepoolsResource: Sendable {
    let http: Http.Client

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
        addons: [Exoscale.SKSNodepool.Addon]? = nil,
        nvidiaMIGProfiles: Exoscale.NvidiaMIGProfiles? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            NodepoolsOperations.Create(
                request: .init(
                    clusterID: clusterID,
                    name: name,
                    size: size,
                    diskSize: diskSize,
                    instanceTypeID: instanceTypeID,
                    antiAffinityGroupIDs: antiAffinityGroupIDs,
                    description: description,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    taints: taints,
                    securityGroupIDs: securityGroupIDs,
                    privateNetworkIDs: privateNetworkIDs,
                    kubeletImageGC: kubeletImageGC,
                    instancePrefix: instancePrefix,
                    deployTargetID: deployTargetID,
                    addons: addons,
                    nvidiaMIGProfiles: nvidiaMIGProfiles
                )
            )
        )
    }

    /// Retrieves an SKS nodepool by identifier.
    ///
    /// - Parameters:
    ///   - clusterID: The SKS cluster identifier.
    ///   - id: The nodepool identifier.
    /// - Returns: The SKS nodepool returned by the API.
    public func get(clusterID: String, id: String) async throws -> Exoscale.SKSNodepool {
        try await http.execute(NodepoolsOperations.Get(request: .init(clusterID: clusterID, id: id)))
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
        diskSize: Int? = nil,
        nvidiaMIGProfiles: Exoscale.NvidiaMIGProfiles? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            NodepoolsOperations.Update(
                request: .init(
                    clusterID: clusterID,
                    id: id,
                    antiAffinityGroupIDs: antiAffinityGroupIDs,
                    description: description,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    taints: taints,
                    securityGroupIDs: securityGroupIDs,
                    name: name,
                    instanceTypeID: instanceTypeID,
                    privateNetworkIDs: privateNetworkIDs,
                    kubeletImageGC: kubeletImageGC,
                    instancePrefix: instancePrefix,
                    deployTargetID: deployTargetID,
                    diskSize: diskSize,
                    nvidiaMIGProfiles: nvidiaMIGProfiles
                )
            )
        )
    }

    /// Deletes an SKS nodepool.
    ///
    /// - Parameters:
    ///   - clusterID: The SKS cluster identifier.
    ///   - id: The nodepool identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(clusterID: String, id: String) async throws -> Exoscale.Operation {
        try await http.execute(NodepoolsOperations.Delete(request: .init(clusterID: clusterID, id: id)))
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
        try await http.execute(
            NodepoolsOperations.EvictMembers(request: .init(clusterID: clusterID, id: id, instanceIDs: instanceIDs))
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
        try await http.execute(NodepoolsOperations.Scale(request: .init(clusterID: clusterID, id: id, size: size)))
    }
}
