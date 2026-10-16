import Foundation

extension Exoscale.DBaaS.ExternalIntegration {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let description: String?
        let destinationEndpointName: String?
        let destinationEndpointID: String?
        let integrationID: String?
        let status: String?
        let sourceServiceName: String?
        let sourceServiceType: String?
        let type: String?
    }
}

extension Exoscale.DBaaS.ExternalIntegration.Payload {
    enum CodingKeys: String, CodingKey {
        case description
        case destinationEndpointName = "dest-endpoint-name"
        case destinationEndpointID = "dest-endpoint-id"
        case integrationID = "integration-id"
        case status
        case sourceServiceName = "source-service-name"
        case sourceServiceType = "source-service-type"
        case type
    }
}
