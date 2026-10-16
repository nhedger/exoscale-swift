import Foundation

extension Exoscale.Quota {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let resource: String?
        let usage: Int?
        let limit: Int?
    }
}
