import Foundation

public extension Exoscale {
    /// DNS domain returned by the API.
    struct Domain: Hashable, Sendable {
        public let id: String?
        public let createdAt: Date?
        public let unicodeName: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            createdAt: Date? = nil,
            unicodeName: String? = nil
        ) {
            self.id = id
            self.createdAt = createdAt
            self.unicodeName = unicodeName
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            createdAt = data.createdAt
            unicodeName = data.unicodeName
        }
    }
}
