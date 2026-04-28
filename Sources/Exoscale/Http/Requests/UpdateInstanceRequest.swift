/// Request body for updating a compute instance.
struct UpdateInstanceRequest: Codable, Sendable {
    let name: String?
    let userData: String?
    let publicIPAssignment: Exoscale.Instance.PublicIPAssignment?
    let labels: [String: String]?
    let applicationConsistentSnapshotEnabled: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case userData = "user-data"
        case publicIPAssignment = "public-ip-assignment"
        case labels
        case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
    }
}
