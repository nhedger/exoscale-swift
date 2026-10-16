import Foundation

/// Access to block storage API operations.
public struct BlockStorageResource: Sendable {
    let http: Http.Client

    /// Lists block storage volumes.
    ///
    /// - Parameter instanceID: Optional compute instance identifier to filter attached volumes.
    /// - Returns: The block storage volumes returned by the API.
    public func listVolumes(instanceID: String? = nil) async throws -> [Exoscale.BlockStorageVolume] {
        try await http.execute(BlockStorageOperations.ListVolumes(request: .init(instanceID: instanceID)))
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
        try await http.execute(
            BlockStorageOperations.CreateVolume(
                request: .init(name: name, size: size, labels: labels, snapshotID: snapshotID)
            )
        )
    }

    /// Retrieves a block storage volume by identifier.
    ///
    /// - Parameter id: The block storage volume identifier.
    /// - Returns: The block storage volume returned by the API.
    public func getVolume(id: String) async throws -> Exoscale.BlockStorageVolume {
        try await http.execute(BlockStorageOperations.GetVolume(request: .init(id: id)))
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
        try await http.execute(BlockStorageOperations.UpdateVolume(request: .init(id: id, name: name, labels: labels)))
    }

    /// Deletes a block storage volume.
    ///
    /// - Parameter id: The block storage volume identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteVolume(id: String) async throws -> Exoscale.Operation {
        try await http.execute(BlockStorageOperations.DeleteVolume(request: .init(id: id)))
    }

    /// Attaches a block storage volume to a compute instance.
    ///
    /// - Parameters:
    ///   - id: The block storage volume identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func attachVolume(id: String, instanceID: String) async throws -> Exoscale.Operation {
        try await http.execute(BlockStorageOperations.AttachVolume(request: .init(id: id, instanceID: instanceID)))
    }

    /// Detaches a block storage volume.
    ///
    /// - Parameter id: The block storage volume identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func detachVolume(id: String) async throws -> Exoscale.Operation {
        try await http.execute(BlockStorageOperations.DetachVolume(request: .init(id: id)))
    }

    /// Resizes a block storage volume.
    ///
    /// - Parameters:
    ///   - id: The block storage volume identifier.
    ///   - size: The target block storage volume size in GiB.
    /// - Returns: The resized block storage volume returned by the API.
    public func resizeVolume(id: String, size: Int) async throws -> Exoscale.BlockStorageVolume {
        try await http.execute(BlockStorageOperations.ResizeVolume(request: .init(id: id, size: size)))
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
        try await http.execute(
            BlockStorageOperations.CreateSnapshot(request: .init(volumeID: volumeID, name: name, labels: labels))
        )
    }

    /// Lists block storage snapshots.
    ///
    /// - Returns: The block storage snapshots returned by the API.
    public func listSnapshots() async throws -> [Exoscale.BlockStorageSnapshot] {
        try await http.execute(BlockStorageOperations.ListSnapshots(request: .init()))
    }

    /// Retrieves a block storage snapshot by identifier.
    ///
    /// - Parameter id: The block storage snapshot identifier.
    /// - Returns: The block storage snapshot returned by the API.
    public func getSnapshot(id: String) async throws -> Exoscale.BlockStorageSnapshot {
        try await http.execute(BlockStorageOperations.GetSnapshot(request: .init(id: id)))
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
        try await http.execute(BlockStorageOperations.UpdateSnapshot(request: .init(
            id: id,
            name: name,
            labels: labels
        )))
    }

    /// Deletes a block storage snapshot.
    ///
    /// - Parameter id: The block storage snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteSnapshot(id: String) async throws -> Exoscale.Operation {
        try await http.execute(BlockStorageOperations.DeleteSnapshot(request: .init(id: id)))
    }
}
