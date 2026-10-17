import Foundation

public extension Exoscale {
    /// Keys of the Key Management Service (KMS). Use them with ``Exoscale/Crypto``.
    struct KMSKeys: Sendable {
        let client: HTTPClient

        /// Lists the keys.
        public func list() async throws -> [KMSKey] {
            try await client.send(.get, "/kms-key", unwrapping: "kms-keys")
        }

        /// Retrieves a key.
        public func get(id: String) async throws -> KMSKey {
            try await client.send(.get, "/kms-key/\(id)")
        }

        /// Creates a key.
        ///
        /// - Parameters:
        ///   - name: A name unique within the organization.
        ///   - description: The key's description.
        ///   - usage: What the key is used for.
        ///   - keySpec: The key's algorithm and, for asymmetric keys, its curve or modulus size.
        ///   - multiZone: Whether the key can be replicated to other zones.
        ///   - source: Where the key material is held.
        ///   - externalKey: The external key backing the key, for keys from an external key store.
        /// - Returns: The new key.
        public func create(
            name: String,
            description: String? = nil,
            usage: KMSKey.Usage? = nil,
            keySpec: KMSKey.KeySpec? = nil,
            multiZone: Bool? = nil,
            source: KMSKey.Source? = nil,
            externalKey: KMSKey.ExternalKey? = nil
        ) async throws -> KMSKey {
            try await client.send(.post, "/kms-key", body: [
                "name": name,
                "description": description,
                "usage": usage,
                "key-spec": keySpec,
                "multi-zone": multiZone,
                "source": source,
                "xks": externalKey
            ] as JSONBody)
        }

        /// Enables a disabled key.
        public func enable(id: String) async throws {
            try await client.send(.post, "/kms-key/\(id)/enable")
        }

        /// Disables a key, so it can't be used until it's enabled again.
        public func disable(id: String) async throws {
            try await client.send(.post, "/kms-key/\(id)/disable")
        }

        /// Replicates a multi-zone key to another zone.
        public func replicate(id: String, to zone: Zone) async throws {
            try await client.send(.post, "/kms-key/\(id)/replicate", body: ["zone": zone] as JSONBody)
        }

        // MARK: Rotation

        /// Rotates a symmetric key's material now.
        ///
        /// - Returns: The key's rotation configuration.
        public func rotate(id: String) async throws -> KMSKey.Rotation {
            try await client.send(.post, "/kms-key/\(id)/rotate", as: RotationResponse.self).rotation
        }

        /// Turns on automatic rotation of a key's material.
        ///
        /// - Parameter period: The number of days between rotations.
        public func enableRotation(id: String, period: Int? = nil) async throws -> KMSKey.Rotation {
            try await client.send(
                .post,
                "/kms-key/\(id)/enable-key-rotation",
                body: ["rotation-period": period] as JSONBody,
                as: RotationResponse.self
            ).rotation
        }

        /// Turns off automatic rotation of a key's material.
        public func disableRotation(id: String) async throws -> KMSKey.Rotation {
            try await client.send(.post, "/kms-key/\(id)/disable-key-rotation", as: RotationResponse.self).rotation
        }

        /// Lists the past rotations of a key's material.
        public func rotations(id: String) async throws -> [KMSKey.RotationRecord] {
            try await client.send(.get, "/kms-key/\(id)/list-key-rotations", unwrapping: "rotations")
        }

        // MARK: Deletion

        /// Schedules a key's deletion. Data encrypted with it can't be decrypted once it's deleted.
        ///
        /// - Parameter delayDays: The number of days before the deletion is final.
        /// - Returns: When the key will be deleted.
        public func scheduleDeletion(id: String, delayDays: Int? = nil) async throws -> Date? {
            try await client.send(
                .post,
                "/kms-key/\(id)/schedule-deletion",
                body: ["delay-days": delayDays] as JSONBody,
                as: ScheduledDeletion.self
            ).deleteAt
        }

        /// Cancels a key's scheduled deletion.
        public func cancelDeletion(id: String) async throws {
            try await client.send(.post, "/kms-key/\(id)/cancel-deletion")
        }
    }
}

private struct RotationResponse: Decodable {
    let rotation: Exoscale.KMSKey.Rotation
}

private struct ScheduledDeletion: Decodable {
    let deleteAt: Date?

    enum CodingKeys: String, CodingKey {
        case deleteAt = "delete-at"
    }
}
