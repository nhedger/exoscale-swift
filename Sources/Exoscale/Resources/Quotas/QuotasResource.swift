/// Access to quota API operations.
public struct QuotasResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists organization quotas available in the configured zone.
    ///
    /// - Returns: The list of quotas returned by the API.
    public func list() async throws -> [Exoscale.Quota] {
        let response = try await http.get(path: "/quota", as: ListQuotasResponse.self)
        return response.quotas
    }

    /// Retrieves a quota for a specific resource entity.
    ///
    /// - Parameter entity: The resource entity name.
    /// - Returns: The quota returned by the API.
    public func get(entity: String) async throws -> Exoscale.Quota {
        try await http.get(path: "/quota/\(entity)", as: Exoscale.Quota.self)
    }
}
