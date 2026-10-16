import Foundation

extension Exoscale.Operation {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let reason: Reason?
        let reference: Reference?
        let message: String?
        let state: State?
    }
}
