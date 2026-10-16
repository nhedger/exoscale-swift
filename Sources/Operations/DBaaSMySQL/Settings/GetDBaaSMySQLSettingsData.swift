import Foundation

/// Response for retrieving DBaaS MySQL settings.
struct GetDBaaSMySQLSettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.MySQL.Settings.Payload
}
