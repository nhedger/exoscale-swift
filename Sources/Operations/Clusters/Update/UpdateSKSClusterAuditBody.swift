import Foundation

/// Audit configuration for updating an SKS cluster.
struct UpdateSKSClusterAuditBody: Encodable, Sendable {
    let endpoint: String?
    let bearerToken: String?
    let initialBackoff: String?
    let enabled: Bool?

    enum CodingKeys: String, CodingKey {
        case endpoint
        case bearerToken = "bearer-token"
        case initialBackoff = "initial-backoff"
        case enabled
    }
}
