import Foundation

extension Exoscale.InstancePassword {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let password: String?
    }
}
