public extension Exoscale {
    /// Resource manager for managed compute instances.
    struct Manager: Hashable, Sendable {
        public let id: String?
        public let type: Kind?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            type: Kind? = nil
        ) {
            self.id = id
            self.type = type
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            type = data.type
        }
    }
}

public extension Exoscale.Manager {
    enum Kind: Exoscale.ExtensibleEnum {
        case sksNodepool
        case instancePool
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.sksNodepool, .instancePool]

        public var rawValue: String {
            switch self {
            case .sksNodepool: "sks-nodepool"
            case .instancePool: "instance-pool"
            case let .unknown(value): value
            }
        }
    }
}
