import Foundation

extension Exoscale.DBaaS.ExternalEndpoint {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: String?
        let type: Exoscale.DBaaS.ExternalEndpointType?
        let id: String?
        let settings: [String: Exoscale.JSONValue]?
    }
}
