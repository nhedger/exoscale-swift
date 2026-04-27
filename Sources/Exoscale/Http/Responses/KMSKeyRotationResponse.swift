/// Response for KMS key rotation configuration changes.
public struct KMSKeyRotationResponse: Codable, Sendable {
    public let rotation: Exoscale.KMSKey.RotationConfig
}
