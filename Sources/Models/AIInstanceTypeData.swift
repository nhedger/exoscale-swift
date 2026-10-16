import Foundation

extension Exoscale.AIInstanceType {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let family: String?
        let authorized: Bool?
    }
}
