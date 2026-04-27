public extension Exoscale {
    /// Private Network returned by the API.
    struct PrivateNetwork: Codable, Sendable {
        public struct Lease: Codable, Sendable {
            public let ip: String?
            public let instanceID: String?

            enum CodingKeys: String, CodingKey {
                case ip
                case instanceID = "instance-id"
            }
        }

        public struct Options: Codable, Sendable {
            public let routers: [String]?
            public let dnsServers: [String]?
            public let ntpServers: [String]?
            public let domainSearch: [String]?

            public init(
                routers: [String]? = nil,
                dnsServers: [String]? = nil,
                ntpServers: [String]? = nil,
                domainSearch: [String]? = nil
            ) {
                self.routers = routers
                self.dnsServers = dnsServers
                self.ntpServers = ntpServers
                self.domainSearch = domainSearch
            }

            enum CodingKeys: String, CodingKey {
                case routers
                case dnsServers = "dns-servers"
                case ntpServers = "ntp-servers"
                case domainSearch = "domain-search"
            }
        }

        public let description: String?
        public let labels: [String: String]?
        public let name: String?
        public let startIP: String?
        public let leases: [Lease]?
        public let id: String?
        public let vni: Int?
        public let netmask: String?
        public let options: Options?
        public let endIP: String?

        enum CodingKeys: String, CodingKey {
            case description
            case labels
            case name
            case startIP = "start-ip"
            case leases
            case id
            case vni
            case netmask
            case options
            case endIP = "end-ip"
        }
    }
}
