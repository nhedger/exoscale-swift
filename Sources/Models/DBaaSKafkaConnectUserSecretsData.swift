import Foundation

extension Exoscale.DBaaS.Kafka.ConnectUserSecrets {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let username: String?
        let password: String?
    }
}
