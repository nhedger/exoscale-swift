/// Response for listing SOS buckets usage.
public struct ListSOSBucketsUsageResponse: Codable, Sendable {
    public let sosBucketsUsage: [Exoscale.SOSBucketUsage]

    enum CodingKeys: String, CodingKey {
        case sosBucketsUsage = "sos-buckets-usage"
    }
}
