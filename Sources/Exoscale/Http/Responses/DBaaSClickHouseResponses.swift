struct ListDBaaSClickHouseUsersResponse: Decodable, Sendable {
    let users: [Exoscale.DBaaS.ClickHouse.User]
}

struct ListDBaaSClickHouseRolesResponse: Decodable, Sendable {
    let roles: [Exoscale.DBaaS.ClickHouse.Role]
}

struct GetDBaaSClickHouseSettingsResponse: Decodable, Sendable {
    let settings: Exoscale.DBaaS.ClickHouse.Settings
}
