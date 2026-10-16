import Foundation

extension Exoscale.DBaaS.IntegrationTypeInfo {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let type: Exoscale.DBaaS.IntegrationType?
        let sourceDescription: String?
        let sourceServiceTypes: [String]?
        let destinationDescription: String?
        let destinationServiceTypes: [String]?
        let settings: [String: Exoscale.JSONValue]?
    }
}

extension Exoscale.DBaaS.IntegrationTypeInfo.Payload {
    enum CodingKeys: String, CodingKey {
        case type
        case sourceDescription = "source-description"
        case sourceServiceTypes = "source-service-types"
        case destinationDescription = "dest-description"
        case destinationServiceTypes = "dest-service-types"
        case settings
    }
}
