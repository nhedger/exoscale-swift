import Foundation

/// Response for listing DBaaS external integrations.
struct ListDBaaSExternalIntegrationsData: Decodable, Sendable {
    let externalIntegrations: [Exoscale.DBaaS.ExternalIntegration.Payload]

    enum CodingKeys: String, CodingKey {
        case externalIntegrations = "external-integrations"
    }
}
