public extension Exoscale {
    /// SOS presigned URL returned by the API.
    struct SOSPresignedURL: Codable, Sendable {
        public let url: String?
    }
}
