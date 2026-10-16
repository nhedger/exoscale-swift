public extension Exoscale {
    /// Security Group returned by the API.
    struct SecurityGroup: Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let description: String?
        public let externalSources: [String]?
        public let rules: [Rule]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            description: String? = nil,
            externalSources: [String]? = nil,
            rules: [Rule]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.externalSources = externalSources
            self.rules = rules
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            name = data.name
            description = data.description
            externalSources = data.externalSources
            rules = data.rules
        }
    }
}

public extension Exoscale.SecurityGroup {
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

public extension Exoscale.SecurityGroup {
    struct Resource: Codable, Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let visibility: Visibility?

        public init(id: String? = nil, name: String? = nil, visibility: Visibility? = nil) {
            self.id = id
            self.name = name
            self.visibility = visibility
        }
    }
}

public extension Exoscale.SecurityGroup.Rule {
    struct ICMP: Codable, Hashable, Sendable {
        public let code: Int?
        public let type: Int?

        public init(code: Int? = nil, type: Int? = nil) {
            self.code = code
            self.type = type
        }
    }
}

public extension Exoscale.SecurityGroup.Rule {
    enum NetworkProtocol: Exoscale.ExtensibleEnum {
        case all
        case tcp
        case esp
        case icmp
        case udp
        case gre
        case ah
        case ipip
        case icmpv6
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.all, .tcp, .esp, .icmp, .udp, .gre, .ah, .ipip, .icmpv6]

        public var rawValue: String {
            switch self {
            case .all: "all"
            case .tcp: "tcp"
            case .esp: "esp"
            case .icmp: "icmp"
            case .udp: "udp"
            case .gre: "gre"
            case .ah: "ah"
            case .ipip: "ipip"
            case .icmpv6: "icmpv6"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.SecurityGroup.Rule {
    enum FlowDirection: Exoscale.ExtensibleEnum {
        case ingress
        case egress
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.ingress, .egress]

        public var rawValue: String {
            switch self {
            case .ingress: "ingress"
            case .egress: "egress"
            case let .unknown(value): value
            }
        }
    }
}

extension Exoscale.SecurityGroup.Rule {
    enum CodingKeys: String, CodingKey {
        case description
        case startPort = "start-port"
        case networkProtocol = "protocol"
        case icmp
        case endPort = "end-port"
        case securityGroup = "security-group"
        case id
        case network
        case flowDirection = "flow-direction"
    }
}

public extension Exoscale.SecurityGroup {
    struct Rule: Codable, Hashable, Sendable {
        public let description: String?
        public let startPort: Int?
        public let networkProtocol: NetworkProtocol?
        public let icmp: ICMP?
        public let endPort: Int?
        public let securityGroup: Resource?
        public let id: String?
        public let network: String?
        public let flowDirection: FlowDirection?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            startPort: Int? = nil,
            networkProtocol: NetworkProtocol? = nil,
            icmp: ICMP? = nil,
            endPort: Int? = nil,
            securityGroup: Resource? = nil,
            id: String? = nil,
            network: String? = nil,
            flowDirection: FlowDirection? = nil
        ) {
            self.description = description
            self.startPort = startPort
            self.networkProtocol = networkProtocol
            self.icmp = icmp
            self.endPort = endPort
            self.securityGroup = securityGroup
            self.id = id
            self.network = network
            self.flowDirection = flowDirection
        }
    }
}
