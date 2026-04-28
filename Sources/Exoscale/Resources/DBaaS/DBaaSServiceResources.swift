import Foundation

/// Access to DBaaS Grafana API operations.
public struct DBaaSGrafanaResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves a DBaaS Grafana service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.Grafana.Service {
        try await http.get(path: "/dbaas-grafana/\(name)", as: Exoscale.DBaaS.Grafana.Service.self)
    }

    /// Creates a DBaaS Grafana service.
    public func create(
        name: String,
        plan: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        terminationProtection: Bool? = nil,
        forkFromService: String? = nil,
        grafanaSettings: [String: Exoscale.JSONValue]? = nil,
        ipFilter: [String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSGrafanaServiceRequest(
                maintenance: maintenance,
                plan: plan,
                terminationProtection: terminationProtection,
                forkFromService: forkFromService,
                grafanaSettings: grafanaSettings,
                ipFilter: ipFilter
            )
        )
        return try await http.post(path: "/dbaas-grafana/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a DBaaS Grafana service.
    public func update(
        name: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        plan: String? = nil,
        terminationProtection: Bool? = nil,
        grafanaSettings: [String: Exoscale.JSONValue]? = nil,
        ipFilter: [String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateDBaaSGrafanaServiceRequest(
                maintenance: maintenance,
                plan: plan,
                terminationProtection: terminationProtection,
                grafanaSettings: grafanaSettings,
                ipFilter: ipFilter
            )
        )
        return try await http.put(path: "/dbaas-grafana/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS Grafana service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-grafana/\(name)", as: Exoscale.Operation.self)
    }

    /// Initiates maintenance for a DBaaS Grafana service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-grafana/\(name)/maintenance/start", as: Exoscale.Operation.self)
    }

    /// Resets a DBaaS Grafana user password.
    public func resetUserPassword(serviceName: String, username: String, password: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ResetDBaaSUserPasswordRequest(password: password))
        return try await http.put(
            path: "/dbaas-grafana/\(serviceName)/user/\(username)/password/reset",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Reveals DBaaS Grafana user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.Grafana.UserSecrets {
        try await http.get(
            path: "/dbaas-grafana/\(serviceName)/user/\(username)/password/reveal",
            as: Exoscale.DBaaS.Grafana.UserSecrets.self
        )
    }

    /// Retrieves DBaaS Grafana settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.Grafana.Settings {
        let response = try await http.get(path: "/dbaas-settings-grafana", as: GetDBaaSGrafanaSettingsResponse.self)
        return response.settings
    }
}

