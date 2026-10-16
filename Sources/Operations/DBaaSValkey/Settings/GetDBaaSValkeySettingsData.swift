import Foundation

/// Response for retrieving DBaaS Valkey settings.
struct GetDBaaSValkeySettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.Valkey.Settings.Payload
}
