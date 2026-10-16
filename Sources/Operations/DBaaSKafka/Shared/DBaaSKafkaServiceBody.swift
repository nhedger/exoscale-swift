import Foundation

/// Request body for creating or updating a DBaaS Kafka service.
struct DBaaSKafkaServiceBody: Encodable, Sendable {
    let authenticationMethods: Exoscale.DBaaS.Kafka.AuthenticationMethods?
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
