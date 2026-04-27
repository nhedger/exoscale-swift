typealias DBaaSPostgreSQL = Exoscale.DBaaS.PostgreSQL

/// Request body for creating a DBaaS PostgreSQL service.
struct CreateDBaaSPostgreSQLServiceRequest: Codable, Sendable {
    let pgbouncerSettings: [String: Exoscale.JSONValue]?
    let backupSchedule: DBaaSPostgreSQL.BackupSchedule?
    let variant: DBaaSPostgreSQL.Variant?
    let integrations: [DBaaSPostgreSQL.IntegrationInput]?
    let timescaledbSettings: [String: Exoscale.JSONValue]?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let forkFromService: String?
    let synchronousReplication: DBaaSPostgreSQL.SynchronousReplication?
    let recoveryBackupTime: String?
    let pglookoutSettings: [String: Exoscale.JSONValue]?
    let maintenance: DBaaSPostgreSQL.Maintenance?
    let adminUsername: String?
    let version: String?
    let plan: String
    let workMem: Int?
    let sharedBuffersPercentage: Int?
    let pgSettings: [String: Exoscale.JSONValue]?
    let adminPassword: String?
    let migration: DBaaSPostgreSQL.Migration?

    enum CodingKeys: String, CodingKey {
        case pgbouncerSettings = "pgbouncer-settings"
        case backupSchedule = "backup-schedule"
        case variant
        case integrations
        case timescaledbSettings = "timescaledb-settings"
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case forkFromService = "fork-from-service"
        case synchronousReplication = "synchronous-replication"
        case recoveryBackupTime = "recovery-backup-time"
        case pglookoutSettings = "pglookout-settings"
        case maintenance
        case adminUsername = "admin-username"
        case version
        case plan
        case workMem = "work-mem"
        case sharedBuffersPercentage = "shared-buffers-percentage"
        case pgSettings = "pg-settings"
        case adminPassword = "admin-password"
        case migration
    }
}

/// Request body for updating a DBaaS PostgreSQL service.
struct UpdateDBaaSPostgreSQLServiceRequest: Codable, Sendable {
    let pgbouncerSettings: [String: Exoscale.JSONValue]?
    let backupSchedule: DBaaSPostgreSQL.BackupSchedule?
    let variant: DBaaSPostgreSQL.Variant?
    let timescaledbSettings: [String: Exoscale.JSONValue]?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let synchronousReplication: DBaaSPostgreSQL.SynchronousReplication?
    let pglookoutSettings: [String: Exoscale.JSONValue]?
    let maintenance: DBaaSPostgreSQL.Maintenance?
    let version: String?
    let plan: String?
    let workMem: Int?
    let sharedBuffersPercentage: Int?
    let pgSettings: [String: Exoscale.JSONValue]?
    let migration: DBaaSPostgreSQL.Migration?

    enum CodingKeys: String, CodingKey {
        case pgbouncerSettings = "pgbouncer-settings"
        case backupSchedule = "backup-schedule"
        case variant
        case timescaledbSettings = "timescaledb-settings"
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case synchronousReplication = "synchronous-replication"
        case pglookoutSettings = "pglookout-settings"
        case maintenance
        case version
        case plan
        case workMem = "work-mem"
        case sharedBuffersPercentage = "shared-buffers-percentage"
        case pgSettings = "pg-settings"
        case migration
    }
}

/// Request body for creating a DBaaS PostgreSQL connection pool.
struct CreateDBaaSPostgreSQLConnectionPoolRequest: Codable, Sendable {
    let name: String
    let databaseName: String
    let mode: DBaaSPostgreSQL.PoolMode?
    let size: Int?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case name
        case databaseName = "database-name"
        case mode
        case size
        case username
    }
}

/// Request body for updating a DBaaS PostgreSQL connection pool.
struct UpdateDBaaSPostgreSQLConnectionPoolRequest: Codable, Sendable {
    let databaseName: String?
    let mode: DBaaSPostgreSQL.PoolMode?
    let size: Int?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case databaseName = "database-name"
        case mode
        case size
        case username
    }
}

/// Request body for creating a DBaaS PostgreSQL database.
struct CreateDBaaSPostgreSQLDatabaseRequest: Codable, Sendable {
    let databaseName: String
    let lcCollate: String?
    let lcCType: String?

    enum CodingKeys: String, CodingKey {
        case databaseName = "database-name"
        case lcCollate = "lc-collate"
        case lcCType = "lc-ctype"
    }
}

/// Request body for creating a DBaaS PostgreSQL user.
struct CreateDBaaSPostgreSQLUserRequest: Codable, Sendable {
    let username: String
    let allowReplication: Bool?

    enum CodingKeys: String, CodingKey {
        case username
        case allowReplication = "allow-replication"
    }
}

/// Request body for updating DBaaS PostgreSQL user replication access.
struct UpdateDBaaSPostgreSQLUserReplicationRequest: Codable, Sendable {
    let allowReplication: Bool

    enum CodingKeys: String, CodingKey {
        case allowReplication = "allow-replication"
    }
}

/// Request body for resetting a DBaaS PostgreSQL user password.
struct ResetDBaaSPostgreSQLUserPasswordRequest: Codable, Sendable {
    let password: String?
}

/// Request body for checking a DBaaS PostgreSQL upgrade.
struct CheckDBaaSPostgreSQLUpgradeRequest: Codable, Sendable {
    let targetVersion: String

    enum CodingKeys: String, CodingKey {
        case targetVersion = "target-version"
    }
}
