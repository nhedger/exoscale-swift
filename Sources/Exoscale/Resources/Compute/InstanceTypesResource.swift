/// Access to compute instance type API operations.
public struct InstanceTypesResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists compute instance types available in the configured zone.
    ///
    /// - Returns: The list of compute instance types returned by the API.
    public func list() async throws -> [Exoscale.InstanceType] {
        let response = try await http.get(path: "/instance-type", as: ListInstanceTypesResponse.self)
        return response.instanceTypes
    }

    /// Retrieves a compute instance type by identifier.
    ///
    /// - Parameter id: The compute instance type identifier.
    /// - Returns: The compute instance type returned by the API.
    public func get(id: String) async throws -> Exoscale.InstanceType {
        try await http.get(path: "/instance-type/\(id)", as: Exoscale.InstanceType.self)
    }
}
