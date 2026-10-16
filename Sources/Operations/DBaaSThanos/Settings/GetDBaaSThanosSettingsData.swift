import Foundation

/// Response for retrieving DBaaS Thanos settings.
struct GetDBaaSThanosSettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.Thanos.Settings.Payload
}
