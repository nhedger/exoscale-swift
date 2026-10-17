import Foundation

public extension Exoscale {
    /// A block storage volume that can be attached to an instance.
    struct BlockStorageVolume: Hashable, Codable, Sendable {
        /// The volume's identifier.
        public let id: String
        /// The volume's name.
        public let name: String?
        /// Whether the volume is attached, detached or changing state.
        public let state: State?
        /// The volume's size, in GiB.
        public let size: Int?
        /// The volume's block size.
        public let blockSize: Int?
        /// Whether the volume is encrypted.
        public let encrypted: Bool?
        /// The instance the volume is attached to.
        public let instance: Reference<Instance>?
        /// The volume's snapshots.
        public let snapshots: [Reference<BlockStorageSnapshot>]?
        /// The labels attached to the volume.
        public let labels: [String: String]?
        /// When the volume was created.
        public let createdAt: Date?

        /// Creates a volume, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            state: State? = nil,
            size: Int? = nil,
            blockSize: Int? = nil,
            encrypted: Bool? = nil,
            instance: Reference<Instance>? = nil,
            snapshots: [Reference<BlockStorageSnapshot>]? = nil,
            labels: [String: String]? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.state = state
            self.size = size
            self.blockSize = blockSize
            self.encrypted = encrypted
            self.instance = instance
            self.snapshots = snapshots
            self.labels = labels
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, state, size, encrypted, instance, labels
            case blockSize = "blocksize"
            case snapshots = "block-storage-snapshots"
            case createdAt = "created-at"
        }

        /// The state of a volume.
        public struct State: RawRepresentable, Hashable, Codable, Sendable {
            /// The state as the API names it.
            public let rawValue: String

