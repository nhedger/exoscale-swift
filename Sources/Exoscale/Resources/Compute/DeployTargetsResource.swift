/// Access to Deploy Target API operations.
public struct DeployTargetsResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists Deploy Targets.
    ///
    /// - Returns: The Deploy Targets returned by the API.
    public func list() async throws -> [Exoscale.DeployTarget] {
        let response = try await http.get(path: "/deploy-target", as: ListDeployTargetsResponse.self)
        return response.deployTargets
    }

    /// Retrieves a Deploy Target by identifier.
    ///
    /// - Parameter id: The Deploy Target identifier.
    /// - Returns: The Deploy Target returned by the API.
    public func get(id: String) async throws -> Exoscale.DeployTarget {
        try await http.get(path: "/deploy-target/\(id)", as: Exoscale.DeployTarget.self)
    }
}
