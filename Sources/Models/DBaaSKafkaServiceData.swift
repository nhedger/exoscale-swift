import Foundation

extension Exoscale.DBaaS.Kafka.Service {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let updatedAt: Date?
        let authenticationMethods: Exoscale.DBaaS.Kafka.AuthenticationMethods?
        let nodeCount: Int?
        let connectionInfo: ConnectionInfo?
        let nodeCPUCount: Int?
        let kafkaRestEnabled: Bool?
        let prometheusURI: Exoscale.DBaaS.PrometheusURI.Payload?
        let integrations: [Exoscale.DBaaS.Integration.Payload]?
        let zone: String?
        let nodeStates: [Exoscale.DBaaS.NodeState.Payload]?
        let name: String?
        let kafkaConnectEnabled: Bool?
        let type: String?
        let state: String?
        let ipFilter: [String]?
        let schemaRegistrySettings: [String: Exoscale.JSONValue]?
        let backups: [Exoscale.DBaaS.Backup.Payload]?
        let kafkaRestSettings: [String: Exoscale.JSONValue]?
        let terminationProtection: Bool?
        let notifications: [Exoscale.DBaaS.Notification.Payload]?
        let kafkaConnectSettings: [String: Exoscale.JSONValue]?
        let components: [Exoscale.DBaaS.Component.Payload]?
        let maintenance: Exoscale.DBaaS.Maintenance?
        let kafkaSettings: [String: Exoscale.JSONValue]?
        let diskSize: Int?
        let nodeMemory: Int?
        let uri: String?
        let uriParams: [String: Exoscale.JSONValue]?
        let schemaRegistryEnabled: Bool?
        let version: String?
        let createdAt: Date?
        let plan: String?
        let users: [User]?
    }
}

extension Exoscale.DBaaS.Kafka.Service.Payload {
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated-at"
        case authenticationMethods = "authentication-methods"
        case nodeCount = "node-count"
        case connectionInfo = "connection-info"
        case nodeCPUCount = "node-cpu-count"
        case kafkaRestEnabled = "kafka-rest-enabled"
        case prometheusURI = "prometheus-uri"
        case integrations
        case zone
        case nodeStates = "node-states"
        case name
        case kafkaConnectEnabled = "kafka-connect-enabled"
        case type
        case state
        case ipFilter = "ip-filter"
        case schemaRegistrySettings = "schema-registry-settings"
        case backups
        case kafkaRestSettings = "kafka-rest-settings"
        case terminationProtection = "termination-protection"
        case notifications
        case kafkaConnectSettings = "kafka-connect-settings"
        case components
        case maintenance
        case kafkaSettings = "kafka-settings"
        case diskSize = "disk-size"
        case nodeMemory = "node-memory"
        case uri
        case uriParams = "uri-params"
        case schemaRegistryEnabled = "schema-registry-enabled"
        case version
        case createdAt = "created-at"
        case plan
        case users
    }
}
