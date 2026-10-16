import Foundation

/// Request body for replicating a KMS key to another zone.
struct ReplicateKMSKeyBody: Encodable, Sendable {
    let zone: Exoscale.ZoneName
}
