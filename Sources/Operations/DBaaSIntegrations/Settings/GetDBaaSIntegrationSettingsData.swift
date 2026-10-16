import Foundation

/// Response for retrieving DBaaS integration settings schema.
struct GetDBaaSIntegrationSettingsData: Decodable, Sendable {
    let settings: [String: Exoscale.JSONValue]
}
