typealias DBaaSGrafana = Exoscale.DBaaS.Grafana
typealias DBaaSKafka = Exoscale.DBaaS.Kafka
typealias DBaaSMySQL = Exoscale.DBaaS.MySQL
typealias DBaaSOpenSearch = Exoscale.DBaaS.OpenSearch
typealias DBaaSThanos = Exoscale.DBaaS.Thanos
typealias DBaaSValkey = Exoscale.DBaaS.Valkey

/// Request body for creating a DBaaS Grafana service.
struct CreateDBaaSGrafanaServiceRequest: Codable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String
    let terminationProtection: Bool?
    let forkFromService: String?
    let grafanaSettings: [String: Exoscale.JSONValue]?
    let ipFilter: [String]?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case forkFromService = "fork-from-service"
        case grafanaSettings = "grafana-settings"
        case ipFilter = "ip-filter"
    }
}

/// Request body for updating a DBaaS Grafana service.
struct UpdateDBaaSGrafanaServiceRequest: Codable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String?
    let terminationProtection: Bool?
    let grafanaSettings: [String: Exoscale.JSONValue]?
    let ipFilter: [String]?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case grafanaSettings = "grafana-settings"
        case ipFilter = "ip-filter"
    }
}

/// Request body for resetting a DBaaS user password.
struct ResetDBaaSUserPasswordRequest: Codable, Sendable {
    let password: String?
}

/// Request body for creating or updating a DBaaS Kafka service.
struct DBaaSKafkaServiceRequest: Codable, Sendable {
    let authenticationMethods: DBaaSKafka.AuthenticationMethods?
    let kafkaRestEnabled: Bool?
    let kafkaConnectEnabled: Bool?
    let ipFilter: [String]?
    let schemaRegistrySettings: [String: Exoscale.JSONValue]?
    let kafkaRestSettings: [String: Exoscale.JSONValue]?
    let terminationProtection: Bool?
    let kafkaConnectSettings: [String: Exoscale.JSONValue]?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let kafkaSettings: [String: Exoscale.JSONValue]?
    let schemaRegistryEnabled: Bool?
    let version: String?
    let plan: String?

    enum CodingKeys: String, CodingKey {
        case authenticationMethods = "authentication-methods"
        case kafkaRestEnabled = "kafka-rest-enabled"
        case kafkaConnectEnabled = "kafka-connect-enabled"
        case ipFilter = "ip-filter"
        case schemaRegistrySettings = "schema-registry-settings"
        case kafkaRestSettings = "kafka-rest-settings"
        case terminationProtection = "termination-protection"
        case kafkaConnectSettings = "kafka-connect-settings"
        case maintenance
        case kafkaSettings = "kafka-settings"
        case schemaRegistryEnabled = "schema-registry-enabled"
        case version
        case plan
    }
}

/// Request body for creating a DBaaS Kafka user.
struct CreateDBaaSKafkaUserRequest: Codable, Sendable {
    let username: String
}

/// Request body for creating a DBaaS MySQL service.
struct CreateDBaaSMySQLServiceRequest: Codable, Sendable {
    let backupSchedule: Exoscale.DBaaS.BackupSchedule?
    let integrations: [Exoscale.DBaaS.IntegrationInput]?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let forkFromService: String?
    let recoveryBackupTime: String?
    let mysqlSettings: [String: Exoscale.JSONValue]?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let adminUsername: String?
    let version: String?
    let plan: String
    let adminPassword: String?
    let migration: Exoscale.DBaaS.Migration?
    let binlogRetentionPeriod: Int?

    enum CodingKeys: String, CodingKey {
        case backupSchedule = "backup-schedule"
        case integrations
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case forkFromService = "fork-from-service"
        case recoveryBackupTime = "recovery-backup-time"
        case mysqlSettings = "mysql-settings"
        case maintenance
        case adminUsername = "admin-username"
        case version
        case plan
        case adminPassword = "admin-password"
        case migration
        case binlogRetentionPeriod = "binlog-retention-period"
    }
}

/// Request body for updating a DBaaS MySQL service.
struct UpdateDBaaSMySQLServiceRequest: Codable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String?
    let terminationProtection: Bool?
    let ipFilter: [String]?
    let mysqlSettings: [String: Exoscale.JSONValue]?
    let migration: Exoscale.DBaaS.Migration?
    let binlogRetentionPeriod: Int?
    let backupSchedule: Exoscale.DBaaS.BackupSchedule?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case ipFilter = "ip-filter"
        case mysqlSettings = "mysql-settings"
        case migration
        case binlogRetentionPeriod = "binlog-retention-period"
        case backupSchedule = "backup-schedule"
    }
}

/// Request body for creating a DBaaS MySQL database.
struct CreateDBaaSMySQLDatabaseRequest: Codable, Sendable {
    let databaseName: String

