import Foundation

/// Request body for importing an SSH key.
struct ImportSSHKeyBody: Encodable, Sendable {
    let name: String
    let publicKey: String

    enum CodingKeys: String, CodingKey {
        case name
        case publicKey = "public-key"
    }
}
