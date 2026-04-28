/// Request body for replicating a KMS key to another zone.
struct ReplicateKMSKeyRequest: Codable, Sendable {
    let zone: Exoscale.KnownZone
}
