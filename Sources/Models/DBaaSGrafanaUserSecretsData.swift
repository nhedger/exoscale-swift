import Foundation

extension Exoscale.DBaaS.Grafana.UserSecrets {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let username: String?
        let password: String?
    }
}
