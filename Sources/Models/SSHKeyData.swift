import Foundation

extension Exoscale.SSHKey {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: String?
        let fingerprint: String?
    }
}
