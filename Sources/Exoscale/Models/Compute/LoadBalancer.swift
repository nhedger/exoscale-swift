public extension Exoscale {
    /// Network load balancer returned by the API.
    struct LoadBalancer: Codable, Sendable {
        public struct Service: Codable, Sendable {
            public struct Healthcheck: Codable, Sendable {
                public enum Mode: String, Codable, Sendable {
                    case tcp
                    case http
                    case https
                }

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

            public struct InstancePoolReference: Codable, Sendable {
                public let id: String?
            }

            public struct ServerStatus: Codable, Sendable {
                public enum Status: String, Codable, Sendable {
                    case failure
                    case success
                }

                public let publicIP: String?
                public let status: Status?

                enum CodingKeys: String, CodingKey {
                    case publicIP = "public-ip"
                    case status
                }
            }

            public enum NetworkProtocol: String, Codable, Sendable {
                case tcp
                case udp
            }

            public enum State: String, Codable, Sendable {
                case creating
                case deleting
                case running
                case updating
                case error
            }

            public enum Strategy: String, Codable, Sendable {
                case roundRobin = "round-robin"
                case maglevHash = "maglev-hash"
                case sourceHash = "source-hash"
            }

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

        public enum State: String, Codable, Sendable {
            case creating
            case migrated
            case deleting
            case running
            case migrating
            case error
        }

        public let id: String?
        public let description: String?
        public let name: String?
        public let state: State?
        public let createdAt: String?
        public let ip: String?
        public let services: [Service]?
        public let labels: [String: String]?

        enum CodingKeys: String, CodingKey {
            case id
            case description
            case name
            case state
            case createdAt = "created-at"
            case ip
            case services
            case labels
        }
    }
}
