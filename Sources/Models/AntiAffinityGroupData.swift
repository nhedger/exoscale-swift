import Foundation

extension Exoscale.AntiAffinityGroup {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let name: String?
        let description: String?
        let instances: [Exoscale.InstanceSummary.Payload]?
    }
}
