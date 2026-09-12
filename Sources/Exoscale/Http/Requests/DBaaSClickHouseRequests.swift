struct DBaaSClickHouseServiceRequest: Encodable, Sendable {
    let plan: String?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let terminationProtection: Bool?
    let version: String?
    let ipFilter: [String]?
    let clickhouseSettings: [String: Exoscale.JSONValue]?
    var forkFromService: String?
    var recoveryBackupName: String?

    enum CodingKeys: String, CodingKey {
        case plan, maintenance, version
        case terminationProtection = "termination-protection"
        case ipFilter = "ip-filter"
        case clickhouseSettings = "clickhouse-settings"
        case forkFromService = "fork-from-service"
        case recoveryBackupName = "recovery-backup-name"
    }
}

struct CreateDBaaSClickHouseUserRequest: Encodable, Sendable {
    let username: String
    let password: String?
    let roles: [Exoscale.DBaaS.ClickHouse.RoleReference]?
}
