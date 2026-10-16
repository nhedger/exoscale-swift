import Foundation

extension Exoscale.DBaaS.Notification {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let level: String?
        let message: String?
        let type: String?
        let metadata: [String: Exoscale.JSONValue]?
    }
}
