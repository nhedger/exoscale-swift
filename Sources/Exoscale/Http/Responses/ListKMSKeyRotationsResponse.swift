/// Response for listing KMS key rotations.
public struct ListKMSKeyRotationsResponse: Codable, Sendable {
    public let rotations: [Exoscale.KMSKey.Rotation]
}
