import Foundation

public extension Exoscale {
    /// Log entry returned for an AI deployment.
    struct AIDeploymentLogEntry: Codable, Sendable {
        public let time: Date?
        public let node: String?
        public let message: String?
    }
}
