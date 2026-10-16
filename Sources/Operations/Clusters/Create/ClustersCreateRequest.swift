import Foundation

extension ClustersOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let level: Exoscale.SKSCluster.Level
        let version: String
        let description: String?
        let labels: [String: String]?
        let cni: Exoscale.SKSCluster.CNI?
        let autoUpgrade: Bool?
        let networking: Exoscale.SKSClusterNetworking?
        let oidc: Exoscale.SKSOIDC?
        let createDefaultSecurityGroup: Bool?
        let enableKubeProxy: Bool?
        let featureGates: [String]?
        let addons: [Exoscale.SKSCluster.Addon]?
        let auditEndpoint: String?
        let auditBearerToken: String?
        let auditInitialBackoff: String?

        func resolve() throws -> Http.Request {
            let audit: CreateSKSClusterAuditBody? = if auditEndpoint != nil || auditBearerToken != nil ||
                auditInitialBackoff != nil {
                CreateSKSClusterAuditBody(
                    endpoint: auditEndpoint,
                    bearerToken: auditBearerToken,
                    initialBackoff: auditInitialBackoff
                )
            } else {
                nil
            }

            let body = try Exoscale.jsonEncoder().encode(
                CreateSKSClusterBody(
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

            return Http.Request(
                method: .post,
                path: "/sks-cluster",
                body: body
            )
        }
    }
}
