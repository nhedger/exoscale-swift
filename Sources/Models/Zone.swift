import Foundation

public extension Exoscale {
    /// Exoscale zone returned by the API.
    struct Zone: Hashable, Sendable {
        public let name: Exoscale.ZoneName
        public let apiEndpoint: URL
        public let sosEndpoint: URL

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: Exoscale.ZoneName,
            apiEndpoint: URL,
            sosEndpoint: URL
        ) {
            self.name = name
            self.apiEndpoint = apiEndpoint
            self.sosEndpoint = sosEndpoint
        }

        init(data: Payload, client _: Http.Client) {
            name = data.name
            apiEndpoint = data.apiEndpoint
            sosEndpoint = data.sosEndpoint
        }
    }
}
