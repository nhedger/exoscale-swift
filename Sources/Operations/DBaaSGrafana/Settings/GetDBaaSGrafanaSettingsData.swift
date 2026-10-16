import Foundation

/// Response for retrieving DBaaS Grafana settings.
struct GetDBaaSGrafanaSettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.Grafana.Settings.Payload
}
