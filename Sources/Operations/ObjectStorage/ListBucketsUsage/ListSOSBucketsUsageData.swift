import Foundation

/// Response for listing SOS buckets usage.
struct ListSOSBucketsUsageData: Decodable, Sendable {
    let sosBucketsUsage: [Exoscale.SOSBucketUsage.Payload]

    enum CodingKeys: String, CodingKey {
        case sosBucketsUsage = "sos-buckets-usage"
    }
}
