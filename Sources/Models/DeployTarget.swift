public extension Exoscale {
    /// Deploy Target returned by the API.
    struct DeployTarget: Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let type: Kind?
        public let description: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            type: Kind? = nil,
            description: String? = nil
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.description = description
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            name = data.name
            type = data.type
            description = data.description
        }
    }
}

public extension Exoscale.DeployTarget {
    enum Kind: Exoscale.ExtensibleEnum {
        case edge
        case dedicated
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.edge, .dedicated]

        public var rawValue: String {
            switch self {
            case .edge: "edge"
            case .dedicated: "dedicated"
            case let .unknown(value): value
            }
        }
    }
}
