public extension Exoscale {
    /// A public IP address that can move between instances.
    struct ElasticIP: Hashable, Codable, Sendable {
        /// The Elastic IP's identifier.
        public let id: String
        /// The address.
        public let ip: String?
        /// Whether the address is IPv4 or IPv6.
        public let addressFamily: AddressFamily?
        /// The address as a CIDR.
        public let cidr: String?
        /// The Elastic IP's description.
        public let description: String?
        /// The health check deciding which attached instances receive traffic.
        public let healthcheck: Healthcheck?
        /// The labels attached to the Elastic IP.
        public let labels: [String: String]?

        /// Creates an Elastic IP, for example for previews and tests.
        public init(
            id: String,
            ip: String? = nil,
            addressFamily: AddressFamily? = nil,
            cidr: String? = nil,
            description: String? = nil,
            healthcheck: Healthcheck? = nil,
            labels: [String: String]? = nil
        ) {
            self.id = id
            self.ip = ip
            self.addressFamily = addressFamily
            self.cidr = cidr
            self.description = description
            self.healthcheck = healthcheck
            self.labels = labels
        }

        enum CodingKeys: String, CodingKey {
            case id, ip, cidr, description, healthcheck, labels
            case addressFamily = "addressfamily"
        }
    }
}

public extension Exoscale.ElasticIP {
    /// A health check deciding which attached instances receive an Elastic IP's traffic.
    struct Healthcheck: Hashable, Codable, Sendable {
        /// How the instances are checked.
        public let mode: Exoscale.HealthcheckMode
        /// The port to check.
        public let port: Int
        /// The path to request, for HTTP and HTTPS checks.
        public let uri: String?
        /// The time between checks, in seconds.
        public let interval: Int?
        /// The time to wait for an answer, in seconds.
        public let timeout: Int?
        /// The number of successful checks before an instance receives traffic again.
        public let strikesOK: Int?
        /// The number of failed checks before an instance stops receiving traffic.
        public let strikesFail: Int?
        /// The server name to send during the TLS handshake, for HTTPS checks.
        public let tlsSNI: String?
        /// Whether to accept any certificate, for HTTPS checks.
        public let tlsSkipVerify: Bool?

        /// Creates a health check.
        public init(
            mode: Exoscale.HealthcheckMode,
            port: Int,
            uri: String? = nil,
            interval: Int? = nil,
            timeout: Int? = nil,
            strikesOK: Int? = nil,
            strikesFail: Int? = nil,
            tlsSNI: String? = nil,
            tlsSkipVerify: Bool? = nil
        ) {
            self.mode = mode
            self.port = port
            self.uri = uri
            self.interval = interval
            self.timeout = timeout
            self.strikesOK = strikesOK
            self.strikesFail = strikesFail
            self.tlsSNI = tlsSNI
            self.tlsSkipVerify = tlsSkipVerify
        }

        enum CodingKeys: String, CodingKey {
            case mode, port, uri, interval, timeout
            case strikesOK = "strikes-ok"
            case strikesFail = "strikes-fail"
            case tlsSNI = "tls-sni"
            case tlsSkipVerify = "tls-skip-verify"
        }
    }
}

public extension Exoscale {
    /// Elastic IPs: public IP addresses that can move between instances.
    struct ElasticIPs: Sendable {
        let client: HTTPClient

        /// Lists the Elastic IPs.
        public func list() async throws -> [ElasticIP] {
            try await client.send(.get, "/elastic-ip", unwrapping: "elastic-ips")
        }

        /// Retrieves an Elastic IP.
        public func get(id: String) async throws -> ElasticIP {
            try await client.send(.get, "/elastic-ip/\(id)")
        }

        /// Creates an Elastic IP.
        ///
        /// - Parameters:
        ///   - addressFamily: Whether to reserve an IPv4 or IPv6 address. The API defaults to IPv4.
        ///   - description: The Elastic IP's description.
        ///   - healthcheck: A health check deciding which attached instances receive traffic.
        ///   - labels: Labels to attach.
        public func create(
            addressFamily: AddressFamily? = nil,
            description: String? = nil,
            healthcheck: ElasticIP.Healthcheck? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/elastic-ip", body: [
                "addressfamily": addressFamily,
                "description": description,
                "healthcheck": healthcheck,
                "labels": labels
            ] as JSONBody)
        }

        /// Updates an Elastic IP. Only the values passed are changed.
        public func update(
            id: String,
            description: String? = nil,
            healthcheck: ElasticIP.Healthcheck? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/elastic-ip/\(id)", body: [
                "description": description,
                "healthcheck": healthcheck,
                "labels": labels
            ] as JSONBody)
        }

        /// Removes an Elastic IP's description.
        public func removeDescription(id: String) async throws -> Operation {
            try await client.send(.delete, "/elastic-ip/\(id)/description")
        }

        /// Deletes an Elastic IP. It must not be attached to any instance.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/elastic-ip/\(id)")
        }

        /// Attaches an Elastic IP to an instance.
        public func attach(id: String, toInstance instanceID: String) async throws -> Operation {
            try await client.send(.put, "/elastic-ip/\(id):attach", body: ["instance": ["id": instanceID]] as JSONBody)
        }

        /// Detaches an Elastic IP from an instance.
        public func detach(id: String, fromInstance instanceID: String) async throws -> Operation {
            try await client.send(.put, "/elastic-ip/\(id):detach", body: ["instance": ["id": instanceID]] as JSONBody)
        }
    }
}
