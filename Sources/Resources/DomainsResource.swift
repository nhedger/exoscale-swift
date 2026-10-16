import Foundation

/// Access to DNS domain API operations.
public struct DomainsResource: Sendable {
    let http: Http.Client

    /// Lists DNS domains.
    ///
    /// - Returns: The DNS domains returned by the API.
    public func list() async throws -> [Exoscale.Domain] {
        try await http.execute(DomainsOperations.List(request: .init()))
    }

    /// Creates a DNS domain.
    ///
    /// - Parameter unicodeName: The DNS domain name.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(unicodeName: String) async throws -> Exoscale.Operation {
        try await http.execute(DomainsOperations.Create(request: .init(unicodeName: unicodeName)))
    }

    /// Retrieves a DNS domain by identifier.
    ///
    /// - Parameter id: The DNS domain identifier.
    /// - Returns: The DNS domain returned by the API.
    public func get(id: String) async throws -> Exoscale.Domain {
        try await http.execute(DomainsOperations.Get(request: .init(id: id)))
    }

    /// Deletes a DNS domain by identifier.
    ///
    /// - Parameter id: The DNS domain identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(DomainsOperations.Delete(request: .init(id: id)))
    }

    /// Retrieves the zone file for a DNS domain.
    ///
    /// - Parameter id: The DNS domain identifier.
    /// - Returns: The zone file returned by the API.
    public func zoneFile(id: String) async throws -> String {
        try await http.execute(DomainsOperations.ZoneFile(request: .init(id: id)))
    }
}
