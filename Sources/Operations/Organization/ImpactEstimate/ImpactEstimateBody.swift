import Foundation

/// Request body for estimating the environmental impact of using products.
struct ImpactEstimateBody: Encodable, Sendable {
    let sku: String
    let metadata: [String: Exoscale.JSONValue]?
}
