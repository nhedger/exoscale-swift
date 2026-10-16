import Foundation

/// Response for KMS key actions that return a status.
struct KMSKeyActionData: Decodable, Sendable {
    let status: Exoscale.KMSKey.ActionStatus
}
