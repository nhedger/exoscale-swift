import Foundation

/// Request body for enabling automatic KMS key rotation.
struct EnableKMSKeyRotationBody: Encodable, Sendable {
    let rotationPeriod: Int?

    enum CodingKeys: String, CodingKey {
        case rotationPeriod = "rotation-period"
    }
}
