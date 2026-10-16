public extension Exoscale {
    /// IAM policy returned by the API.
    struct IAMPolicy: Codable, Hashable, Sendable {
        /// Whether services without a policy of their own are allowed or denied.
        public let defaultServiceStrategy: DefaultServiceStrategy
        /// Policies for individual services, keyed by service name.
        public let services: [String: ServicePolicy]

        /// Creates a policy. The API requires both fields, so they are always sent.
        public init(
            defaultServiceStrategy: DefaultServiceStrategy,
            services: [String: ServicePolicy] = [:]
        ) {
            self.defaultServiceStrategy = defaultServiceStrategy
            self.services = services
        }

        /// A policy without `services` is read as one with no service policies.
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            defaultServiceStrategy = try container.decode(DefaultServiceStrategy.self, forKey: .defaultServiceStrategy)
            services = try container.decodeIfPresent([String: ServicePolicy].self, forKey: .services) ?? [:]
        }
    }
}

public extension Exoscale.IAMPolicy.ServicePolicy {
    enum Kind: Exoscale.ExtensibleEnum {
        case rules
        case allow
        case deny
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.rules, .allow, .deny]

        public var rawValue: String {
            switch self {
            case .rules: "rules"
            case .allow: "allow"
            case .deny: "deny"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.IAMPolicy {
    struct ServicePolicy: Codable, Hashable, Sendable {
        public let type: Kind?
        public let rules: [Rule]?

        public init(type: Kind? = nil, rules: [Rule]? = nil) {
            self.type = type
            self.rules = rules
        }
    }
}

public extension Exoscale.IAMPolicy.Rule {
    enum Action: Exoscale.ExtensibleEnum {
        case allow
        case deny
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.allow, .deny]

        public var rawValue: String {
            switch self {
            case .allow: "allow"
            case .deny: "deny"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.IAMPolicy {
    struct Rule: Codable, Hashable, Sendable {
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
}

public extension Exoscale.IAMPolicy {
    enum DefaultServiceStrategy: Exoscale.ExtensibleEnum {
        case allow
        case deny
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.allow, .deny]

        public var rawValue: String {
            switch self {
            case .allow: "allow"
            case .deny: "deny"
            case let .unknown(value): value
            }
        }
    }
}

extension Exoscale.IAMPolicy {
    enum CodingKeys: String, CodingKey {
        case defaultServiceStrategy = "default-service-strategy"
        case services
    }
}
