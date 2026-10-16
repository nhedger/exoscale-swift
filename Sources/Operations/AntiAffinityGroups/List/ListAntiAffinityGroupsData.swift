import Foundation

/// Response for listing anti-affinity groups.
struct ListAntiAffinityGroupsData: Decodable, Sendable {
    let antiAffinityGroups: [Exoscale.AntiAffinityGroup.Payload]

    enum CodingKeys: String, CodingKey {
        case antiAffinityGroups = "anti-affinity-groups"
    }
}