/// Access to DBaaS Kafka API operations.
public struct DBaaSKafkaResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves a DBaaS Kafka service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.Kafka.Service {
        try await http.get(path: "/dbaas-kafka/\(name)", as: Exoscale.DBaaS.Kafka.Service.self)
    }

    /// Creates a DBaaS Kafka service.
    public func create(
        name: String,
        plan: String,
        authenticationMethods: Exoscale.DBaaS.Kafka.AuthenticationMethods? = nil,
        kafkaRestEnabled: Bool? = nil,
        kafkaConnectEnabled: Bool? = nil,
        ipFilter: [String]? = nil,
        schemaRegistrySettings: [String: Exoscale.JSONValue]? = nil,
        kafkaRestSettings: [String: Exoscale.JSONValue]? = nil,
        terminationProtection: Bool? = nil,
        kafkaConnectSettings: [String: Exoscale.JSONValue]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        kafkaSettings: [String: Exoscale.JSONValue]? = nil,
        schemaRegistryEnabled: Bool? = nil,
        version: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            DBaaSKafkaServiceRequest(
                authenticationMethods: authenticationMethods,
                kafkaRestEnabled: kafkaRestEnabled,
                kafkaConnectEnabled: kafkaConnectEnabled,
                ipFilter: ipFilter,
                schemaRegistrySettings: schemaRegistrySettings,
                kafkaRestSettings: kafkaRestSettings,
                terminationProtection: terminationProtection,
                kafkaConnectSettings: kafkaConnectSettings,
                maintenance: maintenance,
                kafkaSettings: kafkaSettings,
                schemaRegistryEnabled: schemaRegistryEnabled,
                version: version,
                plan: plan
            )
        )
        return try await http.post(path: "/dbaas-kafka/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a DBaaS Kafka service.
    public func update(
        name: String,
        plan: String? = nil,
        authenticationMethods: Exoscale.DBaaS.Kafka.AuthenticationMethods? = nil,
        kafkaRestEnabled: Bool? = nil,
        kafkaConnectEnabled: Bool? = nil,
        ipFilter: [String]? = nil,
        schemaRegistrySettings: [String: Exoscale.JSONValue]? = nil,
        kafkaRestSettings: [String: Exoscale.JSONValue]? = nil,
        terminationProtection: Bool? = nil,
        kafkaConnectSettings: [String: Exoscale.JSONValue]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        kafkaSettings: [String: Exoscale.JSONValue]? = nil,
        schemaRegistryEnabled: Bool? = nil,
        version: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            DBaaSKafkaServiceRequest(
                authenticationMethods: authenticationMethods,
                kafkaRestEnabled: kafkaRestEnabled,
                kafkaConnectEnabled: kafkaConnectEnabled,
                ipFilter: ipFilter,
                schemaRegistrySettings: schemaRegistrySettings,
                kafkaRestSettings: kafkaRestSettings,
                terminationProtection: terminationProtection,
                kafkaConnectSettings: kafkaConnectSettings,
                maintenance: maintenance,
                kafkaSettings: kafkaSettings,
                schemaRegistryEnabled: schemaRegistryEnabled,
                version: version,
                plan: plan
            )
        )
        return try await http.put(path: "/dbaas-kafka/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS Kafka service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-kafka/\(name)", as: Exoscale.Operation.self)
    }

    /// Initiates maintenance for a DBaaS Kafka service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-kafka/\(name)/maintenance/start", as: Exoscale.Operation.self)
    }

    /// Creates a DBaaS Kafka user.
    public func createUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateDBaaSKafkaUserRequest(username: username))
        return try await http.post(path: "/dbaas-kafka/\(serviceName)/user", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS Kafka user.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-kafka/\(serviceName)/user/\(username)", as: Exoscale.Operation.self)
    }

    /// Resets a DBaaS Kafka user password.
    public func resetUserPassword(serviceName: String, username: String, password: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ResetDBaaSUserPasswordRequest(password: password))
        return try await http.put(
            path: "/dbaas-kafka/\(serviceName)/user/\(username)/password/reset",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Reveals DBaaS Kafka user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.Kafka.UserSecrets {
        try await http.get(
            path: "/dbaas-kafka/\(serviceName)/user/\(username)/password/reveal",
            as: Exoscale.DBaaS.Kafka.UserSecrets.self
        )
    }

    /// Reveals DBaaS Kafka Connect credentials.
    public func revealConnectPassword(serviceName: String) async throws -> Exoscale.DBaaS.Kafka.ConnectUserSecrets {
        try await http.get(
            path: "/dbaas-kafka/\(serviceName)/connect/password/reveal",
            as: Exoscale.DBaaS.Kafka.ConnectUserSecrets.self
        )
    }

    /// Retrieves DBaaS Kafka ACL configuration.
    public func aclConfig(name: String) async throws -> Exoscale.DBaaS.Kafka.ACLConfig {
        try await http.get(path: "/dbaas-kafka/\(name)/acl-config", as: Exoscale.DBaaS.Kafka.ACLConfig.self)
    }

    /// Adds a DBaaS Kafka topic ACL entry.
    public func createTopicACL(name: String, entry: Exoscale.DBaaS.Kafka.TopicACLEntry) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(entry)
        return try await http.post(path: "/dbaas-kafka/\(name)/topic/acl-config", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS Kafka topic ACL entry.
    public func deleteTopicACL(name: String, aclID: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-kafka/\(name)/topic/acl-config/\(aclID)", as: Exoscale.Operation.self)
    }

    /// Adds a DBaaS Kafka Schema Registry ACL entry.
    public func createSchemaRegistryACL(
        name: String,
        entry: Exoscale.DBaaS.Kafka.SchemaRegistryACLEntry
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(entry)
        return try await http.post(path: "/dbaas-kafka/\(name)/schema-registry/acl-config", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS Kafka Schema Registry ACL entry.
    public func deleteSchemaRegistryACL(name: String, aclID: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-kafka/\(name)/schema-registry/acl-config/\(aclID)", as: Exoscale.Operation.self)
    }

    /// Retrieves DBaaS Kafka settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.Kafka.Settings {
        let response = try await http.get(path: "/dbaas-settings-kafka", as: GetDBaaSKafkaSettingsResponse.self)
        return response.settings
    }
}

/// Access to DBaaS MySQL API operations.
public struct DBaaSMySQLResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves a DBaaS MySQL service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.MySQL.Service {
        try await http.get(path: "/dbaas-mysql/\(name)", as: Exoscale.DBaaS.MySQL.Service.self)
    }

    /// Creates a DBaaS MySQL service.
    public func create(
        name: String,
        plan: String,
        backupSchedule: Exoscale.DBaaS.BackupSchedule? = nil,
        integrations: [Exoscale.DBaaS.IntegrationInput]? = nil,
        ipFilter: [String]? = nil,
        terminationProtection: Bool? = nil,
        forkFromService: String? = nil,
        recoveryBackupTime: String? = nil,
        mysqlSettings: [String: Exoscale.JSONValue]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        adminUsername: String? = nil,
        version: String? = nil,
        adminPassword: String? = nil,
        migration: Exoscale.DBaaS.Migration? = nil,
        binlogRetentionPeriod: Int? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSMySQLServiceRequest(
                backupSchedule: backupSchedule,
                integrations: integrations,
                ipFilter: ipFilter,
                terminationProtection: terminationProtection,
                forkFromService: forkFromService,
                recoveryBackupTime: recoveryBackupTime,
                mysqlSettings: mysqlSettings,
                maintenance: maintenance,
                adminUsername: adminUsername,
                version: version,
                plan: plan,
                adminPassword: adminPassword,
                migration: migration,
                binlogRetentionPeriod: binlogRetentionPeriod
            )
        )
        return try await http.post(path: "/dbaas-mysql/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a DBaaS MySQL service.
    public func update(
        name: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        plan: String? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        mysqlSettings: [String: Exoscale.JSONValue]? = nil,
        migration: Exoscale.DBaaS.Migration? = nil,
        binlogRetentionPeriod: Int? = nil,
        backupSchedule: Exoscale.DBaaS.BackupSchedule? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateDBaaSMySQLServiceRequest(
                maintenance: maintenance,
                plan: plan,
                terminationProtection: terminationProtection,
                ipFilter: ipFilter,
                mysqlSettings: mysqlSettings,
                migration: migration,
                binlogRetentionPeriod: binlogRetentionPeriod,
                backupSchedule: backupSchedule
            )
        )
        return try await http.put(path: "/dbaas-mysql/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS MySQL service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-mysql/\(name)", as: Exoscale.Operation.self)
    }

    /// Initiates maintenance for a DBaaS MySQL service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-mysql/\(name)/maintenance/start", as: Exoscale.Operation.self)
    }

    /// Stops a DBaaS MySQL migration.
    public func stopMigration(name: String) async throws -> Exoscale.Operation {
        try await http.post(path: "/dbaas-mysql/\(name)/migration/stop", as: Exoscale.Operation.self)
    }

    /// Temporarily enables writes for a read-only DBaaS MySQL service.
    public func enableWrites(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-mysql/\(name)/enable/writes", as: Exoscale.Operation.self)
    }

    /// Creates a DBaaS MySQL database.
    public func createDatabase(serviceName: String, databaseName: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateDBaaSMySQLDatabaseRequest(databaseName: databaseName))
        return try await http.post(path: "/dbaas-mysql/\(serviceName)/database", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS MySQL database.
    public func deleteDatabase(serviceName: String, databaseName: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-mysql/\(serviceName)/database/\(databaseName)", as: Exoscale.Operation.self)
    }

    /// Creates a DBaaS MySQL user.
    public func createUser(
        serviceName: String,
        username: String,
        authentication: Exoscale.DBaaS.MySQL.AuthenticationPlugin? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateDBaaSMySQLUserRequest(username: username, authentication: authentication))
        return try await http.post(path: "/dbaas-mysql/\(serviceName)/user", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS MySQL user.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-mysql/\(serviceName)/user/\(username)", as: Exoscale.Operation.self)
    }

    /// Resets a DBaaS MySQL user password.
    public func resetUserPassword(
        serviceName: String,
        username: String,
        password: String? = nil,
        authentication: Exoscale.DBaaS.MySQL.AuthenticationPlugin? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            ResetDBaaSMySQLUserPasswordRequest(password: password, authentication: authentication)
        )
        return try await http.put(
            path: "/dbaas-mysql/\(serviceName)/user/\(username)/password/reset",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Reveals DBaaS MySQL user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.MySQL.UserSecrets {
        try await http.get(
            path: "/dbaas-mysql/\(serviceName)/user/\(username)/password/reveal",
            as: Exoscale.DBaaS.MySQL.UserSecrets.self
        )
    }

    /// Retrieves DBaaS MySQL settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.MySQL.Settings {
        let response = try await http.get(path: "/dbaas-settings-mysql", as: GetDBaaSMySQLSettingsResponse.self)
        return response.settings
    }
}

/// Access to DBaaS OpenSearch API operations.
public struct DBaaSOpenSearchResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves a DBaaS OpenSearch service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.OpenSearch.Service {
        try await http.get(path: "/dbaas-opensearch/\(name)", as: Exoscale.DBaaS.OpenSearch.Service.self)
    }

    /// Creates a DBaaS OpenSearch service.
    public func create(
        name: String,
        plan: String,
        maxIndexCount: Int? = nil,
        keepIndexRefreshInterval: Bool? = nil,
        ipFilter: [String]? = nil,
        terminationProtection: Bool? = nil,
        forkFromService: String? = nil,
        indexPatterns: [Exoscale.DBaaS.OpenSearch.IndexPattern]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        indexTemplate: Exoscale.DBaaS.OpenSearch.IndexTemplate? = nil,
        opensearchSettings: [String: Exoscale.JSONValue]? = nil,
        version: String? = nil,
        recoveryBackupName: String? = nil,
        opensearchDashboards: Exoscale.DBaaS.OpenSearch.Dashboards? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSOpenSearchServiceRequest(
                maxIndexCount: maxIndexCount,
                keepIndexRefreshInterval: keepIndexRefreshInterval,
                ipFilter: ipFilter,
                terminationProtection: terminationProtection,
                forkFromService: forkFromService,
                indexPatterns: indexPatterns,
                maintenance: maintenance,
                indexTemplate: indexTemplate,
                opensearchSettings: opensearchSettings,
                version: version,
                recoveryBackupName: recoveryBackupName,
                plan: plan,
                opensearchDashboards: opensearchDashboards
            )
        )
        return try await http.post(path: "/dbaas-opensearch/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a DBaaS OpenSearch service.
    public func update(
        name: String,
        plan: String? = nil,
        maxIndexCount: Int? = nil,
        keepIndexRefreshInterval: Bool? = nil,
        ipFilter: [String]? = nil,
        terminationProtection: Bool? = nil,
        indexPatterns: [Exoscale.DBaaS.OpenSearch.IndexPattern]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        indexTemplate: Exoscale.DBaaS.OpenSearch.IndexTemplate? = nil,
        opensearchSettings: [String: Exoscale.JSONValue]? = nil,
        version: String? = nil,
        opensearchDashboards: Exoscale.DBaaS.OpenSearch.Dashboards? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateDBaaSOpenSearchServiceRequest(
                maxIndexCount: maxIndexCount,
                keepIndexRefreshInterval: keepIndexRefreshInterval,
                ipFilter: ipFilter,
                terminationProtection: terminationProtection,
                indexPatterns: indexPatterns,
                maintenance: maintenance,
                indexTemplate: indexTemplate,
                opensearchSettings: opensearchSettings,
                version: version,
                plan: plan,
                opensearchDashboards: opensearchDashboards
            )
        )
        return try await http.put(path: "/dbaas-opensearch/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS OpenSearch service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-opensearch/\(name)", as: Exoscale.Operation.self)
    }

    /// Initiates maintenance for a DBaaS OpenSearch service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-opensearch/\(name)/maintenance/start", as: Exoscale.Operation.self)
    }

    /// Creates a DBaaS OpenSearch user.
    public func createUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateDBaaSOpenSearchUserRequest(username: username))
        return try await http.post(path: "/dbaas-opensearch/\(serviceName)/user", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS OpenSearch user.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-opensearch/\(serviceName)/user/\(username)", as: Exoscale.Operation.self)
    }

    /// Resets a DBaaS OpenSearch user password.
    public func resetUserPassword(serviceName: String, username: String, password: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ResetDBaaSUserPasswordRequest(password: password))
        return try await http.put(
            path: "/dbaas-opensearch/\(serviceName)/user/\(username)/password/reset",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Reveals DBaaS OpenSearch user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.OpenSearch.UserSecrets {
        try await http.get(
            path: "/dbaas-opensearch/\(serviceName)/user/\(username)/password/reveal",
            as: Exoscale.DBaaS.OpenSearch.UserSecrets.self
        )
    }

    /// Retrieves DBaaS OpenSearch ACL configuration.
    public func aclConfig(name: String) async throws -> Exoscale.DBaaS.OpenSearch.ACLConfig {
        try await http.get(path: "/dbaas-opensearch/\(name)/acl-config", as: Exoscale.DBaaS.OpenSearch.ACLConfig.self)
    }

    /// Updates DBaaS OpenSearch ACL configuration.
    public func updateACLConfig(name: String, config: Exoscale.DBaaS.OpenSearch.ACLConfig) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(config)
        return try await http.put(path: "/dbaas-opensearch/\(name)/acl-config", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves DBaaS OpenSearch settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.OpenSearch.Settings {
        let response = try await http.get(path: "/dbaas-settings-opensearch", as: GetDBaaSOpenSearchSettingsResponse.self)
        return response.settings
    }
}

/// Access to DBaaS Thanos API operations.
public struct DBaaSThanosResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves a DBaaS Thanos service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.Thanos.Service {
        try await http.get(path: "/dbaas-thanos/\(name)", as: Exoscale.DBaaS.Thanos.Service.self)
    }

    /// Creates a DBaaS Thanos service.
    public func create(
        name: String,
        plan: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        thanosSettings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSThanosServiceRequest(
                maintenance: maintenance,
                plan: plan,
                terminationProtection: terminationProtection,
                ipFilter: ipFilter,
                thanosSettings: thanosSettings
            )
        )
        return try await http.post(path: "/dbaas-thanos/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a DBaaS Thanos service.
    public func update(
        name: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        plan: String? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        thanosSettings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateDBaaSThanosServiceRequest(
                maintenance: maintenance,
                plan: plan,
                terminationProtection: terminationProtection,
                ipFilter: ipFilter,
                thanosSettings: thanosSettings
            )
        )
        return try await http.put(path: "/dbaas-thanos/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS Thanos service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-thanos/\(name)", as: Exoscale.Operation.self)
    }

    /// Initiates maintenance for a DBaaS Thanos service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-thanos/\(name)/maintenance/start", as: Exoscale.Operation.self)
    }

    /// Reveals DBaaS Thanos user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.Thanos.UserSecrets {
        try await http.get(
            path: "/dbaas-thanos/\(serviceName)/user/\(username)/password/reveal",
            as: Exoscale.DBaaS.Thanos.UserSecrets.self
        )
    }

    /// Retrieves DBaaS Thanos settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.Thanos.Settings {
        let response = try await http.get(path: "/dbaas-settings-thanos", as: GetDBaaSThanosSettingsResponse.self)
        return response.settings
    }
}

