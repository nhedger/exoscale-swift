import Foundation

extension Exoscale.DBaaS.ClickHouse.User {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let username: String
        let uuid: String?
        let required: Bool?
    }
}
