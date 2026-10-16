import Foundation

extension Exoscale.DBaaS.Kafka.ACLConfig {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let topicACL: [Exoscale.DBaaS.Kafka.TopicACLEntry]?
        let schemaRegistryACL: [Exoscale.DBaaS.Kafka.SchemaRegistryACLEntry]?
    }
}

extension Exoscale.DBaaS.Kafka.ACLConfig.Payload {
    enum CodingKeys: String, CodingKey {
        case topicACL = "topic-acl"
        case schemaRegistryACL = "schema-registry-acl"
    }
}
