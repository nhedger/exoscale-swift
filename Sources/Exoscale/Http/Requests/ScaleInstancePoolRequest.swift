/// Request body for scaling an Instance Pool.
struct ScaleInstancePoolRequest: Codable, Sendable {
    let size: Int
}
