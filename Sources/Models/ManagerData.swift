import Foundation

extension Exoscale.Manager {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let type: Kind?
    }
}
