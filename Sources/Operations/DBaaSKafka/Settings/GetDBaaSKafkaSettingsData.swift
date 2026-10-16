import Foundation

/// Response for retrieving DBaaS Kafka settings.
struct GetDBaaSKafkaSettingsData: Decodable, Sendable {
    let settings: Exoscale.DBaaS.Kafka.Settings.Payload
}
