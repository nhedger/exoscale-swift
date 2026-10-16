/// Access to quota API operations.
public struct QuotasResource: Sendable {
    let http: Http.Client

    /// Lists organization quotas available in the configured zone.
    ///
    /// - Returns: The list of quotas returned by the API.
    public func list() async throws -> [Exoscale.Quota] {
        try await http.execute(QuotasOperations.List(request: .init()))
    }

    /// Retrieves a quota for a specific resource entity.
    ///
    /// - Parameter entity: The resource entity name.
    /// - Returns: The quota returned by the API.
    public func get(entity: String) async throws -> Exoscale.Quota {
        try await http.execute(QuotasOperations.Get(request: .init(entity: entity)))
    }
}
