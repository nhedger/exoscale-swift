import Foundation

/// Response for listing compute instance snapshots.
struct ListSnapshotsData: Decodable, Sendable {
    let snapshots: [Exoscale.Snapshot.Payload]
}
