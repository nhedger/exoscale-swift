import Foundation

/// Access to KMS key API operations.
public struct KMSKeysResource: Sendable {
    let http: Http.Client

    /// Lists KMS keys.
    ///
    /// - Returns: The KMS keys returned by the API.
    public func list() async throws -> [Exoscale.KMSKey] {
        try await http.execute(KMSKeysOperations.List(request: .init()))
    }

    /// Creates a KMS key.
    ///
    /// - Parameters:
    ///   - name: The KMS key name.
    ///   - description: The KMS key description.
    ///   - usage: The KMS key usage.
    ///   - multiZone: Whether the key is multi-zone capable.
    /// - Returns: The KMS key returned by the API.
    public func create(
        name: String,
        description: String? = nil,
        usage: Exoscale.KMSKey.Usage? = nil,
        multiZone: Bool? = nil
    ) async throws -> Exoscale.KMSKey {
        try await http.execute(
            KMSKeysOperations.Create(
                request: .init(name: name, description: description, usage: usage, multiZone: multiZone)
            )
        )
    }

    /// Retrieves a KMS key by identifier.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The KMS key returned by the API.
    public func get(id: String) async throws -> Exoscale.KMSKey {
        try await http.execute(KMSKeysOperations.Get(request: .init(id: id)))
    }

    /// Cancels a scheduled KMS key deletion.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The action status returned by the API.
    public func cancelDeletion(id: String) async throws -> Exoscale.KMSKey.ActionStatus {
        try await http.execute(KMSKeysOperations.CancelDeletion(request: .init(id: id)))
    }

    /// Disables a KMS key.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The action status returned by the API.
    public func disable(id: String) async throws -> Exoscale.KMSKey.ActionStatus {
        try await http.execute(KMSKeysOperations.Disable(request: .init(id: id)))
    }

    /// Disables automatic KMS key rotation.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The updated rotation configuration returned by the API.
    public func disableKeyRotation(id: String) async throws -> Exoscale.KMSKey.RotationConfig {
        try await http.execute(KMSKeysOperations.DisableKeyRotation(request: .init(id: id)))
    }

    /// Enables a KMS key.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The action status returned by the API.
    public func enable(id: String) async throws -> Exoscale.KMSKey.ActionStatus {
        try await http.execute(KMSKeysOperations.Enable(request: .init(id: id)))
    }

    /// Enables automatic KMS key rotation.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier.
    ///   - rotationPeriod: Optional rotation period in days.
    /// - Returns: The updated rotation configuration returned by the API.
    public func enableKeyRotation(
        id: String,
        rotationPeriod: Int? = nil
    ) async throws -> Exoscale.KMSKey.RotationConfig {
        try await http.execute(
            KMSKeysOperations.EnableKeyRotation(request: .init(id: id, rotationPeriod: rotationPeriod))
        )
    }

    /// Lists key material rotations for a KMS key.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The rotations returned by the API.
    public func listKeyRotations(id: String) async throws -> [Exoscale.KMSKey.Rotation] {
        try await http.execute(KMSKeysOperations.ListKeyRotations(request: .init(id: id)))
    }

    /// Replicates a KMS key to a target zone.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier.
    ///   - targetZone: The target zone.
    /// - Returns: The action status returned by the API.
    public func replicate(id: String, targetZone: Exoscale.ZoneName) async throws -> Exoscale.KMSKey.ActionStatus {
        try await http.execute(KMSKeysOperations.Replicate(request: .init(id: id, targetZone: targetZone)))
    }

    /// Rotates key material for a KMS key.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The updated rotation configuration returned by the API.
    public func rotate(id: String) async throws -> Exoscale.KMSKey.RotationConfig {
        try await http.execute(KMSKeysOperations.Rotate(request: .init(id: id)))
    }

    /// Schedules a KMS key for deletion.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier.
    ///   - delayDays: Optional number of days to wait until deletion is final.
    /// - Returns: The scheduled deletion timestamp.
    public func scheduleDeletion(
        id: String,
        delayDays: Int? = nil
    ) async throws -> Date {
        try await http.execute(KMSKeysOperations.ScheduleDeletion(request: .init(id: id, delayDays: delayDays)))
    }
}
