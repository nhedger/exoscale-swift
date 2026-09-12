import Foundation

public extension Exoscale {
    /// AI API key metadata returned by the API.
    struct AIAPIKey: Codable, Sendable {
        public let updatedAt: Date?
        public let name: String?
        public let scope: String?
        public let id: String?
        public let orgUUID: String?
        public let createdAt: Date?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated-at"
            case name
            case scope
            case id
            case orgUUID = "org-uuid"
            case createdAt = "created-at"
        }
    }
}
