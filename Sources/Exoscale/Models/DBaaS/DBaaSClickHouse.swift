import Foundation

public extension Exoscale.DBaaS {
    /// ClickHouse database service types (beta).
    enum ClickHouse {}
}

public extension Exoscale.DBaaS.ClickHouse {
    struct Service: Codable, Sendable {
        public struct ConnectionInfo: Codable, Sendable {
            public let uri: [String]?
            public let mysqlURI: String?
            public let arrowflightURI: String?

            enum CodingKeys: String, CodingKey {
                case uri
                case mysqlURI = "mysql-uri"
                case arrowflightURI = "arrowflight-uri"
            }
        }

        public let updatedAt: Date?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let nodeCPUCount: Int?
        public let prometheusURI: Exoscale.DBaaS.PrometheusURI?
        public let integrations: [Exoscale.DBaaS.Integration]?
        public let zone: String?
        public let nodeStates: [Exoscale.DBaaS.NodeState]?
        public let name: String?
        public let type: String?
        public let state: String?
        public let ipFilter: [String]?
        public let backups: [Exoscale.DBaaS.Backup]?
        public let terminationProtection: Bool?
        public let clickhouseSettings: [String: Exoscale.JSONValue]?
        public let notifications: [Exoscale.DBaaS.Notification]?
        public let components: [Exoscale.DBaaS.Component]?
        public let maintenance: Exoscale.DBaaS.Maintenance?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let version: String?
        public let createdAt: Date?
        public let plan: String?
        public let users: [User]?

        enum CodingKeys: String, CodingKey {
            case integrations, zone, name, type, state, backups, notifications, components, maintenance, uri, version, plan, users
            case updatedAt = "updated-at"
            case nodeCount = "node-count"
            case connectionInfo = "connection-info"
            case nodeCPUCount = "node-cpu-count"
            case prometheusURI = "prometheus-uri"
            case nodeStates = "node-states"
            case ipFilter = "ip-filter"
            case terminationProtection = "termination-protection"
            case clickhouseSettings = "clickhouse-settings"
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case uriParams = "uri-params"
            case createdAt = "created-at"
        }
    }

    struct User: Codable, Sendable {
        public let username: String
        public let uuid: String?
        public let required: Bool?
    }

    struct UserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
    }

    struct RoleReference: Codable, Sendable {
        public let uuid: String

        public init(uuid: String) {
            self.uuid = uuid
        }
    }

    struct Role: Codable, Sendable {
        public let name: String
        public let uuid: String?
        public let privileges: [[String: Exoscale.JSONValue]]?
        public let grantedRoles: [[String: Exoscale.JSONValue]]?

        enum CodingKeys: String, CodingKey {
            case name, uuid, privileges
            case grantedRoles = "granted-roles"
        }
    }

    struct UserACL: Codable, Sendable {
        public let username: String
        public let uuid: String?
        public let roles: [[String: Exoscale.JSONValue]]?
        public let privileges: [[String: Exoscale.JSONValue]]?
    }

    struct ACLConfig: Codable, Sendable {
        public let users: [UserACL]?
    }

    struct Settings: Codable, Sendable {
        public let clickhouse: Exoscale.DBaaS.SettingsSchema?
    }
}
