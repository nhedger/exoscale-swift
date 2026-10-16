import Foundation

extension Exoscale.DBaaS.MigrationStatus {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let error: String?
        let method: String?
        let status: String?
        let details: [Detail]?
    }
}
