import Foundation

public extension Exoscale {
    /// AI API key including its plaintext value.
    struct AIAPIKeyWithValue: Hashable, Sendable {
        public let updatedAt: Date?
        public let name: String?
        public let scope: String?
        public let id: String?
        public let orgUUID: String?
        public let createdAt: Date?
        public let value: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            updatedAt: Date? = nil,
            name: String? = nil,
            scope: String? = nil,
            id: String? = nil,
            orgUUID: String? = nil,
            createdAt: Date? = nil,
            value: String? = nil
        ) {
            self.updatedAt = updatedAt
            self.name = name
            self.scope = scope
            self.id = id
            self.orgUUID = orgUUID
            self.createdAt = createdAt
            self.value = value
        }

        init(data: Payload, client _: Http.Client) {
            updatedAt = data.updatedAt
            name = data.name
            scope = data.scope
            id = data.id
            orgUUID = data.orgUUID
            createdAt = data.createdAt
            value = data.value
        }
    }
}
