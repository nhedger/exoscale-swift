import Foundation

extension Exoscale.DBaaS.PrometheusURI {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let host: String?
        let port: Int?
    }
}
