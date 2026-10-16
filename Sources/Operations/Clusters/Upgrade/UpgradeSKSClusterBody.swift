import Foundation

/// Request body for upgrading an SKS cluster.
struct UpgradeSKSClusterBody: Encodable, Sendable {
    let version: String
}
