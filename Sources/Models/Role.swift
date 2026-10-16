public extension Exoscale {
    /// IAM role returned by the API.
    struct Role: Hashable, Sendable {
        public let description: String?
        public let labels: [String: String]?
        public let permissions: [Permission]?
        public let assumeRolePolicy: IAMAssumeRolePolicy?
        public let editable: Bool?
        public let name: String?
        public let maxSessionTTL: Int?
        public let policy: IAMPolicy?
        public let id: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            labels: [String: String]? = nil,
            permissions: [Permission]? = nil,
            assumeRolePolicy: IAMAssumeRolePolicy? = nil,
            editable: Bool? = nil,
            name: String? = nil,
            maxSessionTTL: Int? = nil,
            policy: IAMPolicy? = nil,
            id: String? = nil
        ) {
            self.description = description
            self.labels = labels
            self.permissions = permissions
            self.assumeRolePolicy = assumeRolePolicy
            self.editable = editable
            self.name = name
            self.maxSessionTTL = maxSessionTTL
            self.policy = policy
            self.id = id
        }

        init(data: Payload, client _: Http.Client) {
            description = data.description
            labels = data.labels
            permissions = data.permissions
            assumeRolePolicy = data.assumeRolePolicy
            editable = data.editable
            name = data.name
            maxSessionTTL = data.maxSessionTTL
            policy = data.policy
            id = data.id
        }
    }
}

public extension Exoscale.Role {
    enum Permission: Exoscale.ExtensibleEnum {
        case bypassGovernanceRetention
        case resetIAMOrganizationPolicy
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.bypassGovernanceRetention, .resetIAMOrganizationPolicy]

        public var rawValue: String {
            switch self {
            case .bypassGovernanceRetention: "bypass-governance-retention"
            case .resetIAMOrganizationPolicy: "reset-iam-organization-policy"
            case let .unknown(value): value
            }
        }
    }
}
