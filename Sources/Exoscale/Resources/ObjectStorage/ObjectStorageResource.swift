/// Access to object storage API operations.
public struct ObjectStorageResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists object storage buckets usage.
    ///
    /// - Returns: The object storage buckets usage returned by the API.
    public func listBucketsUsage() async throws -> [Exoscale.SOSBucketUsage] {
        let response = try await http.get(path: "/sos-buckets-usage", as: ListSOSBucketsUsageResponse.self)
        return response.sosBucketsUsage
    }

    /// Retrieves a presigned download URL for an object storage object.
    ///
    /// - Parameters:
    ///   - bucket: The object storage bucket name.
    ///   - key: Optional object key.
    /// - Returns: The presigned URL returned by the API.
    public func presignedURL(bucket: String, key: String? = nil) async throws -> Exoscale.SOSPresignedURL {
        var query: [String: String?] = [:]

        if let key {
            query["key"] = key
        }

        return try await http.get(path: "/sos/\(bucket)/presigned-url", query: query, as: Exoscale.SOSPresignedURL.self)
    }
}
