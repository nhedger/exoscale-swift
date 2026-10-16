public extension Exoscale {
    /// Private Network returned by the API.
    struct PrivateNetwork: Hashable, Sendable {
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

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            labels: [String: String]? = nil,
            name: String? = nil,
            startIP: String? = nil,
            leases: [Lease]? = nil,
            id: String? = nil,
            vni: Int? = nil,
            netmask: String? = nil,
            options: Options? = nil,
            endIP: String? = nil
        ) {
            self.description = description
            self.labels = labels
            self.name = name
            self.startIP = startIP
            self.leases = leases
            self.id = id
            self.vni = vni
            self.netmask = netmask
            self.options = options
            self.endIP = endIP
        }

        init(data: Payload, client _: Http.Client) {
            description = data.description
            labels = data.labels
            name = data.name
            startIP = data.startIP
            leases = data.leases
            id = data.id
            vni = data.vni
            netmask = data.netmask
            options = data.options
            endIP = data.endIP
        }
    }
}

extension Exoscale.PrivateNetwork.Lease {
    enum CodingKeys: String, CodingKey {
        case ip
        case instanceID = "instance-id"
    }
}

public extension Exoscale.PrivateNetwork {
    struct Lease: Codable, Hashable, Sendable {
        public let ip: String?
        public let instanceID: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            ip: String? = nil,
            instanceID: String? = nil
        ) {
            self.ip = ip
            self.instanceID = instanceID
        }
    }
}

extension Exoscale.PrivateNetwork.Options {
    enum CodingKeys: String, CodingKey {
        case routers
        case dnsServers = "dns-servers"
        case ntpServers = "ntp-servers"
        case domainSearch = "domain-search"
    }
}

public extension Exoscale.PrivateNetwork {
    struct Options: Codable, Hashable, Sendable {
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
    }
}
