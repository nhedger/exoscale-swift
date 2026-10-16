import Foundation

extension Exoscale.DBaaS.ExternalEndpointTypeInfo {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let type: Exoscale.DBaaS.ExternalEndpointType?
        let serviceTypes: [String]?
        let title: String?
    }
}

extension Exoscale.DBaaS.ExternalEndpointTypeInfo.Payload {
    enum CodingKeys: String, CodingKey {
        case type
        case serviceTypes = "service-types"
        case title
    }
}
