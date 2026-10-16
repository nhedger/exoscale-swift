import Foundation

/// Response for listing KMS key rotations.
struct ListKMSKeyRotationsData: Decodable, Sendable {
    let rotations: [Exoscale.KMSKey.Rotation]
}