/// Access to DBaaS Valkey API operations.
public struct DBaaSValkeyResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves a DBaaS Valkey service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.Valkey.Service {
        try await http.get(path: "/dbaas-valkey/\(name)", as: Exoscale.DBaaS.Valkey.Service.self)
    }

    /// Creates a DBaaS Valkey service.
    public func create(
        name: String,
        plan: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        migration: Exoscale.DBaaS.Migration? = nil,
        valkeySettings: [String: Exoscale.JSONValue]? = nil,
        forkFromService: String? = nil,
        recoveryBackupName: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSValkeyServiceRequest(
                maintenance: maintenance,
                plan: plan,
                terminationProtection: terminationProtection,
                ipFilter: ipFilter,
                migration: migration,
                valkeySettings: valkeySettings,
                forkFromService: forkFromService,
                recoveryBackupName: recoveryBackupName
            )
        )
        return try await http.post(path: "/dbaas-valkey/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a DBaaS Valkey service.
    public func update(
        name: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        plan: String? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        migration: Exoscale.DBaaS.Migration? = nil,
        valkeySettings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateDBaaSValkeyServiceRequest(
                maintenance: maintenance,
                plan: plan,
                terminationProtection: terminationProtection,
                ipFilter: ipFilter,
                migration: migration,
                valkeySettings: valkeySettings
            )
        )
        return try await http.put(path: "/dbaas-valkey/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS Valkey service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-valkey/\(name)", as: Exoscale.Operation.self)
    }

    /// Initiates maintenance for a DBaaS Valkey service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-valkey/\(name)/maintenance/start", as: Exoscale.Operation.self)
    }

    /// Stops a DBaaS Valkey migration.
    public func stopMigration(name: String) async throws -> Exoscale.Operation {
        try await http.post(path: "/dbaas-valkey/\(name)/migration/stop", as: Exoscale.Operation.self)
    }

    /// Lists DBaaS Valkey users.
    public func listUsers(serviceName: String) async throws -> [Exoscale.DBaaS.Valkey.User] {
        let response = try await http.get(path: "/dbaas-valkey/\(serviceName)/user", as: DBaaSValkeyUsersResponse.self)
        return response.users
    }

    /// Creates a DBaaS Valkey user.
    public func createUser(
        serviceName: String,
        username: String,
        accessControl: Exoscale.DBaaS.Valkey.AccessControl? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateDBaaSValkeyUserRequest(username: username, accessControl: accessControl))
        return try await http.post(path: "/dbaas-valkey/\(serviceName)/user", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a DBaaS Valkey user.
    public func updateUser(
        serviceName: String,
        username: String,
        accessControl: Exoscale.DBaaS.Valkey.AccessControl? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpdateDBaaSValkeyUserRequest(accessControl: accessControl))
        return try await http.put(path: "/dbaas-valkey/\(serviceName)/user/\(username)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS Valkey user.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-valkey/\(serviceName)/user/\(username)", as: Exoscale.Operation.self)
    }

    /// Resets a DBaaS Valkey user password.
    public func resetUserPassword(serviceName: String, username: String, password: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ResetDBaaSUserPasswordRequest(password: password))
        return try await http.put(
            path: "/dbaas-valkey/\(serviceName)/user/\(username)/password/reset",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Reveals DBaaS Valkey user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.Valkey.UserSecrets {
        try await http.get(
            path: "/dbaas-valkey/\(serviceName)/user/\(username)/password/reveal",
            as: Exoscale.DBaaS.Valkey.UserSecrets.self
        )
    }

    /// Retrieves DBaaS Valkey settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.Valkey.Settings {
        let response = try await http.get(path: "/dbaas-settings-valkey", as: GetDBaaSValkeySettingsResponse.self)
        return response.settings
    }
}
