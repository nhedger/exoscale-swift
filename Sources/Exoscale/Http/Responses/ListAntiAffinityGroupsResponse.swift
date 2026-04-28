/// Response for listing anti-affinity groups.
public struct ListAntiAffinityGroupsResponse: Codable, Sendable {
    public let antiAffinityGroups: [Exoscale.AntiAffinityGroup]

    enum CodingKeys: String, CodingKey {
        case antiAffinityGroups = "anti-affinity-groups"
    }
}
