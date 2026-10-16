import Foundation

extension Exoscale.DBaaS.Kafka.Settings {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let kafka: Exoscale.DBaaS.SettingsSchema.Payload?
        let kafkaConnect: Exoscale.DBaaS.SettingsSchema.Payload?
        let kafkaRest: Exoscale.DBaaS.SettingsSchema.Payload?
        let schemaRegistry: Exoscale.DBaaS.SettingsSchema.Payload?
    }
}

extension Exoscale.DBaaS.Kafka.Settings.Payload {
    enum CodingKeys: String, CodingKey {
        case kafka
        case kafkaConnect = "kafka-connect"
        case kafkaRest = "kafka-rest"
        case schemaRegistry = "schema-registry"
    }
}
