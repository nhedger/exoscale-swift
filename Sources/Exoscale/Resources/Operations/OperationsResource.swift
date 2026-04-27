/// Access to operation API operations.
public struct OperationsResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves an operation by identifier.
    ///
    /// - Parameter id: The operation identifier.
    /// - Returns: The operation returned by the API.
    public func get(id: String) async throws -> Exoscale.Operation {
        try await http.get(path: "/operation/\(id)", as: Exoscale.Operation.self)
    }
}
