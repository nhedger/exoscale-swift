import Foundation

public extension Exoscale {
    /// Log entry returned for an AI deployment.
    struct AIDeploymentLogEntry: Hashable, Sendable {
        public let time: Date?
        public let node: String?
        public let message: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            time: Date? = nil,
            node: String? = nil,
            message: String? = nil
        ) {
            self.time = time
            self.node = node
            self.message = message
        }

        init(data: Payload, client _: Http.Client) {
            time = data.time
            node = data.node
            message = data.message
        }
    }
}
