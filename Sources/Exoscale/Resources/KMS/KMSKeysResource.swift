import Foundation

/// Access to KMS key API operations.
public struct KMSKeysResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists KMS keys.
    ///
    /// - Returns: The KMS keys returned by the API.
    public func list() async throws -> [Exoscale.KMSKey] {
        let response = try await http.get(path: "/kms-key", as: ListKMSKeysResponse.self)
        return response.kmsKeys
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
        description: String,
        usage: Exoscale.KMSKey.Usage = .encryptDecrypt,
        multiZone: Bool
    ) async throws -> Exoscale.KMSKey {
        let body = try JSONEncoder().encode(
            CreateKMSKeyRequest(
                name: name,
                description: description,
                usage: usage,
                multiZone: multiZone
            )
        )

        return try await http.post(path: "/kms-key", body: body, as: Exoscale.KMSKey.self)
    }

    /// Retrieves a KMS key by identifier.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The KMS key returned by the API.
    public func get(id: String) async throws -> Exoscale.KMSKey {
        try await http.get(path: "/kms-key/\(id)", as: Exoscale.KMSKey.self)
    }

    /// Cancels a scheduled KMS key deletion.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The action status returned by the API.
    public func cancelDeletion(id: String) async throws -> Exoscale.KMSKey.ActionStatus {
        let response = try await http.post(path: "/kms-key/\(id)/cancel-deletion", as: KMSKeyActionResponse.self)
        return response.status
    }

    /// Disables a KMS key.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The action status returned by the API.
    public func disable(id: String) async throws -> Exoscale.KMSKey.ActionStatus {
        let response = try await http.post(path: "/kms-key/\(id)/disable", as: KMSKeyActionResponse.self)
        return response.status
    }

    /// Disables automatic KMS key rotation.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The updated rotation configuration returned by the API.
    public func disableKeyRotation(id: String) async throws -> Exoscale.KMSKey.RotationConfig {
        let response = try await http.post(
            path: "/kms-key/\(id)/disable-key-rotation",
            as: KMSKeyRotationResponse.self
        )
        return response.rotation
    }

    /// Enables a KMS key.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The action status returned by the API.
    public func enable(id: String) async throws -> Exoscale.KMSKey.ActionStatus {
        let response = try await http.post(path: "/kms-key/\(id)/enable", as: KMSKeyActionResponse.self)
        return response.status
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
        let body = try JSONEncoder().encode(EnableKMSKeyRotationRequest(rotationPeriod: rotationPeriod))
        let response = try await http.post(
            path: "/kms-key/\(id)/enable-key-rotation",
            body: body,
            as: KMSKeyRotationResponse.self
        )
        return response.rotation
    }

    /// Lists key material rotations for a KMS key.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The rotations returned by the API.
    public func listKeyRotations(id: String) async throws -> [Exoscale.KMSKey.Rotation] {
        let response = try await http.get(
            path: "/kms-key/\(id)/list-key-rotations",
            as: ListKMSKeyRotationsResponse.self
        )
        return response.rotations
    }

    /// Replicates a KMS key to a target zone.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier.
    ///   - targetZone: The target zone.
    /// - Returns: The action status returned by the API.
    public func replicate(id: String, targetZone: Exoscale.KnownZone) async throws -> Exoscale.KMSKey.ActionStatus {
        let body = try JSONEncoder().encode(ReplicateKMSKeyRequest(zone: targetZone))
        let response = try await http.post(
            path: "/kms-key/\(id)/replicate",
            body: body,
            as: KMSKeyActionResponse.self
        )
        return response.status
    }

    /// Rotates key material for a KMS key.
    ///
    /// - Parameter id: The KMS key identifier.
    /// - Returns: The updated rotation configuration returned by the API.
    public func rotate(id: String) async throws -> Exoscale.KMSKey.RotationConfig {
        let response = try await http.post(path: "/kms-key/\(id)/rotate", as: KMSKeyRotationResponse.self)
        return response.rotation
    }

    /// Schedules a KMS key for deletion.
    ///
    /// - Parameters:
    ///   - id: The KMS key identifier.
    ///   - delayDays: Optional number of days to wait until deletion is final.
    /// - Returns: The action status returned by the API.
    public func scheduleDeletion(
        id: String,
        delayDays: Int? = nil
    ) async throws -> Exoscale.KMSKey.ActionStatus {
        let body = try JSONEncoder().encode(ScheduleKMSKeyDeletionRequest(delayDays: delayDays))
        let response = try await http.post(
            path: "/kms-key/\(id)/schedule-deletion",
            body: body,
            as: KMSKeyActionResponse.self
        )
        return response.status
    }
}
