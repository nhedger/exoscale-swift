import Foundation

extension Exoscale.LiveBalance {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let balance: Double?
        let currency: String?
    }
}
