public extension Exoscale {
    /// An IAM policy: which API operations are allowed, per service.
    struct IAMPolicy: Hashable, Codable, Sendable {
        /// Whether services without a policy of their own are allowed or denied.
        public let defaultServiceStrategy: Action
        /// The policies of individual services, keyed by service name such as `compute`.
        public let services: [String: ServicePolicy]

        /// Creates a policy. The API requires both values, so they are always sent.
        public init(defaultServiceStrategy: Action, services: [String: ServicePolicy] = [:]) {
            self.defaultServiceStrategy = defaultServiceStrategy
            self.services = services
        }

        /// A policy without `services` is read as one with no service policies.
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            defaultServiceStrategy = try container.decode(Action.self, forKey: .defaultServiceStrategy)
            services = try container.decodeIfPresent([String: ServicePolicy].self, forKey: .services) ?? [:]
        }

        enum CodingKeys: String, CodingKey {
            case services
            case defaultServiceStrategy = "default-service-strategy"
        }
    }
}

public extension Exoscale.IAMPolicy {
    /// Whether something is allowed or denied.
    struct Action: RawRepresentable, Hashable, Codable, Sendable {
        /// The action as the API names it.
        public let rawValue: String

        /// Creates an action, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Allowed.
        public static let allow = Action(rawValue: "allow")
        /// Denied.
        public static let deny = Action(rawValue: "deny")
    }

    /// The policy of one service.
    struct ServicePolicy: Hashable, Codable, Sendable {
        /// Whether the whole service is allowed or denied, or decided by rules.
        public let type: Kind?
        /// The rules, checked in order, when `type` is ``Kind/rules``.
        public let rules: [Rule]?

        /// Creates a service policy.
        public init(type: Kind? = nil, rules: [Rule]? = nil) {
            self.type = type
            self.rules = rules
        }

        /// How a service policy decides.
        public struct Kind: RawRepresentable, Hashable, Codable, Sendable {
            /// The kind as the API names it.
            public let rawValue: String

            /// Creates a kind, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Every operation of the service is allowed.
            public static let allow = Kind(rawValue: "allow")
            /// Every operation of the service is denied.
            public static let deny = Kind(rawValue: "deny")
            /// The rules decide.
            public static let rules = Kind(rawValue: "rules")
        }
    }

    /// A rule allowing or denying the operations that match an expression.
    struct Rule: Hashable, Codable, Sendable {
        /// Whether matching operations are allowed or denied.
        public let action: Action?
        /// The expression operations are matched against, such as `operation == 'list-instances'`.
        public let expression: String?
        /// The resources the rule applies to.
        public let resources: [String]?

        /// Creates a rule.
        public init(action: Action? = nil, expression: String? = nil, resources: [String]? = nil) {
            self.action = action
            self.expression = expression
            self.resources = resources
        }
    }
}
