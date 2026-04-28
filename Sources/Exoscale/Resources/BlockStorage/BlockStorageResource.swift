import Foundation

/// Access to block storage API operations.
public struct BlockStorageResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists block storage volumes.
    ///
    /// - Parameter instanceID: Optional compute instance identifier to filter attached volumes.
    /// - Returns: The block storage volumes returned by the API.
    public func listVolumes(instanceID: String? = nil) async throws -> [Exoscale.BlockStorageVolume] {
        var query: [String: String?] = [:]

        if let instanceID {
            query["instance-id"] = instanceID
        }

        let response = try await http.get(
            path: "/block-storage",
            query: query,
            as: ListBlockStorageVolumesResponse.self
        )
        return response.blockStorageVolumes
    }

    /// Creates a block storage volume.
    ///
    /// - Parameters:
    ///   - name: Optional block storage volume name.
    ///   - size: Optional block storage volume size in GiB.
    ///   - labels: Optional block storage volume labels.
    ///   - snapshotID: Optional source block storage snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func createVolume(
        name: String? = nil,
        size: Int? = nil,
        labels: [String: String]? = nil,
        snapshotID: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateBlockStorageVolumeRequest(
                name: name,
                size: size,
                labels: labels,
                blockStorageSnapshot: snapshotID.map(BlockStorageSnapshotReference.init(id:))
            )
        )

        return try await http.post(path: "/block-storage", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves a block storage volume by identifier.
    ///
    /// - Parameter id: The block storage volume identifier.
    /// - Returns: The block storage volume returned by the API.
    public func getVolume(id: String) async throws -> Exoscale.BlockStorageVolume {
        try await http.get(path: "/block-storage/\(id)", as: Exoscale.BlockStorageVolume.self)
    }

    /// Updates a block storage volume.
    ///
    /// - Parameters:
    ///   - id: The block storage volume identifier.
    ///   - name: Optional block storage volume name.
    ///   - labels: Optional block storage volume labels.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateVolume(
        id: String,
        name: String? = nil,
        labels: [String: String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpdateBlockStorageVolumeRequest(name: name, labels: labels))
        return try await http.put(path: "/block-storage/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a block storage volume.
    ///
    /// - Parameter id: The block storage volume identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteVolume(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/block-storage/\(id)", as: Exoscale.Operation.self)
    }

    /// Attaches a block storage volume to a compute instance.
    ///
    /// - Parameters:
    ///   - id: The block storage volume identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func attachVolume(id: String, instanceID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            AttachBlockStorageVolumeRequest(instance: InstanceIDReference(id: instanceID))
        )
        return try await http.put(path: "/block-storage/\(id):attach", body: body, as: Exoscale.Operation.self)
    }

    /// Detaches a block storage volume.
    ///
    /// - Parameter id: The block storage volume identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func detachVolume(id: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/block-storage/\(id):detach", as: Exoscale.Operation.self)
    }

    /// Resizes a block storage volume.
    ///
    /// - Parameters:
    ///   - id: The block storage volume identifier.
    ///   - size: The target block storage volume size in GiB.
    /// - Returns: The resized block storage volume returned by the API.
    public func resizeVolume(id: String, size: Int) async throws -> Exoscale.BlockStorageVolume {
        let body = try JSONEncoder().encode(ResizeBlockStorageVolumeRequest(size: size))
        return try await http.put(path: "/block-storage/\(id):resize-volume", body: body, as: Exoscale.BlockStorageVolume.self)
    }

    /// Creates a block storage snapshot from a volume.
    ///
    /// - Parameters:
    ///   - volumeID: The source block storage volume identifier.
    ///   - name: Optional block storage snapshot name.
    ///   - labels: Optional block storage snapshot labels.
    /// - Returns: The asynchronous operation returned by the API.
    public func createSnapshot(
        volumeID: String,
        name: String? = nil,
        labels: [String: String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateBlockStorageSnapshotRequest(name: name, labels: labels))
        return try await http.post(path: "/block-storage/\(volumeID):create-snapshot", body: body, as: Exoscale.Operation.self)
    }

    /// Lists block storage snapshots.
    ///
    /// - Returns: The block storage snapshots returned by the API.
    public func listSnapshots() async throws -> [Exoscale.BlockStorageSnapshot] {
        let response = try await http.get(
            path: "/block-storage-snapshot",
            as: ListBlockStorageSnapshotsResponse.self
        )
        return response.blockStorageSnapshots
    }

    /// Retrieves a block storage snapshot by identifier.
    ///
    /// - Parameter id: The block storage snapshot identifier.
    /// - Returns: The block storage snapshot returned by the API.
    public func getSnapshot(id: String) async throws -> Exoscale.BlockStorageSnapshot {
        try await http.get(path: "/block-storage-snapshot/\(id)", as: Exoscale.BlockStorageSnapshot.self)
    }

    /// Updates a block storage snapshot.
    ///
    /// - Parameters:
    ///   - id: The block storage snapshot identifier.
    ///   - name: Optional block storage snapshot name.
    ///   - labels: Optional block storage snapshot labels.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateSnapshot(
        id: String,
        name: String? = nil,
        labels: [String: String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpdateBlockStorageSnapshotRequest(name: name, labels: labels))
        return try await http.put(path: "/block-storage-snapshot/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a block storage snapshot.
    ///
    /// - Parameter id: The block storage snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteSnapshot(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/block-storage-snapshot/\(id)", as: Exoscale.Operation.self)
    }
}
