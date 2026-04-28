/// Request body for importing an SSH key.
struct ImportSSHKeyRequest: Codable, Sendable {
    let name: String
    let publicKey: String

    init(name: String, publicKey: String) {
        self.name = name
        self.publicKey = publicKey
    }

    enum CodingKeys: String, CodingKey {
        case name
        case publicKey = "public-key"
    }
}
