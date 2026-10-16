import Foundation

/// Request body for scaling an SKS nodepool.
struct ScaleSKSNodepoolBody: Encodable, Sendable {
    let size: Int
}
