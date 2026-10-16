import Foundation

/// Response for retrieving DBaaS PostgreSQL settings.
struct GetDBaaSPostgreSQLSettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.PostgreSQL.Settings.Payload
}
