/// Request body for creating a DNS domain.
struct CreateDomainRequest: Codable, Sendable {
    let unicodeName: String

    init(unicodeName: String) {
        self.unicodeName = unicodeName
    }

    enum CodingKeys: String, CodingKey {
        case unicodeName = "unicode-name"
    }
}
