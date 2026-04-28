public extension Exoscale {
    /// Security Group returned by the API.
    struct SecurityGroup: Codable, Sendable {
        public enum Visibility: String, Codable, Sendable {
            case `private`
            case `public`
        }

        public struct Resource: Codable, Sendable {
            public let id: String?
            public let name: String?
            public let visibility: Visibility?

            public init(id: String? = nil, name: String? = nil, visibility: Visibility? = nil) {
                self.id = id
                self.name = name
                self.visibility = visibility
            }
        }

        public struct Rule: Codable, Sendable {
            public struct ICMP: Codable, Sendable {
                public let code: Int?
                public let type: Int?

                public init(code: Int? = nil, type: Int? = nil) {
                    self.code = code
                    self.type = type
                }
            }

            public enum NetworkProtocol: String, Codable, Sendable {
                case tcp
                case esp
                case icmp
                case udp
                case gre
                case ah
                case ipip
                case icmpv6
            }

            public enum FlowDirection: String, Codable, Sendable {
                case ingress
                case egress
            }

            public let description: String?
            public let startPort: Int?
            public let networkProtocol: NetworkProtocol?
            public let icmp: ICMP?
            public let endPort: Int?
            public let securityGroup: Resource?
            public let id: String?
            public let network: String?
            public let flowDirection: FlowDirection?

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

        public let id: String?
        public let name: String?
        public let description: String?
        public let externalSources: [String]?
        public let rules: [Rule]?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case externalSources = "external-sources"
            case rules
        }
    }
}