            /// Creates a state, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Being created.
            public static let creating = State(rawValue: "creating")
            /// Not attached to an instance.
            public static let detached = State(rawValue: "detached")
            /// Being attached.
            public static let attaching = State(rawValue: "attaching")
            /// Attached to an instance.
            public static let attached = State(rawValue: "attached")
            /// Being detached.
            public static let detaching = State(rawValue: "detaching")
            /// A snapshot is being taken.
            public static let snapshotting = State(rawValue: "snapshotting")
            /// Being deleted.
            public static let deleting = State(rawValue: "deleting")
            /// Deleted.
            public static let deleted = State(rawValue: "deleted")
            /// In an error state.
            public static let error = State(rawValue: "error")
        }
    }

    /// A snapshot of a block storage volume.
    struct BlockStorageSnapshot: Hashable, Codable, Sendable {
        /// The snapshot's identifier.
        public let id: String
        /// The snapshot's name.
        public let name: String?
        /// Whether the snapshot is ready or changing state.
        public let state: State?
        /// The snapshot's size.
        public let size: Int?
        /// The size of the volume the snapshot was taken from.
        public let volumeSize: Int?
        /// The volume the snapshot was taken from.
        public let volume: Reference<BlockStorageVolume>?
        /// The labels attached to the snapshot.
        public let labels: [String: String]?
        /// When the snapshot was taken.
        public let createdAt: Date?

        /// Creates a snapshot, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            state: State? = nil,
            size: Int? = nil,
            volumeSize: Int? = nil,
            volume: Reference<BlockStorageVolume>? = nil,
            labels: [String: String]? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.state = state
            self.size = size
            self.volumeSize = volumeSize
            self.volume = volume
            self.labels = labels
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, state, size, labels
            case volumeSize = "volume-size"
            case volume = "block-storage-volume"
            case createdAt = "created-at"
        }

        /// The state of a snapshot.
        public struct State: RawRepresentable, Hashable, Codable, Sendable {
            /// The state as the API names it.
            public let rawValue: String

            /// Creates a state, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Space for the snapshot has been reserved.
            public static let allocated = State(rawValue: "allocated")
            /// Being created.
            public static let creating = State(rawValue: "creating")
            /// Ready.
            public static let created = State(rawValue: "created")
            /// Being turned into a volume.
            public static let promoting = State(rawValue: "promoting")
            /// Being deleted.
            public static let destroying = State(rawValue: "destroying")
            /// Partly deleted.
            public static let partiallyDestroyed = State(rawValue: "partially-destroyed")
            /// Deleted.
            public static let destroyed = State(rawValue: "destroyed")
            /// In an error state.
            public static let error = State(rawValue: "error")
        }
    }

    /// Block storage volumes and their snapshots.
    struct BlockStorage: Sendable {
        let client: HTTPClient

        // MARK: Volumes

        /// Lists volumes.
        ///
        /// - Parameter instanceID: Only volumes attached to this instance.
        public func list(instanceID: String? = nil) async throws -> [BlockStorageVolume] {
            try await client.send(
                .get,
                "/block-storage",
                query: ["instance-id": instanceID],
                unwrapping: "block-storage-volumes"
            )
        }

        /// Retrieves a volume.
        public func get(id: String) async throws -> BlockStorageVolume {
            try await client.send(.get, "/block-storage/\(id)")
        }

        /// Creates a volume, empty or from a snapshot.
        ///
        /// - Parameters:
        ///   - name: The volume's name.
        ///   - size: The volume's size, in GiB. Defaults to the snapshot's volume size.
        ///   - snapshotID: The snapshot to restore into the new volume.
        ///   - labels: Labels to attach.
        public func create(
            name: String? = nil,
            size: Int? = nil,
            fromSnapshot snapshotID: String? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/block-storage", body: [
                "name": name,
                "size": size,
                "block-storage-snapshot": snapshotID.map { ["id": $0] },
                "labels": labels
            ] as JSONBody)
        }

        /// Updates a volume's name or labels.
        public func update(id: String, name: String? = nil, labels: [String: String]? = nil) async throws -> Operation {
            try await client.send(.put, "/block-storage/\(id)", body: ["name": name, "labels": labels] as JSONBody)
        }

        /// Grows a volume. Volumes can't shrink.
        ///
        /// - Returns: The resized volume.
        public func resize(id: String, size: Int) async throws -> BlockStorageVolume {
            try await client.send(.put, "/block-storage/\(id):resize-volume", body: ["size": size] as JSONBody)
        }

        /// Deletes a volume and its data, which can't be recovered.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/block-storage/\(id)")
        }

        /// Attaches a volume to an instance.
        public func attach(id: String, toInstance instanceID: String) async throws -> Operation {
            try await client.send(
                .put,
                "/block-storage/\(id):attach",
                body: ["instance": ["id": instanceID]] as JSONBody
            )
        }

        /// Detaches a volume from its instance.
        public func detach(id: String) async throws -> Operation {
            try await client.send(.put, "/block-storage/\(id):detach")
        }

        // MARK: Snapshots

        /// Takes a snapshot of a volume.
        public func createSnapshot(
            of id: String,
            name: String? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/block-storage/\(id):create-snapshot", body: [
                "name": name,
                "labels": labels
            ] as JSONBody)
        }

        /// Lists volume snapshots.
        public func snapshots() async throws -> [BlockStorageSnapshot] {
            try await client.send(.get, "/block-storage-snapshot", unwrapping: "block-storage-snapshots")
        }

        /// Retrieves a volume snapshot.
        public func snapshot(id: String) async throws -> BlockStorageSnapshot {
            try await client.send(.get, "/block-storage-snapshot/\(id)")
        }

        /// Updates a volume snapshot's name or labels.
        public func updateSnapshot(
            id: String,
            name: String? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(
                .put,
                "/block-storage-snapshot/\(id)",
                body: ["name": name, "labels": labels] as JSONBody
            )
        }

        /// Deletes a volume snapshot, which can't be recovered.
        public func deleteSnapshot(id: String) async throws -> Operation {
            try await client.send(.delete, "/block-storage-snapshot/\(id)")
        }
    }
}
