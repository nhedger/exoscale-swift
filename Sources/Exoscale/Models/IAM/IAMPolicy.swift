public extension Exoscale {
    /// IAM policy returned by the API.
    struct IAMPolicy: Codable, Sendable {
        public struct ServicePolicy: Codable, Sendable {
            public enum Kind: String, Codable, Sendable {
                case rules
                case allow
                case deny
            }

            public let type: Kind?
            public let rules: [Rule]?

            public init(type: Kind? = nil, rules: [Rule]? = nil) {
                self.type = type
                self.rules = rules
            }
        }

        public struct Rule: Codable, Sendable {
            public enum Action: String, Codable, Sendable {
                case allow
                case deny
            }

            public let action: Action?
            public let expression: String?
            public let resources: [String]?

            public init(
                action: Action? = nil,
                expression: String? = nil,
                resources: [String]? = nil
            ) {
                self.action = action
                self.expression = expression
                self.resources = resources
            }
        }

        public enum DefaultServiceStrategy: String, Codable, Sendable {
            case allow
            case deny
        }

        public let defaultServiceStrategy: DefaultServiceStrategy?
        public let services: [String: ServicePolicy]?

        public init(
            defaultServiceStrategy: DefaultServiceStrategy? = nil,
            services: [String: ServicePolicy]? = nil
        ) {
            self.defaultServiceStrategy = defaultServiceStrategy
            self.services = services
        }

        enum CodingKeys: String, CodingKey {
            case defaultServiceStrategy = "default-service-strategy"
            case services
        }
    }
}
