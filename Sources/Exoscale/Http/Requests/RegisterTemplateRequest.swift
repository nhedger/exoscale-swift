/// Request body for registering a template.
struct RegisterTemplateRequest: Codable, Sendable {
    let applicationConsistentSnapshotEnabled: Bool?
    let maintainer: String?
    let description: String?
    let sshKeyEnabled: Bool
    let name: String
    let defaultUser: String?
    let size: Int?
    let passwordEnabled: Bool
    let build: String?
    let checksum: String
    let bootMode: Exoscale.Template.BootMode?
    let url: String
    let version: String?

    enum CodingKeys: String, CodingKey {
        case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
        case maintainer
        case description
        case sshKeyEnabled = "ssh-key-enabled"
        case name
        case defaultUser = "default-user"
        case size
        case passwordEnabled = "password-enabled"
        case build
        case checksum
        case bootMode = "boot-mode"
        case url
        case version
    }
}
