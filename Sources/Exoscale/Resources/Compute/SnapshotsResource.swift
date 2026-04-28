import Foundation

/// Access to snapshot API operations.
public struct SnapshotsResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists snapshots.
    ///
    /// - Returns: The snapshots returned by the API.
    public func list() async throws -> [Exoscale.Snapshot] {
        let response = try await http.get(path: "/snapshot", as: ListSnapshotsResponse.self)
        return response.snapshots
    }

    /// Retrieves a snapshot by identifier.
    ///
    /// - Parameter id: The snapshot identifier.
    /// - Returns: The snapshot returned by the API.
    public func get(id: String) async throws -> Exoscale.Snapshot {
        try await http.get(path: "/snapshot/\(id)", as: Exoscale.Snapshot.self)
    }

    /// Deletes a snapshot.
    ///
    /// - Parameter id: The snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/snapshot/\(id)", as: Exoscale.Operation.self)
    }

    /// Exports a snapshot.
    ///
    /// - Parameter id: The snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func export(id: String) async throws -> Exoscale.Operation {
        try await http.post(path: "/snapshot/\(id):export", as: Exoscale.Operation.self)
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
        let body = try JSONEncoder().encode(
            PromoteSnapshotRequest(
                name: name,
                description: description,
                defaultUser: defaultUser,
                sshKeyEnabled: sshKeyEnabled,
                passwordEnabled: passwordEnabled
            )
        )

        return try await http.post(path: "/snapshot/\(id):promote", body: body, as: Exoscale.Operation.self)
    }
}
