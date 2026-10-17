import Foundation

public extension Exoscale {
    /// A virtual private cloud: routed private networks for instances.
    struct VPC: Hashable, Codable, Sendable {
        /// The VPC's identifier.
        public let id: String
        /// The VPC's name.
        public let name: String?
        /// The VPC's description.
        public let description: String?
        /// Whether this is the zone's default VPC.
        public let isDefault: Bool?
        /// The DHCP options handed out in the VPC's subnets.
        public let dhcpOptions: DHCPOptions?
        /// The labels attached to the VPC.
        public let labels: [String: String]?
        /// When the VPC was created.
        public let createdAt: Date?

        /// Creates a VPC, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            isDefault: Bool? = nil,
            dhcpOptions: DHCPOptions? = nil,
            labels: [String: String]? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.isDefault = isDefault
            self.dhcpOptions = dhcpOptions
            self.labels = labels
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, labels
            case isDefault = "default"
            case dhcpOptions = "dhcp-options"
            case createdAt = "created-at"
        }

        /// The DHCP options handed out in a VPC's subnets.
        public struct DHCPOptions: Hashable, Codable, Sendable {
            /// DNS servers.
            public let dnsServers: [String]?
            /// NTP servers.
            public let ntpServers: [String]?
            /// DNS search domains.
            public let domainSearch: [String]?

            /// Creates DHCP options.
            public init(dnsServers: [String]? = nil, ntpServers: [String]? = nil, domainSearch: [String]? = nil) {
                self.dnsServers = dnsServers
                self.ntpServers = ntpServers
                self.domainSearch = domainSearch
            }

            enum CodingKeys: String, CodingKey {
                case dnsServers = "dns-servers"
                case ntpServers = "ntp-servers"
                case domainSearch = "domain-search"
            }
        }
    }

    /// A subnet of a VPC.
    struct Subnet: Hashable, Codable, Sendable {
        /// The subnet's identifier.
        public let id: String
        /// The subnet's name.
        public let name: String?
        /// The subnet's description.
        public let description: String?
        /// The subnet's IPv4 range, as a CIDR.
        public let ipv4Block: String?
        /// The IP versions the subnet carries.
        public let addressFamily: AddressFamily?
        /// Whether the addresses are private.
        public let addressSpace: AddressSpace?
        /// The instances attached to the subnet.
        public let instances: [Attachment]?
        /// The labels attached to the subnet.
        public let labels: [String: String]?
        /// When the subnet was created.
        public let createdAt: Date?

        /// Creates a subnet, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            ipv4Block: String? = nil,
            addressFamily: AddressFamily? = nil,
            addressSpace: AddressSpace? = nil,
            instances: [Attachment]? = nil,
            labels: [String: String]? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.ipv4Block = ipv4Block
            self.addressFamily = addressFamily
            self.addressSpace = addressSpace
            self.instances = instances
            self.labels = labels
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, instances, labels
            case ipv4Block = "ipv4-block"
            case addressFamily = "addressfamily"
            case addressSpace = "address-space"
            case createdAt = "created-at"
        }

        /// An instance attached to a subnet.
        public struct Attachment: Hashable, Codable, Sendable {
            /// The instance's identifier.
            public let id: String?
            /// The instance's name.
            public let name: String?
            /// The instance's address in the subnet.
            public let ipv4: String?

            /// Creates an attachment, for example for previews and tests.
            public init(id: String? = nil, name: String? = nil, ipv4: String? = nil) {
                self.id = id
                self.name = name
                self.ipv4 = ipv4
            }
        }

        /// Whether a subnet's addresses are private.
        public struct AddressSpace: RawRepresentable, Hashable, Codable, Sendable {
            /// The address space as the API names it.
            public let rawValue: String

            /// Creates an address space, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Private addresses.
            public static let `private` = AddressSpace(rawValue: "private")
        }
    }

    /// A route sending traffic for a destination through a target, in a VPC or one of its subnets.
    struct Route: Hashable, Codable, Sendable {
        /// The route's identifier.
        public let id: String
        /// Whether the route belongs to the VPC or to one of its subnets.
        public let kind: Kind?
        /// The route's description.
        public let description: String?
        /// The destination network, as a CIDR.
        public let destination: String?
        /// The address traffic for the destination is sent to.
        public let target: String?

        /// Creates a route, for example for previews and tests.
        public init(
            id: String,
            kind: Kind? = nil,
            description: String? = nil,
            destination: String? = nil,
            target: String? = nil
        ) {
            self.id = id
            self.kind = kind
            self.description = description
            self.destination = destination
            self.target = target
        }

        /// Whether a route belongs to a VPC or to a subnet.
        public struct Kind: RawRepresentable, Hashable, Codable, Sendable {
            /// The kind as the API names it.
            public let rawValue: String

            /// Creates a kind, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// A route of the whole VPC.
            public static let vpc = Kind(rawValue: "Vpc")
            /// A route of one subnet.
            public static let subnet = Kind(rawValue: "Subnet")
        }
    }
}
