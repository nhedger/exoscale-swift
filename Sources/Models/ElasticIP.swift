public extension Exoscale {
    /// Elastic IP returned by the API.
    struct ElasticIP: Hashable, Sendable {
        public let id: String?
        public let ip: String?
        public let addressFamily: AddressFamily?
        public let cidr: String?
        public let description: String?
        public let healthcheck: Healthcheck?
        public let labels: [String: String]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
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

        init(data: Payload, client _: Http.Client) {
            id = data.id
            ip = data.ip
            addressFamily = data.addressFamily
            cidr = data.cidr
            description = data.description
            healthcheck = data.healthcheck
            labels = data.labels
        }
    }
}

public extension Exoscale.ElasticIP {
    enum AddressFamily: Exoscale.ExtensibleEnum {
        case inet4
        case inet6
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.inet4, .inet6]

        public var rawValue: String {
            switch self {
            case .inet4: "inet4"
            case .inet6: "inet6"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.ElasticIP.Healthcheck {
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

extension Exoscale.ElasticIP.Healthcheck {
    enum CodingKeys: String, CodingKey {
        case strikesOK = "strikes-ok"
        case tlsSkipVerify = "tls-skip-verify"
        case tlsSNI = "tls-sni"
        case strikesFail = "strikes-fail"
        case mode
        case port
        case uri
        case interval
        case timeout
    }
}

public extension Exoscale.ElasticIP {
    struct Healthcheck: Codable, Hashable, Sendable {
        public let strikesOK: Int?
        public let tlsSkipVerify: Bool?
        public let tlsSNI: String?
        public let strikesFail: Int?
        public let mode: Mode?
        public let port: Int?
        public let uri: String?
        public let interval: Int?
        public let timeout: Int?

        /// Creates the health-check configuration required for a managed Elastic IP.
        /// - Parameters:
        ///   - mode: TCP, HTTP, or HTTPS.
        ///   - port: The target service port.
        ///   - uri: The optional HTTP request path.
        ///   - interval: Seconds between checks.
        ///   - timeout: Seconds before a check times out.
        ///   - strikesOK: Successful checks required to become healthy.
        ///   - strikesFail: Failed checks required to become unhealthy.
        ///   - tlsSNI: The optional TLS server name.
        ///   - tlsSkipVerify: Whether to skip TLS certificate verification.
        public init(
            mode: Mode, port: Int, uri: String? = nil, interval: Int? = nil, timeout: Int? = nil,
            strikesOK: Int? = nil, strikesFail: Int? = nil, tlsSNI: String? = nil, tlsSkipVerify: Bool? = nil
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
    }
}
