import Foundation

/// Response for retrieving DBaaS Datadog external integration settings.
struct GetDBaaSDatadogSettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.DatadogIntegrationSettings
}
