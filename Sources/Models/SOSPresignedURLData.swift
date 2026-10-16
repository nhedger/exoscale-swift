import Foundation

extension Exoscale.SOSPresignedURL {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let url: String?
    }
}
