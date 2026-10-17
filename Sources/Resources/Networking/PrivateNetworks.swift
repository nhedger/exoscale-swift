public extension Exoscale {
    /// A layer 2 network between instances in a zone, optionally with managed addressing.
    struct PrivateNetwork: Hashable, Codable, Sendable {
        /// The network's identifier.
        public let id: String
        /// The network's name.
        public let name: String?
        /// The network's description.
        public let description: String?
        /// The labels attached to the network.
        public let labels: [String: String]?
        /// The first address handed out, for managed networks.
        public let startIP: String?
        /// The last address handed out, for managed networks.
        public let endIP: String?
        /// The netmask, for managed networks.
        public let netmask: String?
        /// The VXLAN network identifier.
        public let vni: Int?
        /// The DHCP options handed out, for managed networks.
        public let options: Options?
        /// The addresses handed out to instances, for managed networks.
        public let leases: [Lease]?

        /// Creates a private network, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            labels: [String: String]? = nil,
            startIP: String? = nil,
            endIP: String? = nil,
            netmask: String? = nil,
            vni: Int? = nil,
            options: Options? = nil,
            leases: [Lease]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.labels = labels
            self.startIP = startIP
            self.endIP = endIP
            self.netmask = netmask
            self.vni = vni
            self.options = options
            self.leases = leases
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, labels, netmask, vni, options, leases
            case startIP = "start-ip"
            case endIP = "end-ip"
        }

        /// The DHCP options a managed private network hands out.
        public struct Options: Hashable, Codable, Sendable {
            /// Default gateways.
            public let routers: [String]?
            /// DNS servers.
            public let dnsServers: [String]?
            /// NTP servers.
            public let ntpServers: [String]?
            /// DNS search domains.
            public let domainSearch: [String]?

            /// Creates DHCP options.
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

        /// An address a managed private network handed out to an instance.
        public struct Lease: Hashable, Codable, Sendable {
            /// The address.
            public let ip: String?
            /// The instance's identifier.
            public let instanceID: String?

            /// Creates a lease, for example for previews and tests.
            public init(ip: String? = nil, instanceID: String? = nil) {
                self.ip = ip
                self.instanceID = instanceID
            }

            enum CodingKeys: String, CodingKey {
                case ip
                case instanceID = "instance-id"
            }
        }
    }

    /// Private networks: layer 2 networks between instances in a zone.
    struct PrivateNetworks: Sendable {
        let client: HTTPClient

        /// Lists the private networks.
        public func list() async throws -> [PrivateNetwork] {
            try await client.send(.get, "/private-network", unwrapping: "private-networks")
        }

        /// Retrieves a private network.
        public func get(id: String) async throws -> PrivateNetwork {
            try await client.send(.get, "/private-network/\(id)")
        }

        /// Creates a private network. Give a start address, end address and netmask for one whose
        /// addresses Exoscale hands out.
        public func create(
            name: String,
            description: String? = nil,
            labels: [String: String]? = nil,
            startIP: String? = nil,
            endIP: String? = nil,
            netmask: String? = nil,
            options: PrivateNetwork.Options? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/private-network", body: [
                "name": name,
                "description": description,
                "labels": labels,
                "start-ip": startIP,
                "end-ip": endIP,
                "netmask": netmask,
                "options": options
            ] as JSONBody)
        }

        /// Updates a private network. Only the values passed are changed.
        public func update(
            id: String,
            name: String? = nil,
            description: String? = nil,
            labels: [String: String]? = nil,
            startIP: String? = nil,
            endIP: String? = nil,
            netmask: String? = nil,
            options: PrivateNetwork.Options? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/private-network/\(id)", body: [
                "name": name,
                "description": description,
                "labels": labels,
                "start-ip": startIP,
                "end-ip": endIP,
                "netmask": netmask,
                "options": options
            ] as JSONBody)
        }

        /// Removes all labels from a private network.
        public func removeLabels(id: String) async throws -> Operation {
            try await client.send(.delete, "/private-network/\(id)/labels")
        }

        /// Deletes a private network. No instance may be attached to it.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/private-network/\(id)")
        }

        /// Attaches an instance to a private network.
        ///
        /// - Parameter ip: The address to give the instance, for managed networks. Defaults to the
        ///   next free one.
        public func attach(instanceID: String, to id: String, ip: String? = nil) async throws -> Operation {
            try await client.send(.put, "/private-network/\(id):attach", body: [
                "instance": ["id": instanceID],
                "ip": ip
            ] as JSONBody)
        }

        /// Detaches an instance from a private network.
        public func detach(instanceID: String, from id: String) async throws -> Operation {
            try await client.send(
                .put,
                "/private-network/\(id):detach",
                body: ["instance": ["id": instanceID]] as JSONBody
            )
        }

        /// Changes the address of an instance on a managed private network.
        public func setIP(_ ip: String, forInstance instanceID: String, in id: String) async throws -> Operation {
            try await client.send(.put, "/private-network/\(id):update-ip", body: [
                "instance": ["id": instanceID],
                "ip": ip
            ] as JSONBody)
        }
    }
}
