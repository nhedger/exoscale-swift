public extension Exoscale {
    /// Elastic IP returned by the API.
    struct ElasticIP: Codable, Sendable {
        public enum AddressFamily: String, Codable, Sendable {
            case inet4
            case inet6
        }

        public struct Healthcheck: Codable, Sendable {
            public enum Mode: String, Codable, Sendable {
                case tcp
                case http
                case https
            }

            public let strikesOK: Int?
            public let tlsSkipVerify: Bool?
            public let tlsSNI: String?
            public let strikesFail: Int?
            public let mode: Mode?
            public let port: Int?
            public let uri: String?
            public let interval: Int?
            public let timeout: Int?

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

        public let id: String?
        public let ip: String?
        public let addressFamily: AddressFamily?
        public let cidr: String?
        public let description: String?
        public let healthcheck: Healthcheck?
        public let labels: [String: String]?

        enum CodingKeys: String, CodingKey {
            case id
            case ip
            case addressFamily = "addressfamily"
            case cidr
            case description
            case healthcheck
            case labels
        }
    }
}
