/// Response for retrieving DBaaS Grafana settings.
public struct GetDBaaSGrafanaSettingsResponse: Codable, Sendable {
    public let settings: Exoscale.DBaaS.Grafana.Settings
}

/// Response for retrieving DBaaS Kafka settings.
public struct GetDBaaSKafkaSettingsResponse: Codable, Sendable {
    public let settings: Exoscale.DBaaS.Kafka.Settings
}

/// Response for retrieving DBaaS MySQL settings.
public struct GetDBaaSMySQLSettingsResponse: Codable, Sendable {
    public let settings: Exoscale.DBaaS.MySQL.Settings
}

/// Response for retrieving DBaaS OpenSearch settings.
public struct GetDBaaSOpenSearchSettingsResponse: Codable, Sendable {
    public let settings: Exoscale.DBaaS.OpenSearch.Settings
}

/// Response for retrieving DBaaS Thanos settings.
public struct GetDBaaSThanosSettingsResponse: Codable, Sendable {
    public let settings: Exoscale.DBaaS.Thanos.Settings
}

/// Response for retrieving DBaaS Valkey settings.
public struct GetDBaaSValkeySettingsResponse: Codable, Sendable {
    public let settings: Exoscale.DBaaS.Valkey.Settings
}

/// Response for listing DBaaS Valkey users.
public struct DBaaSValkeyUsersResponse: Codable, Sendable {
    public let users: [Exoscale.DBaaS.Valkey.User]
}