    enum CodingKeys: String, CodingKey {
        case databaseName = "database-name"
    }
}

/// Request body for creating a DBaaS MySQL user.
struct CreateDBaaSMySQLUserRequest: Codable, Sendable {
    let username: String
    let authentication: DBaaSMySQL.AuthenticationPlugin?
}

/// Request body for resetting a DBaaS MySQL user password.
struct ResetDBaaSMySQLUserPasswordRequest: Codable, Sendable {
    let password: String?
    let authentication: DBaaSMySQL.AuthenticationPlugin?
}

/// Request body for creating a DBaaS OpenSearch service.
struct CreateDBaaSOpenSearchServiceRequest: Codable, Sendable {
    let maxIndexCount: Int?
    let keepIndexRefreshInterval: Bool?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let forkFromService: String?
    let indexPatterns: [DBaaSOpenSearch.IndexPattern]?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let indexTemplate: DBaaSOpenSearch.IndexTemplate?
    let opensearchSettings: [String: Exoscale.JSONValue]?
    let version: String?
    let recoveryBackupName: String?
    let plan: String
    let opensearchDashboards: DBaaSOpenSearch.Dashboards?

    enum CodingKeys: String, CodingKey {
        case maxIndexCount = "max-index-count"
        case keepIndexRefreshInterval = "keep-index-refresh-interval"
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case forkFromService = "fork-from-service"
        case indexPatterns = "index-patterns"
        case maintenance
        case indexTemplate = "index-template"
        case opensearchSettings = "opensearch-settings"
        case version
        case recoveryBackupName = "recovery-backup-name"
        case plan
        case opensearchDashboards = "opensearch-dashboards"
    }
}

/// Request body for updating a DBaaS OpenSearch service.
struct UpdateDBaaSOpenSearchServiceRequest: Codable, Sendable {
    let maxIndexCount: Int?
    let keepIndexRefreshInterval: Bool?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let indexPatterns: [DBaaSOpenSearch.IndexPattern]?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let indexTemplate: DBaaSOpenSearch.IndexTemplate?
    let opensearchSettings: [String: Exoscale.JSONValue]?
    let version: String?
    let plan: String?
    let opensearchDashboards: DBaaSOpenSearch.Dashboards?

    enum CodingKeys: String, CodingKey {
        case maxIndexCount = "max-index-count"
        case keepIndexRefreshInterval = "keep-index-refresh-interval"
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case indexPatterns = "index-patterns"
        case maintenance
        case indexTemplate = "index-template"
        case opensearchSettings = "opensearch-settings"
        case version
        case plan
        case opensearchDashboards = "opensearch-dashboards"
    }
}

/// Request body for creating a DBaaS OpenSearch user.
struct CreateDBaaSOpenSearchUserRequest: Codable, Sendable {
    let username: String
}

/// Request body for creating a DBaaS Thanos service.
struct CreateDBaaSThanosServiceRequest: Codable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String
    let terminationProtection: Bool?
    let ipFilter: [String]?
    let thanosSettings: [String: Exoscale.JSONValue]?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case ipFilter = "ip-filter"
        case thanosSettings = "thanos-settings"
    }
}

/// Request body for updating a DBaaS Thanos service.
struct UpdateDBaaSThanosServiceRequest: Codable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String?
    let terminationProtection: Bool?
    let ipFilter: [String]?
    let thanosSettings: [String: Exoscale.JSONValue]?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case ipFilter = "ip-filter"
        case thanosSettings = "thanos-settings"
    }
}

/// Request body for creating a DBaaS Valkey service.
struct CreateDBaaSValkeyServiceRequest: Codable, Sendable {
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
        case forkFromService = "fork-from-service"
        case recoveryBackupName = "recovery-backup-name"
    }
}

/// Request body for updating a DBaaS Valkey service.
struct UpdateDBaaSValkeyServiceRequest: Codable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String?
    let terminationProtection: Bool?
    let ipFilter: [String]?
    let migration: Exoscale.DBaaS.Migration?
    let valkeySettings: [String: Exoscale.JSONValue]?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case ipFilter = "ip-filter"
        case migration
        case valkeySettings = "valkey-settings"
    }
}

/// Request body for creating a DBaaS Valkey user.
struct CreateDBaaSValkeyUserRequest: Codable, Sendable {
    let username: String
    let accessControl: DBaaSValkey.AccessControl?

    enum CodingKeys: String, CodingKey {
        case username
        case accessControl = "access-control"
    }
}

/// Request body for updating a DBaaS Valkey user.
struct UpdateDBaaSValkeyUserRequest: Codable, Sendable {
    let accessControl: DBaaSValkey.AccessControl?

    enum CodingKeys: String, CodingKey {
        case accessControl = "access-control"
    }
}
