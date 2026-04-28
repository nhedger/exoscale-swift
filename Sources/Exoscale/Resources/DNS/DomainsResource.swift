import Foundation

/// Access to DNS domain API operations.
public struct DomainsResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists DNS domains.
    ///
    /// - Returns: The DNS domains returned by the API.
    public func list() async throws -> [Exoscale.Domain] {
        let response = try await http.get(path: "/dns-domain", as: ListDomainsResponse.self)
        return response.domains
    }

    /// Creates a DNS domain.
    ///
    /// - Parameter unicodeName: The DNS domain name.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(unicodeName: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateDomainRequest(unicodeName: unicodeName))

        return try await http.post(
            path: "/dns-domain",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Retrieves a DNS domain by identifier.
    ///
    /// - Parameter id: The DNS domain identifier.
    /// - Returns: The DNS domain returned by the API.
    public func get(id: String) async throws -> Exoscale.Domain {
        try await http.get(path: "/dns-domain/\(id)", as: Exoscale.Domain.self)
    }

    /// Deletes a DNS domain by identifier.
    ///
    /// - Parameter id: The DNS domain identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dns-domain/\(id)", as: Exoscale.Operation.self)
    }

    /// Retrieves the zone file for a DNS domain.
    ///
    /// - Parameter id: The DNS domain identifier.
    /// - Returns: The zone file returned by the API.
    public func zoneFile(id: String) async throws -> String {
        let response = try await http.get(path: "/dns-domain/\(id)/zone", as: DomainZoneFileResponse.self)
        return response.zoneFile
    }
}
