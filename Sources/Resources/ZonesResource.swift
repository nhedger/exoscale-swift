/// Access to zone-related API operations.
public struct ZonesResource: Sendable {
    let http: Http.Client

    /// Lists the zones available through the Exoscale API.
    ///
    /// - Returns: The list of Exoscale zones
    public func list() async throws -> [Exoscale.Zone] {
        try await http.execute(ZonesOperations.List(request: .init()))
    }
}
