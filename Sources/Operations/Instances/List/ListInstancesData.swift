import Foundation

/// Response for listing compute instances.
struct ListInstancesData: Decodable, Sendable {
    let instances: [Exoscale.InstanceSummary.Payload]
}
