import Foundation

/// Access to anti-affinity group API operations.
public struct AntiAffinityGroupsResource: Sendable {
    let http: Http.Client

    /// Lists anti-affinity groups.
    ///
    /// - Returns: The anti-affinity groups returned by the API.
    public func list() async throws -> [Exoscale.AntiAffinityGroup] {
        try await http.execute(AntiAffinityGroupsOperations.List(request: .init()))
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
        try await http.execute(AntiAffinityGroupsOperations.Create(request: .init(
            name: name,
            description: description
        )))
    }

    /// Retrieves an anti-affinity group by identifier.
    ///
    /// - Parameter id: The anti-affinity group identifier.
    /// - Returns: The anti-affinity group returned by the API.
    public func get(id: String) async throws -> Exoscale.AntiAffinityGroup {
        try await http.execute(AntiAffinityGroupsOperations.Get(request: .init(id: id)))
    }

    /// Deletes an anti-affinity group.
    ///
    /// - Parameter id: The anti-affinity group identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(AntiAffinityGroupsOperations.Delete(request: .init(id: id)))
    }
}
