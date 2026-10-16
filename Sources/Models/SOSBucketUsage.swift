import Foundation

public extension Exoscale {
    /// SOS bucket usage returned by the API.
    struct SOSBucketUsage: Hashable, Sendable {
        public let name: String?
        public let createdAt: Date?
        public let zoneName: Exoscale.ZoneName?
        public let size: Int?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: String? = nil,
            createdAt: Date? = nil,
            zoneName: Exoscale.ZoneName? = nil,
            size: Int? = nil
        ) {
            self.name = name
            self.createdAt = createdAt
            self.zoneName = zoneName
            self.size = size
        }

        init(data: Payload, client _: Http.Client) {
            name = data.name
            createdAt = data.createdAt
            zoneName = data.zoneName
            size = data.size
        }
    }
}
