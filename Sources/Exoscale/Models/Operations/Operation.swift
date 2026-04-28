public extension Exoscale {
    /// Asynchronous operation returned by the API.
    struct Operation: Codable, Sendable {
        public struct Reference: Codable, Sendable {
            public let id: String?
            public let link: String?
            public let command: String?
        }

        public enum Reason: String, Codable, Sendable {
            case incorrect
            case unknown
            case unavailable
            case forbidden
            case busy
            case fault
            case partial
            case notFound = "not-found"
            case interrupted
            case unsupported
            case conflict
        }

        public enum State: String, Codable, Sendable {
            case failure
            case pending
            case success
            case timeout
        }

        public let id: String?
        public let reason: Reason?
        public let reference: Reference?
        public let message: String?
        public let state: State?
    }
}
