import Foundation

/// Request body for promoting a snapshot to a template.
struct PromoteSnapshotBody: Encodable, Sendable {
    let name: String
    let description: String?
    let defaultUser: String?
    let sshKeyEnabled: Bool?
    let passwordEnabled: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case defaultUser = "default-user"
        case sshKeyEnabled = "ssh-key-enabled"
        case passwordEnabled = "password-enabled"
    }
}
