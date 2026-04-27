/// Response for updating DBaaS PostgreSQL users.
public struct DBaaSPostgreSQLUsersResponse: Codable, Sendable {
    public let users: [Exoscale.DBaaS.PostgreSQL.User]
}

/// Response for retrieving DBaaS PostgreSQL settings.
public struct GetDBaaSPostgreSQLSettingsResponse: Codable, Sendable {
    public let settings: Exoscale.DBaaS.PostgreSQL.Settings
}
