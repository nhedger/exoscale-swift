import Foundation

/// Access to anti-affinity group API operations.
public struct AntiAffinityGroupsResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists anti-affinity groups.
    ///
    /// - Returns: The anti-affinity groups returned by the API.
    public func list() async throws -> [Exoscale.AntiAffinityGroup] {
        let response = try await http.get(path: "/anti-affinity-group", as: ListAntiAffinityGroupsResponse.self)
        return response.antiAffinityGroups
    }

    /// Creates an anti-affinity group.
    ///
    /// - Parameters:
    ///   - name: The anti-affinity group name.
    ///   - description: Optional anti-affinity group description.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        name: String,
        description: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateAntiAffinityGroupRequest(
                name: name,
                description: description
            )
        )

        return try await http.post(path: "/anti-affinity-group", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves an anti-affinity group by identifier.
    ///
    /// - Parameter id: The anti-affinity group identifier.
    /// - Returns: The anti-affinity group returned by the API.
    public func get(id: String) async throws -> Exoscale.AntiAffinityGroup {
        try await http.get(path: "/anti-affinity-group/\(id)", as: Exoscale.AntiAffinityGroup.self)
    }

    /// Deletes an anti-affinity group.
    ///
    /// - Parameter id: The anti-affinity group identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/anti-affinity-group/\(id)", as: Exoscale.Operation.self)
    }
}
