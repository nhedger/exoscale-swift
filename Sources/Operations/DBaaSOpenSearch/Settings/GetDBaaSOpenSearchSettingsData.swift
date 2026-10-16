import Foundation

/// Response for retrieving DBaaS OpenSearch settings.
struct GetDBaaSOpenSearchSettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.OpenSearch.Settings.Payload
}
