import Foundation

public extension Exoscale {
    /// Instance template returned by the API.
    struct Template: Hashable, Sendable {
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
        public let zones: [Exoscale.ZoneName]?
        public let url: String?
        public let version: String?
        public let createdAt: Date?
        public let visibility: Visibility?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            applicationConsistentSnapshotEnabled: Bool? = nil,
            maintainer: String? = nil,
            description: String? = nil,
            sshKeyEnabled: Bool? = nil,
            family: String? = nil,
            name: String? = nil,
            defaultUser: String? = nil,
            size: Int? = nil,
            passwordEnabled: Bool? = nil,
            build: String? = nil,
            checksum: String? = nil,
            bootMode: BootMode? = nil,
            id: String? = nil,
            zones: [Exoscale.ZoneName]? = nil,
            url: String? = nil,
            version: String? = nil,
            createdAt: Date? = nil,
            visibility: Visibility? = nil
        ) {
            self.applicationConsistentSnapshotEnabled = applicationConsistentSnapshotEnabled
            self.maintainer = maintainer
            self.description = description
            self.sshKeyEnabled = sshKeyEnabled
            self.family = family
            self.name = name
            self.defaultUser = defaultUser
            self.size = size
            self.passwordEnabled = passwordEnabled
            self.build = build
            self.checksum = checksum
            self.bootMode = bootMode
            self.id = id
            self.zones = zones
            self.url = url
            self.version = version
            self.createdAt = createdAt
            self.visibility = visibility
        }

        init(data: Payload, client _: Http.Client) {
            applicationConsistentSnapshotEnabled = data.applicationConsistentSnapshotEnabled
            maintainer = data.maintainer
            description = data.description
            sshKeyEnabled = data.sshKeyEnabled
            family = data.family
            name = data.name
            defaultUser = data.defaultUser
            size = data.size
            passwordEnabled = data.passwordEnabled
            build = data.build
            checksum = data.checksum
            bootMode = data.bootMode
            id = data.id
            zones = data.zones
            url = data.url
            version = data.version
            createdAt = data.createdAt
            visibility = data.visibility
        }
    }
}

public extension Exoscale.Template {
    enum BootMode: Exoscale.ExtensibleEnum {
        case legacy
        case uefi
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.legacy, .uefi]

        public var rawValue: String {
            switch self {
            case .legacy: "legacy"
            case .uefi: "uefi"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.Template {
    enum Visibility: Exoscale.ExtensibleEnum {
        case `private`
        case `public`
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.private, .public]

        public var rawValue: String {
            switch self {
            case .private: "private"
            case .public: "public"
            case let .unknown(value): value
            }
        }
    }
}
