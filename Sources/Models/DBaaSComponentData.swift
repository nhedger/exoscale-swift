import Foundation

extension Exoscale.DBaaS.Component {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let component: String?
        let host: String?
        let port: Int?
        let route: String?
        let usage: String?
    }
}
