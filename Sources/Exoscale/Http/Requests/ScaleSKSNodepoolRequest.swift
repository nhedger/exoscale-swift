/// Request body for scaling an SKS nodepool.
struct ScaleSKSNodepoolRequest: Codable, Sendable {
    let size: Int
}
