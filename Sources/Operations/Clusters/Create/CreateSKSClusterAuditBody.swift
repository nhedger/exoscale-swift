import Foundation

/// Audit configuration for creating an SKS cluster.
struct CreateSKSClusterAuditBody: Encodable, Sendable {
    let endpoint: String?
    let bearerToken: String?
    let initialBackoff: String?

    enum CodingKeys: String, CodingKey {
        case endpoint
        case bearerToken = "bearer-token"
        case initialBackoff = "initial-backoff"
    }
}
