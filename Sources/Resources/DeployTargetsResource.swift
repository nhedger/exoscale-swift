/// Access to Deploy Target API operations.
public struct DeployTargetsResource: Sendable {
    let http: Http.Client

    /// Lists Deploy Targets.
    ///
    /// - Returns: The Deploy Targets returned by the API.
    public func list() async throws -> [Exoscale.DeployTarget] {
        try await http.execute(DeployTargetsOperations.List(request: .init()))
    }

    /// Retrieves a Deploy Target by identifier.
    ///
    /// - Parameter id: The Deploy Target identifier.
    /// - Returns: The Deploy Target returned by the API.
    public func get(id: String) async throws -> Exoscale.DeployTarget {
        try await http.execute(DeployTargetsOperations.Get(request: .init(id: id)))
    }
}
