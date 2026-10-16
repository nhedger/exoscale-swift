import Foundation

struct GetDBaaSClickHouseSettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.ClickHouse.Settings.Payload
}
