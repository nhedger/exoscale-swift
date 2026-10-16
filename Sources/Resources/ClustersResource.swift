import Foundation

/// Access to SKS cluster API operations.
public struct ClustersResource: Sendable {
    let http: Http.Client

    /// Generates a minimal Karpenter NodePool manifest.
    public func generateKarpenterNodepool(id: String) async throws -> String {
        try await http.execute(ClustersOperations.GenerateKarpenterNodepool(request: .init(id: id)))
    }

    /// Generates an ExoscaleNodeClass manifest with the cluster's defaults.
    public func generateKarpenterExoscaleNodeclass(id: String) async throws -> String {
        try await http.execute(ClustersOperations.GenerateKarpenterExoscaleNodeclass(request: .init(id: id)))
    }

    /// Lists SKS clusters.
    ///
    /// - Returns: The SKS clusters returned by the API.
    public func list() async throws -> [Exoscale.SKSCluster] {
        try await http.execute(ClustersOperations.List(request: .init()))
    }

    /// Creates an SKS cluster.
    ///
    /// - Parameters:
    ///   - name: The cluster name.
    ///   - level: The cluster service level.
    ///   - version: The Kubernetes control plane version.
    ///   - description: Optional cluster description.
    ///   - labels: Optional cluster labels.
    ///   - cni: Optional cluster CNI.
    ///   - autoUpgrade: Optional control plane auto-upgrade flag.
    ///   - networking: Optional cluster networking configuration.
    ///   - oidc: Optional OpenID Connect configuration.
    ///   - createDefaultSecurityGroup: Whether to create a default security group.
    ///   - enableKubeProxy: Whether to deploy kube-proxy.
    ///   - featureGates: Optional Kubernetes feature gates.
    ///   - addons: Optional cluster addons.
    ///   - auditEndpoint: Optional audit log target endpoint.
    ///   - auditBearerToken: Optional audit log bearer token.
    ///   - auditInitialBackoff: Optional audit log initial backoff.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        name: String,
        level: Exoscale.SKSCluster.Level,
        version: String,
        description: String? = nil,
        labels: [String: String]? = nil,
        cni: Exoscale.SKSCluster.CNI? = nil,
        autoUpgrade: Bool? = nil,
        networking: Exoscale.SKSClusterNetworking? = nil,
        oidc: Exoscale.SKSOIDC? = nil,
        createDefaultSecurityGroup: Bool? = nil,
        enableKubeProxy: Bool? = nil,
        featureGates: [String]? = nil,
        addons: [Exoscale.SKSCluster.Addon]? = nil,
        auditEndpoint: String? = nil,
        auditBearerToken: String? = nil,
        auditInitialBackoff: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            ClustersOperations.Create(
                request: .init(
                    name: name,
                    level: level,
                    version: version,
                    description: description,
                    labels: labels,
                    cni: cni,
                    autoUpgrade: autoUpgrade,
                    networking: networking,
                    oidc: oidc,
                    createDefaultSecurityGroup: createDefaultSecurityGroup,
                    enableKubeProxy: enableKubeProxy,
                    featureGates: featureGates,
                    addons: addons,
                    auditEndpoint: auditEndpoint,
                    auditBearerToken: auditBearerToken,
                    auditInitialBackoff: auditInitialBackoff
                )
            )
        )
    }

    /// Retrieves deprecated Kubernetes resources for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The deprecated resources returned by the API.
    public func deprecatedResources(id: String) async throws -> [Exoscale.SKSClusterDeprecatedResource] {
        try await http.execute(ClustersOperations.DeprecatedResources(request: .init(id: id)))
    }

    /// Generates a kubeconfig for an SKS cluster.
    ///
    /// - Parameters:
    ///   - id: The SKS cluster identifier.
    ///   - user: The kubeconfig user name.
    ///   - groups: The Kubernetes groups for the user certificate.
    ///   - ttl: Optional validity in seconds for the user certificate.
    /// - Returns: The base64-encoded kubeconfig returned by the API.
    public func generateKubeconfig(
        id: String,
        user: String,
        groups: [String],
        ttl: Int? = nil
    ) async throws -> String {
        try await http.execute(
            ClustersOperations.GenerateKubeconfig(request: .init(id: id, user: user, groups: groups, ttl: ttl))
        )
    }

    /// Lists available SKS cluster versions.
    ///
    /// - Parameter includeDeprecated: Whether to include deprecated versions.
    /// - Returns: The cluster versions returned by the API.
    public func listVersions(includeDeprecated: Bool? = nil) async throws -> [String] {
        try await http.execute(ClustersOperations.ListVersions(request: .init(includeDeprecated: includeDeprecated)))
    }

    /// Deletes an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ClustersOperations.Delete(request: .init(id: id)))
    }

    /// Retrieves an SKS cluster by identifier.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The SKS cluster returned by the API.
    public func get(id: String) async throws -> Exoscale.SKSCluster {
        try await http.execute(ClustersOperations.Get(request: .init(id: id)))
    }

    /// Updates an SKS cluster.
    ///
    /// - Parameters:
    ///   - id: The SKS cluster identifier.
    ///   - description: Optional cluster description.
    ///   - labels: Optional cluster labels.
    ///   - autoUpgrade: Optional control plane auto-upgrade flag.
    ///   - oidc: Optional OpenID Connect configuration.
    ///   - name: Optional cluster name.
    ///   - enableOperatorsCA: Optional operators CA trust flag.
    ///   - featureGates: Optional Kubernetes feature gates.
    ///   - addons: Optional cluster addons.
    ///   - auditEndpoint: Optional audit log target endpoint.
    ///   - auditBearerToken: Optional audit log bearer token.
    ///   - auditInitialBackoff: Optional audit log initial backoff.
    ///   - auditEnabled: Optional audit logging enabled flag.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        description: String? = nil,
        labels: [String: String]? = nil,
        autoUpgrade: Bool? = nil,
        oidc: Exoscale.SKSOIDC? = nil,
        name: String? = nil,
        enableOperatorsCA: Bool? = nil,
        featureGates: [String]? = nil,
        addons: [Exoscale.SKSCluster.Addon]? = nil,
        auditEndpoint: String? = nil,
        auditBearerToken: String? = nil,
        auditInitialBackoff: String? = nil,
        auditEnabled: Bool? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            ClustersOperations.Update(
                request: .init(
                    id: id,
                    description: description,
                    labels: labels,
                    autoUpgrade: autoUpgrade,
                    oidc: oidc,
                    name: name,
                    enableOperatorsCA: enableOperatorsCA,
                    featureGates: featureGates,
                    addons: addons,
                    auditEndpoint: auditEndpoint,
                    auditBearerToken: auditBearerToken,
                    auditInitialBackoff: auditInitialBackoff,
                    auditEnabled: auditEnabled
                )
            )
        )
    }

    /// Retrieves a certificate for an SKS cluster authority.
    ///
    /// - Parameters:
    ///   - id: The SKS cluster identifier.
    ///   - authority: The SKS cluster authority.
    /// - Returns: The base64-encoded certificate returned by the API.
    public func authorityCertificate(
        id: String,
        authority: Exoscale.SKSCluster.Authority
    ) async throws -> String {
        try await http.execute(ClustersOperations.AuthorityCertificate(request: .init(id: id, authority: authority)))
    }

    /// Retrieves the latest SKS cluster inspection result.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The inspection result returned by the API.
    public func inspection(id: String) async throws -> [String: Exoscale.JSONValue] {
        try await http.execute(ClustersOperations.Inspection(request: .init(id: id)))
    }

    /// Rotates Exoscale CCM credentials for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func rotateCCMCredentials(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ClustersOperations.RotateCCMCredentials(request: .init(id: id)))
    }

    /// Rotates Exoscale CSI credentials for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func rotateCSICredentials(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ClustersOperations.RotateCSICredentials(request: .init(id: id)))
    }

    /// Rotates Exoscale Karpenter credentials for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func rotateKarpenterCredentials(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ClustersOperations.RotateKarpenterCredentials(request: .init(id: id)))
    }

    /// Rotates the operators certificate authority for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func rotateOperatorsCA(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ClustersOperations.RotateOperatorsCA(request: .init(id: id)))
    }

    /// Upgrades an SKS cluster to a new Kubernetes version.
    ///
    /// - Parameters:
    ///   - id: The SKS cluster identifier.
    ///   - version: The target Kubernetes control plane version.
    /// - Returns: The asynchronous operation returned by the API.
    public func upgrade(id: String, version: String) async throws -> Exoscale.Operation {
        try await http.execute(ClustersOperations.Upgrade(request: .init(id: id, version: version)))
    }

    /// Upgrades an SKS cluster to the pro service level.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func upgradeServiceLevel(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ClustersOperations.UpgradeServiceLevel(request: .init(id: id)))
    }
}
