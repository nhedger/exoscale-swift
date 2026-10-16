import Foundation

extension Exoscale.DBaaS.ClickHouse.Service {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let updatedAt: Date?
        let nodeCount: Int?
        let connectionInfo: ConnectionInfo?
        let nodeCPUCount: Int?
        let prometheusURI: Exoscale.DBaaS.PrometheusURI.Payload?
        let integrations: [Exoscale.DBaaS.Integration.Payload]?
        let zone: String?
        let nodeStates: [Exoscale.DBaaS.NodeState.Payload]?
        let name: String?
        let type: String?
        let state: String?
        let ipFilter: [String]?
        let backups: [Exoscale.DBaaS.Backup.Payload]?
        let terminationProtection: Bool?
        let clickhouseSettings: [String: Exoscale.JSONValue]?
        let notifications: [Exoscale.DBaaS.Notification.Payload]?
        let components: [Exoscale.DBaaS.Component.Payload]?
        let maintenance: Exoscale.DBaaS.Maintenance?
        let diskSize: Int?
        let nodeMemory: Int?
        let uri: String?
        let uriParams: [String: Exoscale.JSONValue]?
        let version: String?
        let createdAt: Date?
        let plan: String?
        let users: [Exoscale.DBaaS.ClickHouse.User.Payload]?
    }
}

extension Exoscale.DBaaS.ClickHouse.Service.Payload {
    enum CodingKeys: String, CodingKey {
        case integrations, zone, name, type, state, backups, notifications, components, maintenance, uri, version,
             plan, users
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
