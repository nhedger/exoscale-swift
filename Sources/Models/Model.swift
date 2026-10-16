import Foundation

public extension Exoscale {
    /// AI model returned by the API.
    struct Model: Hashable, Sendable {
        public let updatedAt: Date?
        public let name: String?
        public let state: State?
        public let id: String?
        public let modelSize: Int?
        public let createdAt: Date?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            updatedAt: Date? = nil,
            name: String? = nil,
            state: State? = nil,
            id: String? = nil,
            modelSize: Int? = nil,
            createdAt: Date? = nil
        ) {
            self.updatedAt = updatedAt
            self.name = name
            self.state = state
            self.id = id
            self.modelSize = modelSize
            self.createdAt = createdAt
        }

        init(data: Payload, client _: Http.Client) {
            updatedAt = data.updatedAt
            name = data.name
            state = data.state
            id = data.id
            modelSize = data.modelSize
            createdAt = data.createdAt
        }
    }
}

public extension Exoscale.Model {
    enum State: Exoscale.ExtensibleEnum {
        case ready
        case creating
        case downloading
        case error
        case created
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.ready, .creating, .downloading, .error, .created]

        public var rawValue: String {
            switch self {
            case .ready: "ready"
            case .creating: "creating"
            case .downloading: "downloading"
            case .error: "error"
            case .created: "created"
            case let .unknown(value): value
            }
        }
    }
}
