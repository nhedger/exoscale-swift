import Foundation

public extension Exoscale {
    /// The storage used by an SOS bucket.
    struct BucketUsage: Hashable, Codable, Sendable {
        /// The bucket's name.
        public let name: String
        /// The zone the bucket is in.
        public let zone: Zone?
        /// The bucket's size, in bytes.
        public let size: Int?
        /// When the bucket was created.
        public let createdAt: Date?

        /// Creates a bucket usage, for example for previews and tests.
        public init(name: String, zone: Zone? = nil, size: Int? = nil, createdAt: Date? = nil) {
            self.name = name
            self.zone = zone
            self.size = size
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case name, size
            case zone = "zone-name"
            case createdAt = "created-at"
        }
    }

    /// Simple Object Storage (SOS). Objects themselves are managed with S3-compatible tools.
    struct ObjectStorage: Sendable {
        let client: HTTPClient
        let s3: S3Client

        /// Creates a private bucket in the client's zone.
        ///
        /// Bucket names are shared by every organization, so a taken name fails with an
        /// ``S3Error`` whose code is `BucketAlreadyExists`.
        public func createBucket(_ name: String) async throws {
            try await s3.send(.put, bucket: name)
        }

        /// Deletes a bucket of the client's zone. Only an empty bucket can be deleted; one with
        /// objects fails with an ``S3Error`` whose code is `BucketNotEmpty`.
        public func deleteBucket(_ name: String) async throws {
            try await s3.send(.delete, bucket: name)
        }

        /// Lists the organization's buckets and the storage each uses.
        public func bucketUsage() async throws -> [BucketUsage] {
            try await client.send(.get, "/sos-buckets-usage", unwrapping: "sos-buckets-usage")
        }

        /// Creates a temporary download URL for an object.
        public func presignedURL(bucket: String, key: String) async throws -> URL {
            let response = try await client.send(
                .get,
                "/sos/\(bucket)/presigned-url",
                query: ["key": key],
                as: PresignedURL.self
            )
            guard let url = response.url.flatMap(URL.init(string:)) else {
                throw ClientError.invalidResponse
            }
            return url
        }
    }
}

private struct PresignedURL: Decodable {
    let url: String?
}
