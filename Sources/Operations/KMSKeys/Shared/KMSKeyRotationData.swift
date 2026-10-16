import Foundation

/// Response for KMS key rotation configuration changes.
struct KMSKeyRotationData: Decodable, Sendable {
    let rotation: Exoscale.KMSKey.RotationConfig
}
