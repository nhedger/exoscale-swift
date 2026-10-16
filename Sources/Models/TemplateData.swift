import Foundation

extension Exoscale.Template {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let applicationConsistentSnapshotEnabled: Bool?
        let maintainer: String?
        let description: String?
        let sshKeyEnabled: Bool?
        let family: String?
        let name: String?
        let defaultUser: String?
        let size: Int?
        let passwordEnabled: Bool?
        let build: String?
        let checksum: String?
        let bootMode: BootMode?
        let id: String?
        let zones: [Exoscale.ZoneName]?
        let url: String?
        let version: String?
        let createdAt: Date?
        let visibility: Visibility?
    }
}

extension Exoscale.Template.Payload {
    enum CodingKeys: String, CodingKey {
        case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
        case maintainer
        case description
        case sshKeyEnabled = "ssh-key-enabled"
        case family
        case name
        case defaultUser = "default-user"
        case size
        case passwordEnabled = "password-enabled"
        case build
        case checksum
        case bootMode = "boot-mode"
        case id
        case zones
        case url
        case version
        case createdAt = "created-at"
        case visibility
    }
}
