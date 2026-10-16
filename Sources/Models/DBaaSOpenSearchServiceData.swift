import Foundation

extension Exoscale.DBaaS.OpenSearch.Service {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let description: String?
        let maxIndexCount: Int?
        let updatedAt: Date?
        let nodeCount: Int?
        let connectionInfo: ConnectionInfo?
        let nodeCPUCount: Int?
        let prometheusURI: Exoscale.DBaaS.PrometheusURI.Payload?
        let integrations: [Exoscale.DBaaS.Integration.Payload]?
        let zone: String?
        let nodeStates: [Exoscale.DBaaS.NodeState.Payload]?
        let name: String?
        let keepIndexRefreshInterval: Bool?
        let type: String?
        let state: String?
        let ipFilter: [String]?
        let backups: [Exoscale.DBaaS.Backup.Payload]?
        let terminationProtection: Bool?
        let notifications: [Exoscale.DBaaS.Notification.Payload]?
        let components: [Exoscale.DBaaS.Component.Payload]?
        let indexPatterns: [Exoscale.DBaaS.OpenSearch.IndexPattern]?
        let maintenance: Exoscale.DBaaS.Maintenance?
        let indexTemplate: Exoscale.DBaaS.OpenSearch.IndexTemplate?
        let diskSize: Int?
        let nodeMemory: Int?
        let uri: String?
        let opensearchSettings: [String: Exoscale.JSONValue]?
        let uriParams: [String: Exoscale.JSONValue]?
        let version: String?
        let createdAt: Date?
        let plan: String?
        let opensearchDashboards: Exoscale.DBaaS.OpenSearch.Dashboards?
        let users: [User]?
    }
}

extension Exoscale.DBaaS.OpenSearch.Service.Payload {
    enum CodingKeys: String, CodingKey {
        case description
        case maxIndexCount = "max-index-count"
        case updatedAt = "updated-at"
        case nodeCount = "node-count"
        case connectionInfo = "connection-info"
        case nodeCPUCount = "node-cpu-count"
        case prometheusURI = "prometheus-uri"
        case integrations
        case zone
        case nodeStates = "node-states"
        case name
        case keepIndexRefreshInterval = "keep-index-refresh-interval"
        case type
        case state
        case ipFilter = "ip-filter"
        case backups
        case terminationProtection = "termination-protection"
        case notifications
        case components
        case indexPatterns = "index-patterns"
        case maintenance
        case indexTemplate = "index-template"
        case diskSize = "disk-size"
        case nodeMemory = "node-memory"
        case uri
        case opensearchSettings = "opensearch-settings"
        case uriParams = "uri-params"
        case version
        case createdAt = "created-at"
        case plan
        case opensearchDashboards = "opensearch-dashboards"
        case users
    }
}
