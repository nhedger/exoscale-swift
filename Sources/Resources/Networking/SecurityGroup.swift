public extension Exoscale {
    /// A set of firewall rules applied to the instances in it.
    struct SecurityGroup: Hashable, Codable, Sendable {
        /// The group's identifier. Public groups, which Exoscale provides, have none.
        public let id: String?
        /// The group's name.
        public let name: String?
        /// The group's description.
        public let description: String?
        /// The rules, which allow traffic the group would otherwise block.
        public let rules: [Rule]?
        /// Networks, as CIDRs, treated as members of the group by other groups' rules.
        public let externalSources: [String]?

        /// Creates a security group, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            description: String? = nil,
            rules: [Rule]? = nil,
            externalSources: [String]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.rules = rules
            self.externalSources = externalSources
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, rules
            case externalSources = "external-sources"
        }
    }
}

public extension Exoscale.SecurityGroup {
    /// A rule allowing traffic in or out of a security group.
    struct Rule: Hashable, Codable, Sendable {
        /// The rule's identifier.
        public let id: String?
        /// The rule's description.
        public let description: String?
        /// Whether the rule allows incoming or outgoing traffic.
        public let flowDirection: FlowDirection?
        /// The protocol the rule allows.
        public let `protocol`: NetworkProtocol?
        /// The first port of the allowed range, for TCP and UDP.
        public let startPort: Int?
        /// The last port of the allowed range, for TCP and UDP.
        public let endPort: Int?
        /// The allowed ICMP type and code, for ICMP and ICMPv6.
        public let icmp: ICMP?
        /// The network the traffic comes from or goes to, as a CIDR.
        public let network: String?
        /// The security group whose members the traffic comes from or goes to.
        public let securityGroup: Peer?

        /// Creates a rule, for example for previews and tests.
        public init(
            id: String? = nil,
            description: String? = nil,
            flowDirection: FlowDirection? = nil,
            protocol: NetworkProtocol? = nil,
            startPort: Int? = nil,
            endPort: Int? = nil,
            icmp: ICMP? = nil,
            network: String? = nil,
            securityGroup: Peer? = nil
        ) {
            self.id = id
            self.description = description
            self.flowDirection = flowDirection
            self.protocol = `protocol`
            self.startPort = startPort
            self.endPort = endPort
            self.icmp = icmp
            self.network = network
            self.securityGroup = securityGroup
        }

        enum CodingKeys: String, CodingKey {
            case id, description, `protocol`, icmp, network
            case flowDirection = "flow-direction"
            case startPort = "start-port"
            case endPort = "end-port"
            case securityGroup = "security-group"
        }
    }

    /// The security group whose members a rule allows traffic from or to.
    struct Peer: Hashable, Codable, Sendable {
        /// The group's identifier.
        public let id: String?
        /// The group's name.
        public let name: String?
        /// Whether the group belongs to the organization or is a public one provided by Exoscale.
        public let visibility: Visibility?

        /// Creates a peer, either by identifier or by name and visibility.
        public init(id: String? = nil, name: String? = nil, visibility: Visibility? = nil) {
            self.id = id
            self.name = name
            self.visibility = visibility
        }
    }

    /// An ICMP type and code.
    struct ICMP: Hashable, Codable, Sendable {
        /// The ICMP type, or `nil` for any.
        public let type: Int?
        /// The ICMP code, or `nil` for any.
        public let code: Int?

        /// Creates an ICMP type and code.
        public init(type: Int? = nil, code: Int? = nil) {
            self.type = type
            self.code = code
        }
    }

    /// Whether a rule applies to incoming or outgoing traffic.
    struct FlowDirection: RawRepresentable, Hashable, Codable, Sendable {
        /// The direction as the API names it.
        public let rawValue: String

        /// Creates a direction, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Incoming traffic.
        public static let ingress = FlowDirection(rawValue: "ingress")
        /// Outgoing traffic.
        public static let egress = FlowDirection(rawValue: "egress")
    }

    /// A network protocol a rule can allow.
    struct NetworkProtocol: RawRepresentable, Hashable, Codable, Sendable {
        /// The protocol as the API names it.
        public let rawValue: String

        /// Creates a protocol, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// TCP.
        public static let tcp = NetworkProtocol(rawValue: "tcp")
        /// UDP.
        public static let udp = NetworkProtocol(rawValue: "udp")
        /// ICMP.
        public static let icmp = NetworkProtocol(rawValue: "icmp")
        /// ICMPv6.
        public static let icmpv6 = NetworkProtocol(rawValue: "icmpv6")
        /// IPsec Encapsulating Security Payload.
        public static let esp = NetworkProtocol(rawValue: "esp")
        /// IPsec Authentication Header.
        public static let ah = NetworkProtocol(rawValue: "ah")
        /// Generic Routing Encapsulation.
        public static let gre = NetworkProtocol(rawValue: "gre")
        /// IP in IP.
        public static let ipip = NetworkProtocol(rawValue: "ipip")
        /// Every protocol.
        public static let all = NetworkProtocol(rawValue: "all")
    }

    /// Whether a security group belongs to the organization or is provided by Exoscale.
    struct Visibility: RawRepresentable, Hashable, Codable, Sendable {
        /// The visibility as the API names it.
        public let rawValue: String

        /// Creates a visibility, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The organization's own groups.
        public static let `private` = Visibility(rawValue: "private")
        /// Public groups provided by Exoscale, such as one per cloud provider's address ranges.
        public static let `public` = Visibility(rawValue: "public")
    }
}
