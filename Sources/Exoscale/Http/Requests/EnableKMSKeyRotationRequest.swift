/// Request body for enabling automatic KMS key rotation.
struct EnableKMSKeyRotationRequest: Codable, Sendable {
    let rotationPeriod: Int?

    enum CodingKeys: String, CodingKey {
        case rotationPeriod = "rotation-period"
    }
}
