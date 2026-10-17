import Foundation

public extension Exoscale {
    /// A disk image instances are created from.
    struct Template: Hashable, Codable, Sendable {
        /// The template's identifier.
        public let id: String
        /// The template's name.
        public let name: String?
        /// The template's description.
        public let description: String?
        /// The operating system family, such as `ubuntu`.
        public let family: String?
        /// Whether Exoscale provides the template or the organization registered it.
        public let visibility: Visibility?
        /// The template's version.
        public let version: String?
        /// The template's build.
        public let build: String?
        /// Who maintains the template.
        public let maintainer: String?
        /// The template's size.
        public let size: Int?
        /// The firmware the template boots with.
        public let bootMode: BootMode?
        /// The user to log in as.
        public let defaultUser: String?
        /// Whether SSH keys are installed on instances created from the template.
        public let sshKeyEnabled: Bool?
        /// Whether a password is generated for instances created from the template.
        public let passwordEnabled: Bool?
        /// Whether snapshots ask the guest to flush its file systems first.
        public let applicationConsistentSnapshotEnabled: Bool?
        /// Where the image was registered from.
        public let url: String?
        /// The image's MD5 checksum.
        public let checksum: String?
        /// When the template was created.
        public let createdAt: Date?

        /// Creates a template, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            family: String? = nil,
            visibility: Visibility? = nil,
            version: String? = nil,
            build: String? = nil,
            maintainer: String? = nil,
            size: Int? = nil,
            bootMode: BootMode? = nil,
            defaultUser: String? = nil,
            sshKeyEnabled: Bool? = nil,
            passwordEnabled: Bool? = nil,
            applicationConsistentSnapshotEnabled: Bool? = nil,
            url: String? = nil,
            checksum: String? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.family = family
            self.visibility = visibility
            self.version = version
            self.build = build
            self.maintainer = maintainer
            self.size = size
            self.bootMode = bootMode
            self.defaultUser = defaultUser
            self.sshKeyEnabled = sshKeyEnabled
            self.passwordEnabled = passwordEnabled
            self.applicationConsistentSnapshotEnabled = applicationConsistentSnapshotEnabled
            self.url = url
            self.checksum = checksum
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, family, visibility, version, build, maintainer, size, url, checksum
            case bootMode = "boot-mode"
            case defaultUser = "default-user"
            case sshKeyEnabled = "ssh-key-enabled"
            case passwordEnabled = "password-enabled"
            case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
            case createdAt = "created-at"
        }
    }
}

public extension Exoscale.Template {
    /// Who provides a template.
    struct Visibility: RawRepresentable, Hashable, Codable, Sendable {
        /// The visibility as the API names it.
        public let rawValue: String

        /// Creates a visibility, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Provided by Exoscale.
        public static let `public` = Visibility(rawValue: "public")
        /// Registered by the organization.
        public static let `private` = Visibility(rawValue: "private")
    }

    /// The firmware a template boots with.
    struct BootMode: RawRepresentable, Hashable, Codable, Sendable {
        /// The boot mode as the API names it.
        public let rawValue: String

        /// Creates a boot mode, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// BIOS.
        public static let legacy = BootMode(rawValue: "legacy")
        /// UEFI.
        public static let uefi = BootMode(rawValue: "uefi")
    }
}
