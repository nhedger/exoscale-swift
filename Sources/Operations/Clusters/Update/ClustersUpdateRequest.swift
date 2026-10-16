import Foundation

extension ClustersOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let description: String?
        let labels: [String: String]?
        let autoUpgrade: Bool?
        let oidc: Exoscale.SKSOIDC?
        let name: String?
        let enableOperatorsCA: Bool?
        let featureGates: [String]?
        let addons: [Exoscale.SKSCluster.Addon]?
        let auditEndpoint: String?
        let auditBearerToken: String?
        let auditInitialBackoff: String?
        let auditEnabled: Bool?

        func resolve() throws -> Http.Request {
            let audit: UpdateSKSClusterAuditBody? = if auditEndpoint != nil || auditBearerToken != nil ||
                auditInitialBackoff != nil || auditEnabled != nil {
                UpdateSKSClusterAuditBody(
                    endpoint: auditEndpoint,
                    bearerToken: auditBearerToken,
                    initialBackoff: auditInitialBackoff,
                    enabled: auditEnabled
                )
            } else {
                nil
            }

            let body = try Exoscale.jsonEncoder().encode(
                UpdateSKSClusterBody(
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

            return Http.Request(
                method: .put,
                path: "/sks-cluster/\(id)",
                body: body
            )
        }
    }
}
