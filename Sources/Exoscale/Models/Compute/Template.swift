public extension Exoscale {
    /// Instance template returned by the API.
    struct Template: Codable, Sendable {
        public enum BootMode: String, Codable, Sendable {
            case legacy
            case uefi
        }

        public enum Visibility: String, Codable, Sendable {
            case `private`
            case `public`
        }

        public let applicationConsistentSnapshotEnabled: Bool?
        public let maintainer: String?
        public let description: String?
        public let sshKeyEnabled: Bool?
        public let family: String?
        public let name: String?
        public let defaultUser: String?
        public let size: Int?
        public let passwordEnabled: Bool?
        public let build: String?
        public let checksum: String?
        public let bootMode: BootMode?
        public let id: String?
        public let zones: [Exoscale.KnownZone]?
        public let url: String?
        public let version: String?
        public let createdAt: String?
        public let visibility: Visibility?

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
}
