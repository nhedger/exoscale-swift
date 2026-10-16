import Foundation

extension Exoscale.AIDeploymentLogEntry {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let time: Date?
        let node: String?
        let message: String?
    }
}
