import Foundation

/// Request body for DBaaS external endpoint create/update requests.
struct DBaaSExternalEndpointSettingsBody: Encodable, Sendable {
    let settings: [String: Exoscale.JSONValue]
}
