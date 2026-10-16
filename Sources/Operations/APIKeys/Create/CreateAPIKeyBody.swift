import Foundation

/// Request body for creating an IAM API key.
struct CreateAPIKeyBody: Encodable, Sendable {
    let roleID: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case roleID = "role-id"
        case name
    }
}
