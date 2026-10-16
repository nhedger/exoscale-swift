import Foundation

/// Access to snapshot API operations.
public struct SnapshotsResource: Sendable {
    let http: Http.Client

    /// Lists snapshots.
    ///
    /// - Returns: The snapshots returned by the API.
    public func list() async throws -> [Exoscale.Snapshot] {
        try await http.execute(SnapshotsOperations.List(request: .init()))
    }

    /// Retrieves a snapshot by identifier.
    ///
    /// - Parameter id: The snapshot identifier.
    /// - Returns: The snapshot returned by the API.
    public func get(id: String) async throws -> Exoscale.Snapshot {
        try await http.execute(SnapshotsOperations.Get(request: .init(id: id)))
    }

    /// Deletes a snapshot.
    ///
    /// - Parameter id: The snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(SnapshotsOperations.Delete(request: .init(id: id)))
    }

    /// Exports a snapshot.
    ///
    /// - Parameter id: The snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func export(id: String) async throws -> Exoscale.Operation {
        try await http.execute(SnapshotsOperations.Export(request: .init(id: id)))
    }

    /// Promotes a snapshot to a template.
    ///
    /// - Parameters:
    ///   - id: The snapshot identifier.
    ///   - name: The template name.
    ///   - description: Optional template description.
    ///   - defaultUser: Optional template default user.
    ///   - sshKeyEnabled: Optional flag enabling SSH key-based login.
    ///   - passwordEnabled: Optional flag enabling password-based login.
    /// - Returns: The asynchronous operation returned by the API.
    public func promote(
        id: String,
        name: String,
        description: String? = nil,
        defaultUser: String? = nil,
        sshKeyEnabled: Bool? = nil,
        passwordEnabled: Bool? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            SnapshotsOperations.Promote(
                request: .init(
                    id: id,
                    name: name,
                    description: description,
                    defaultUser: defaultUser,
                    sshKeyEnabled: sshKeyEnabled,
                    passwordEnabled: passwordEnabled
                )
            )
        )
    }
}
