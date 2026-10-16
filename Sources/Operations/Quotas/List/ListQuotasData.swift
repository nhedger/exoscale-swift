import Foundation

/// Response for listing organization quotas.
struct ListQuotasData: Decodable, Sendable {
    let quotas: [Exoscale.Quota.Payload]
}
