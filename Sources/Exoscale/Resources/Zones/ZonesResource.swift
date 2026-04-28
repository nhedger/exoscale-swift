/// Access to zone-related API operations.
public struct ZonesResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists the zones available through the Exoscale API.
    ///
    /// - Returns: The list of Exoscale zones
    public func list() async throws -> [Exoscale.Zone] {
        let response = try await http.get(path: "/zone", as: ListZonesResponse.self)
        return response.zones
    }
}
