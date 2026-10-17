import Foundation

public extension Exoscale {
    /// A snapshot of an instance's root disk.
    struct Snapshot: Hashable, Codable, Sendable {
        /// The snapshot's identifier.
        public let id: String
        /// The snapshot's name.
        public let name: String?
        /// Whether the snapshot is ready, being taken or exported.
        public let state: State?
        /// The snapshot's size, in GiB.
        public let size: Int?
        /// When the snapshot was taken.
        public let createdAt: Date?
        /// The instance the snapshot was taken from.
        public let instance: Reference<Instance>?
        /// Whether the guest flushed its file systems before the snapshot was taken.
        public let applicationConsistent: Bool?
        /// Where to download the snapshot once it's exported.
        public let export: Export?

        /// Creates a snapshot, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            state: State? = nil,
            size: Int? = nil,
            createdAt: Date? = nil,
            instance: Reference<Instance>? = nil,
            applicationConsistent: Bool? = nil,
            export: Export? = nil
        ) {
            self.id = id
            self.name = name
            self.state = state
            self.size = size
            self.createdAt = createdAt
            self.instance = instance
            self.applicationConsistent = applicationConsistent
            self.export = export
        }

        enum CodingKeys: String, CodingKey {
            case id, name, state, size, instance, export
            case createdAt = "created-at"
            case applicationConsistent = "application-consistent"
        }
    }
}

public extension Exoscale.Snapshot {
    /// The state of a snapshot.
    struct State: RawRepresentable, Hashable, Codable, Sendable {
        /// The state as the API names it.
        public let rawValue: String

        /// Creates a state, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The snapshot is being taken.
        public static let snapshotting = State(rawValue: "snapshotting")
        /// The snapshot is ready.
        public static let ready = State(rawValue: "ready")
        /// The snapshot is being exported.
        public static let exporting = State(rawValue: "exporting")
        /// The snapshot has been exported.
        public static let exported = State(rawValue: "exported")
        /// The snapshot is being deleted.
        public static let deleting = State(rawValue: "deleting")
        /// The snapshot has been deleted.
        public static let deleted = State(rawValue: "deleted")
        /// The snapshot is in an error state.
        public static let error = State(rawValue: "error")
    }

    /// Where to download an exported snapshot.
    struct Export: Hashable, Codable, Sendable {
        /// A pre-signed URL to download the image from.
        public let presignedURL: String?
        /// The image's MD5 checksum.
        public let md5sum: String?

        /// Creates an export, for example for previews and tests.
        public init(presignedURL: String? = nil, md5sum: String? = nil) {
            self.presignedURL = presignedURL
            self.md5sum = md5sum
        }

        enum CodingKeys: String, CodingKey {
            case md5sum
            case presignedURL = "presigned-url"
        }
    }
}

public extension Exoscale {
    /// Snapshots of instances' root disks. Take one with ``Instances/createSnapshot(id:)``.
    struct Snapshots: Sendable {
        let client: HTTPClient

        /// Lists the snapshots.
        public func list() async throws -> [Snapshot] {
            try await client.send(.get, "/snapshot", unwrapping: "snapshots")
        }

        /// Retrieves a snapshot.
        public func get(id: String) async throws -> Snapshot {
            try await client.send(.get, "/snapshot/\(id)")
        }

        /// Exports a snapshot so it can be downloaded. Its ``Snapshot/export`` then holds the URL.
        public func export(id: String) async throws -> Operation {
            try await client.send(.post, "/snapshot/\(id):export")
        }

        /// Creates a template from a snapshot.
        ///
        /// - Parameters:
        ///   - name: The template's name.
        ///   - description: The template's description.
        ///   - defaultUser: The user to log in as.
        ///   - sshKeyEnabled: Whether to install SSH keys on instances created from the template.
        ///   - passwordEnabled: Whether to generate a password for instances created from it.
        public func promote(
            id: String,
            name: String,
            description: String? = nil,
            defaultUser: String? = nil,
            sshKeyEnabled: Bool? = nil,
            passwordEnabled: Bool? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/snapshot/\(id):promote", body: [
                "name": name,
                "description": description,
                "default-user": defaultUser,
                "ssh-key-enabled": sshKeyEnabled,
                "password-enabled": passwordEnabled
            ] as JSONBody)
        }

        /// Deletes a snapshot.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/snapshot/\(id)")
        }
    }
}
