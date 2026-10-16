import Foundation

/// Request body for creating a DBaaS Kafka user.
struct CreateDBaaSKafkaUserBody: Encodable, Sendable {
    let username: String
}
