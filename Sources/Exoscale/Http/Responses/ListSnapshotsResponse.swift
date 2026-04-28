/// Response for listing compute instance snapshots.
public struct ListSnapshotsResponse: Codable, Sendable {
    public let snapshots: [Exoscale.Snapshot]
}
