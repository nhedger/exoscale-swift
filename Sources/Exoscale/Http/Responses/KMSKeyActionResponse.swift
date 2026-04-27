/// Response for KMS key actions that return a status.
public struct KMSKeyActionResponse: Codable, Sendable {
    public let status: Exoscale.KMSKey.ActionStatus
}
