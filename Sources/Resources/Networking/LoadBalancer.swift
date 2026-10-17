import Foundation

public extension Exoscale {
    /// A network load balancer, spreading traffic across the instances of instance pools.
    struct LoadBalancer: Hashable, Codable, Sendable {
        /// The load balancer's identifier.
        public let id: String
        /// The load balancer's name.
        public let name: String?
        /// The load balancer's description.
        public let description: String?
        /// Whether the load balancer is running or changing state.
        public let state: State?
        /// The public address traffic arrives on.
        public let ip: String?
        /// Whether the address is IPv4 or IPv6.
        public let addressFamily: AddressFamily?
        /// When the load balancer was created.
        public let createdAt: Date?
        /// The labels attached to the load balancer.
        public let labels: [String: String]?
        /// The services, one per port traffic arrives on.
        public let services: [Service]?

        /// Creates a load balancer, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            state: State? = nil,
            ip: String? = nil,
            addressFamily: AddressFamily? = nil,
            createdAt: Date? = nil,
            labels: [String: String]? = nil,
            services: [Service]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.state = state
            self.ip = ip
            self.addressFamily = addressFamily
            self.createdAt = createdAt
            self.labels = labels
            self.services = services
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, state, ip, labels, services
            case addressFamily = "addressfamily"
            case createdAt = "created-at"
        }
    }
}

public extension Exoscale.LoadBalancer {
    /// The state of a load balancer or one of its services.
    struct State: RawRepresentable, Hashable, Codable, Sendable {
        /// The state as the API names it.
        public let rawValue: String

        /// Creates a state, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Being created.
        public static let creating = State(rawValue: "creating")
        /// Running.
        public static let running = State(rawValue: "running")
        /// Changes are being applied.
        public static let updating = State(rawValue: "updating")
        /// Moving to new infrastructure.
        public static let migrating = State(rawValue: "migrating")
        /// Moved to new infrastructure.
        public static let migrated = State(rawValue: "migrated")
        /// Being deleted.
        public static let deleting = State(rawValue: "deleting")
        /// In an error state.
        public static let error = State(rawValue: "error")
    }

    /// A port on a load balancer and the instance pool its traffic goes to.
    struct Service: Hashable, Codable, Sendable {
        /// The service's identifier.
        public let id: String
        /// The service's name.
        public let name: String?
        /// The service's description.
        public let description: String?
        /// Whether the service is running or changing state.
        public let state: State?
        /// The protocol the service balances.
        public let `protocol`: TransportProtocol?
        /// How the service picks an instance for each connection.
        public let strategy: Strategy?
        /// The port traffic arrives on.
        public let port: Int?
        /// The port traffic is sent to on the instances.
        public let targetPort: Int?
        /// The instance pool receiving the traffic.
        public let instancePool: Exoscale.Reference<Exoscale.InstancePool>?
        /// The health check deciding which instances receive traffic.
        public let healthcheck: Healthcheck?
        /// The latest health check result of each instance.
        public let healthcheckStatus: [ServerStatus]?

        /// Creates a service, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            state: State? = nil,
            protocol: TransportProtocol? = nil,
            strategy: Strategy? = nil,
            port: Int? = nil,
            targetPort: Int? = nil,
            instancePool: Exoscale.Reference<Exoscale.InstancePool>? = nil,
            healthcheck: Healthcheck? = nil,
            healthcheckStatus: [ServerStatus]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.state = state
            self.protocol = `protocol`
            self.strategy = strategy
            self.port = port
            self.targetPort = targetPort
            self.instancePool = instancePool
            self.healthcheck = healthcheck
            self.healthcheckStatus = healthcheckStatus
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, state, `protocol`, strategy, port, healthcheck
            case targetPort = "target-port"
            case instancePool = "instance-pool"
            case healthcheckStatus = "healthcheck-status"
        }
    }

    /// The transport protocol a service balances.
    struct TransportProtocol: RawRepresentable, Hashable, Codable, Sendable {
        /// The protocol as the API names it.
        public let rawValue: String

        /// Creates a protocol, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// TCP.
        public static let tcp = TransportProtocol(rawValue: "tcp")
        /// UDP.
        public static let udp = TransportProtocol(rawValue: "udp")
    }

    /// How a service picks an instance for each connection.
    struct Strategy: RawRepresentable, Hashable, Codable, Sendable {
        /// The strategy as the API names it.
        public let rawValue: String

        /// Creates a strategy, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Each instance in turn.
        public static let roundRobin = Strategy(rawValue: "round-robin")
        /// By a hash of the source address.
        public static let sourceHash = Strategy(rawValue: "source-hash")
        /// By consistent Maglev hashing, which moves few connections when instances change.
        public static let maglevHash = Strategy(rawValue: "maglev-hash")
    }

    /// A health check deciding which instances of a service receive traffic.
    struct Healthcheck: Hashable, Codable, Sendable {
        /// How the instances are checked.
        public let mode: Exoscale.HealthcheckMode?
        /// The port to check.
        public let port: Int?
        /// The path to request, for HTTP and HTTPS checks.
        public let uri: String?
        /// The time between checks, in seconds.
        public let interval: Int?
        /// The time to wait for an answer, in seconds.
        public let timeout: Int?
        /// The number of failed checks before an instance stops receiving traffic.
        public let retries: Int?
        /// The server name to send during the TLS handshake, for HTTPS checks.
        public let tlsSNI: String?

        /// Creates a health check.
        public init(
            mode: Exoscale.HealthcheckMode? = nil,
            port: Int? = nil,
            uri: String? = nil,
            interval: Int? = nil,
            timeout: Int? = nil,
            retries: Int? = nil,
            tlsSNI: String? = nil
        ) {
            self.mode = mode
            self.port = port
            self.uri = uri
            self.interval = interval
            self.timeout = timeout
            self.retries = retries
            self.tlsSNI = tlsSNI
        }

        enum CodingKeys: String, CodingKey {
            case mode, port, uri, interval, timeout, retries
            case tlsSNI = "tls-sni"
        }
    }

    /// The latest health check result of one instance.
    struct ServerStatus: Hashable, Codable, Sendable {
        /// The instance's public address.
        public let publicIP: String?
        /// Whether the check succeeded.
        public let status: Result?

        /// Creates a status, for example for previews and tests.
        public init(publicIP: String? = nil, status: Result? = nil) {
            self.publicIP = publicIP
            self.status = status
        }

        enum CodingKeys: String, CodingKey {
            case status
            case publicIP = "public-ip"
        }

        /// The result of a health check.
        public struct Result: RawRepresentable, Hashable, Codable, Sendable {
            /// The result as the API names it.
            public let rawValue: String

            /// Creates a result, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// The instance is healthy.
            public static let success = Result(rawValue: "success")
            /// The instance is unhealthy and receives no traffic.
            public static let failure = Result(rawValue: "failure")
        }
    }

    /// A setting of a load balancer that can be reset to its default.
    struct Field: RawRepresentable, Hashable, Sendable {
        /// The field as the API names it.
        public let rawValue: String

        /// Creates a field, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The description.
        public static let description = Field(rawValue: "description")
        /// The labels.
        public static let labels = Field(rawValue: "labels")
    }
}
