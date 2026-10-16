/// Access to object storage API operations.
public struct ObjectStorageResource: Sendable {
    let http: Http.Client

    /// Lists object storage buckets usage.
    ///
    /// - Returns: The object storage buckets usage returned by the API.
    public func listBucketsUsage() async throws -> [Exoscale.SOSBucketUsage] {
        try await http.execute(ObjectStorageOperations.ListBucketsUsage(request: .init()))
    }

    /// Retrieves a presigned download URL for an object storage object.
    ///
    /// - Parameters:
    ///   - bucket: The object storage bucket name.
    ///   - key: Optional object key.
    /// - Returns: The presigned URL returned by the API.
    public func presignedURL(bucket: String, key: String? = nil) async throws -> Exoscale.SOSPresignedURL {
        try await http.execute(ObjectStorageOperations.PresignedURL(request: .init(bucket: bucket, key: key)))
    }
}
