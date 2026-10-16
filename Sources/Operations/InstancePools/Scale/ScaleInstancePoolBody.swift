import Foundation

/// Request body for scaling an Instance Pool.
struct ScaleInstancePoolBody: Encodable, Sendable {
    let size: Int
}
