import Foundation

/// Request body for creating a DBaaS integration.
struct CreateDBaaSIntegrationBody: Encodable, Sendable {
    let integrationType: Exoscale.DBaaS.IntegrationType
    let sourceService: String
    let destinationService: String
    let settings: [String: Exoscale.JSONValue]?

    enum CodingKeys: String, CodingKey {
        case integrationType = "integration-type"
        case sourceService = "source-service"
        case destinationService = "dest-service"
        case settings
    }
}
