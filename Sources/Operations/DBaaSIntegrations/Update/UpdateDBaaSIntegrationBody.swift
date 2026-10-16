import Foundation

/// Request body for updating a DBaaS integration.
struct UpdateDBaaSIntegrationBody: Encodable, Sendable {
    let settings: [String: Exoscale.JSONValue]
}
