import Foundation

/// Request body for creating a DBaaS Valkey service.
struct CreateDBaaSValkeyServiceBody: Encodable, Sendable {
    var version: String?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String
    let terminationProtection: Bool?
    let ipFilter: [String]?
    let migration: Exoscale.DBaaS.Migration?
    let valkeySettings: [String: Exoscale.JSONValue]?
    let forkFromService: String?
    let recoveryBackupName: String?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case ipFilter = "ip-filter"
        case migration
        case valkeySettings = "valkey-settings"
        case version
        case forkFromService = "fork-from-service"
        case recoveryBackupName = "recovery-backup-name"
    }
}
