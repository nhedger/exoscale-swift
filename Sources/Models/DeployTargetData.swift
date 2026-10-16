import Foundation

extension Exoscale.DeployTarget {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let name: String?
        let type: Kind?
        let description: String?
    }
}
