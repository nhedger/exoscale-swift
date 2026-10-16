import Foundation

/// Request body for updating DBaaS Datadog external integration settings.
struct UpdateDBaaSDatadogSettingsBody: Encodable, Sendable {
    let settings: Exoscale.DBaaS.DatadogIntegrationSettings
}
