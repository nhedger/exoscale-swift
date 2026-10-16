import Foundation

public extension Exoscale {
    /// Network load balancer returned by the API.
    struct LoadBalancer: Hashable, Sendable {
        public let id: String?
        public let description: String?
        public let name: String?
        public let state: State?
        public let createdAt: Date?
        public let ip: String?
        public let services: [Service]?
        public let labels: [String: String]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            description: String? = nil,
            name: String? = nil,
            state: State? = nil,
            createdAt: Date? = nil,
            ip: String? = nil,
            services: [Service]? = nil,
            labels: [String: String]? = nil
        ) {
            self.id = id
            self.description = description
            self.name = name
            self.state = state
            self.createdAt = createdAt
            self.ip = ip
            self.services = services
            self.labels = labels
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            description = data.description
            name = data.name
            state = data.state
            createdAt = data.createdAt
            ip = data.ip
            services = data.services
            labels = data.labels
        }
    }
}

public extension Exoscale.LoadBalancer.Service.Healthcheck {
    enum Mode: Exoscale.ExtensibleEnum {
        case tcp
        case http
        case https
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.tcp, .http, .https]

        public var rawValue: String {
            switch self {
            case .tcp: "tcp"
            case .http: "http"
            case .https: "https"
            case let .unknown(value): value
            }
        }
    }
}

extension Exoscale.LoadBalancer.Service.Healthcheck {
    enum CodingKeys: String, CodingKey {
        case mode
        case interval
        case uri
        case port
        case timeout
        case retries
        case tlsSNI = "tls-sni"
    }
}

public extension Exoscale.LoadBalancer.Service {
    struct Healthcheck: Codable, Hashable, Sendable {
        public let mode: Mode?
        public let interval: Int?
        public let uri: String?
        public let port: Int?
        public let timeout: Int?
        public let retries: Int?
        public let tlsSNI: String?

        public init(
            mode: Mode? = nil,
            interval: Int? = nil,
            uri: String? = nil,
            port: Int? = nil,
            timeout: Int? = nil,
            retries: Int? = nil,
            tlsSNI: String? = nil
        ) {
            self.mode = mode
            self.interval = interval
            self.uri = uri
            self.port = port
            self.timeout = timeout
            self.retries = retries
            self.tlsSNI = tlsSNI
        }
    }
}

public extension Exoscale.LoadBalancer.Service {
    struct InstancePoolReference: Codable, Hashable, Sendable {
        public let id: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil
        ) {
            self.id = id
        }
    }
}

public extension Exoscale.LoadBalancer.Service.ServerStatus {
    enum Status: Exoscale.ExtensibleEnum {
        case failure
        case success
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.failure, .success]

        public var rawValue: String {
            switch self {
            case .failure: "failure"
            case .success: "success"
            case let .unknown(value): value
            }
        }
    }
}

extension Exoscale.LoadBalancer.Service.ServerStatus {
    enum CodingKeys: String, CodingKey {
        case publicIP = "public-ip"
        case status
    }
}

public extension Exoscale.LoadBalancer.Service {
    struct ServerStatus: Codable, Hashable, Sendable {
        public let publicIP: String?
        public let status: Status?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            publicIP: String? = nil,
            status: Status? = nil
        ) {
            self.publicIP = publicIP
            self.status = status
        }
    }
}

public extension Exoscale.LoadBalancer.Service {
    enum NetworkProtocol: Exoscale.ExtensibleEnum {
        case tcp
        case udp
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.tcp, .udp]

        public var rawValue: String {
            switch self {
            case .tcp: "tcp"
            case .udp: "udp"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.LoadBalancer.Service {
    enum State: Exoscale.ExtensibleEnum {
        case creating
        case deleting
        case running
        case updating
        case error
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.creating, .deleting, .running, .updating, .error]

        public var rawValue: String {
            switch self {
            case .creating: "creating"
            case .deleting: "deleting"
            case .running: "running"
            case .updating: "updating"
            case .error: "error"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.LoadBalancer.Service {
    enum Strategy: Exoscale.ExtensibleEnum {
        case roundRobin
        case maglevHash
        case sourceHash
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.roundRobin, .maglevHash, .sourceHash]

        public var rawValue: String {
            switch self {
            case .roundRobin: "round-robin"
            case .maglevHash: "maglev-hash"
            case .sourceHash: "source-hash"
            case let .unknown(value): value
            }
        }
    }
}

extension Exoscale.LoadBalancer.Service {
    enum CodingKeys: String, CodingKey {
        case description
        case networkProtocol = "protocol"
        case name
        case state
        case targetPort = "target-port"
        case port
        case instancePool = "instance-pool"
        case strategy
        case healthcheck
        case id
        case healthcheckStatus = "healthcheck-status"
    }
}

public extension Exoscale.LoadBalancer {
    struct Service: Codable, Hashable, Sendable {
        public let description: String?
        public let networkProtocol: NetworkProtocol?
        public let name: String?
        public let state: State?
        public let targetPort: Int?
        public let port: Int?
        public let instancePool: InstancePoolReference?
        public let strategy: Strategy?
        public let healthcheck: Healthcheck?
        public let id: String?
        public let healthcheckStatus: [ServerStatus]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            networkProtocol: NetworkProtocol? = nil,
            name: String? = nil,
            state: State? = nil,
            targetPort: Int? = nil,
            port: Int? = nil,
            instancePool: InstancePoolReference? = nil,
            strategy: Strategy? = nil,
            healthcheck: Healthcheck? = nil,
            id: String? = nil,
            healthcheckStatus: [ServerStatus]? = nil
        ) {
            self.description = description
            self.networkProtocol = networkProtocol
            self.name = name
            self.state = state
            self.targetPort = targetPort
            self.port = port
            self.instancePool = instancePool
            self.strategy = strategy
            self.healthcheck = healthcheck
            self.id = id
            self.healthcheckStatus = healthcheckStatus
        }
    }
}

public extension Exoscale.LoadBalancer {
    enum State: Exoscale.ExtensibleEnum {
        case creating
        case migrated
        case deleting
        case running
        case migrating
        case error
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.creating, .migrated, .deleting, .running, .migrating, .error]

        public var rawValue: String {
            switch self {
            case .creating: "creating"
            case .migrated: "migrated"
            case .deleting: "deleting"
            case .running: "running"
            case .migrating: "migrating"
            case .error: "error"
            case let .unknown(value): value
            }
        }
    }
}
