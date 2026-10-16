/// Access to compute instance type API operations.
public struct InstanceTypesResource: Sendable {
    let http: Http.Client

    /// Lists compute instance types available in the configured zone.
    ///
    /// - Returns: The list of compute instance types returned by the API.
    public func list() async throws -> [Exoscale.InstanceType] {
        try await http.execute(InstanceTypesOperations.List(request: .init()))
    }

    /// Retrieves a compute instance type by identifier.
    ///
    /// - Parameter id: The compute instance type identifier.
    /// - Returns: The compute instance type returned by the API.
    public func get(id: String) async throws -> Exoscale.InstanceType {
        try await http.execute(InstanceTypesOperations.Get(request: .init(id: id)))
    }
}
