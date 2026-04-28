import Foundation

/// Access to SKS cluster API operations.
public struct ClustersResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists SKS clusters.
    ///
    /// - Returns: The SKS clusters returned by the API.
    public func list() async throws -> [Exoscale.SKSCluster] {
        let response = try await http.get(path: "/sks-cluster", as: ListSKSClustersResponse.self)
        return response.clusters
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
        let audit: CreateSKSClusterAuditRequest? = if auditEndpoint != nil || auditBearerToken != nil || auditInitialBackoff != nil {
            CreateSKSClusterAuditRequest(
                endpoint: auditEndpoint,
                bearerToken: auditBearerToken,
                initialBackoff: auditInitialBackoff
            )
        } else {
            nil
        }

        let body = try JSONEncoder().encode(
            CreateSKSClusterRequest(
                description: description,
                labels: labels,
                cni: cni,
                autoUpgrade: autoUpgrade,
                networking: networking,
                oidc: oidc,
                name: name,
                createDefaultSecurityGroup: createDefaultSecurityGroup,
                enableKubeProxy: enableKubeProxy,
                level: level,
                featureGates: featureGates,
                addons: addons,
                audit: audit,
                version: version
            )
        )

        return try await http.post(path: "/sks-cluster", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves deprecated Kubernetes resources for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The deprecated resources returned by the API.
    public func deprecatedResources(id: String) async throws -> [Exoscale.SKSClusterDeprecatedResource] {
        try await http.get(
            path: "/sks-cluster-deprecated-resources/\(id)",
            as: [Exoscale.SKSClusterDeprecatedResource].self
        )
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
        let body = try JSONEncoder().encode(
            GenerateSKSClusterKubeconfigRequest(
                ttl: ttl,
                user: user,
                groups: groups
            )
        )
        let response = try await http.post(
            path: "/sks-cluster-kubeconfig/\(id)",
            body: body,
            as: GenerateSKSClusterKubeconfigResponse.self
        )
        return response.kubeconfig
    }

    /// Lists available SKS cluster versions.
    ///
    /// - Parameter includeDeprecated: Whether to include deprecated versions.
    /// - Returns: The cluster versions returned by the API.
    public func listVersions(includeDeprecated: Bool? = nil) async throws -> [String] {
        var query: [String: String?] = [:]

        if let includeDeprecated {
            query["include-deprecated"] = includeDeprecated ? "true" : "false"
        }

        let response = try await http.get(
            path: "/sks-cluster-version",
            query: query,
            as: ListSKSClusterVersionsResponse.self
        )
        return response.versions
    }

    /// Deletes an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/sks-cluster/\(id)", as: Exoscale.Operation.self)
    }

    /// Retrieves an SKS cluster by identifier.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The SKS cluster returned by the API.
    public func get(id: String) async throws -> Exoscale.SKSCluster {
        try await http.get(path: "/sks-cluster/\(id)", as: Exoscale.SKSCluster.self)
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
        let audit: UpdateSKSClusterAuditRequest? = if auditEndpoint != nil || auditBearerToken != nil || auditInitialBackoff != nil || auditEnabled != nil {
            UpdateSKSClusterAuditRequest(
                endpoint: auditEndpoint,
                bearerToken: auditBearerToken,
                initialBackoff: auditInitialBackoff,
                enabled: auditEnabled
            )
        } else {
            nil
        }

        let body = try JSONEncoder().encode(
            UpdateSKSClusterRequest(
                description: description,
                labels: labels,
                autoUpgrade: autoUpgrade,
                oidc: oidc,
                name: name,
                enableOperatorsCA: enableOperatorsCA,
                featureGates: featureGates,
                addons: addons,
                audit: audit
            )
        )

        return try await http.put(path: "/sks-cluster/\(id)", body: body, as: Exoscale.Operation.self)
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
        let response = try await http.get(
            path: "/sks-cluster/\(id)/authority/\(authority.rawValue)/cert",
            as: GetSKSClusterAuthorityCertificateResponse.self
        )
        return response.caCert
    }

    /// Retrieves the latest SKS cluster inspection result.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The inspection result returned by the API.
    public func inspection(id: String) async throws -> [String: Exoscale.JSONValue] {
        try await http.get(path: "/sks-cluster/\(id)/inspection", as: [String: Exoscale.JSONValue].self)
    }

    /// Rotates Exoscale CCM credentials for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func rotateCCMCredentials(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/sks-cluster/\(id)/rotate-ccm-credentials", as: Exoscale.Operation.self)
    }

    /// Rotates Exoscale CSI credentials for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func rotateCSICredentials(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/sks-cluster/\(id)/rotate-csi-credentials", as: Exoscale.Operation.self)
    }

    /// Rotates Exoscale Karpenter credentials for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func rotateKarpenterCredentials(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/sks-cluster/\(id)/rotate-karpenter-credentials", as: Exoscale.Operation.self)
    }

    /// Rotates the operators certificate authority for an SKS cluster.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func rotateOperatorsCA(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/sks-cluster/\(id)/rotate-operators-ca", as: Exoscale.Operation.self)
    }

    /// Upgrades an SKS cluster to a new Kubernetes version.
    ///
    /// - Parameters:
    ///   - id: The SKS cluster identifier.
    ///   - version: The target Kubernetes control plane version.
    /// - Returns: The asynchronous operation returned by the API.
    public func upgrade(id: String, version: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpgradeSKSClusterRequest(version: version))
        return try await http.put(path: "/sks-cluster/\(id)/upgrade", body: body, as: Exoscale.Operation.self)
    }

    /// Upgrades an SKS cluster to the pro service level.
    ///
    /// - Parameter id: The SKS cluster identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func upgradeServiceLevel(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/sks-cluster/\(id)/upgrade-service-level", as: Exoscale.Operation.self)
    }
}
