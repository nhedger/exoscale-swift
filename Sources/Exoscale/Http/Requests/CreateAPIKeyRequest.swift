/// Request body for creating an IAM API key.
struct CreateAPIKeyRequest: Codable, Sendable {
    let roleID: String
    let name: String

    init(roleID: String, name: String) {
        self.roleID = roleID
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case roleID = "role-id"
        case name
    }
}
