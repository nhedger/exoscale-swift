import Foundation

/// Access to reverse DNS API operations.
public struct ReverseDNSResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Queries the PTR DNS record for an Elastic IP.
    ///
    /// - Parameter id: The Elastic IP identifier.
    /// - Returns: The PTR DNS record returned by the API.
    public func getElasticIP(id: String) async throws -> Exoscale.ReverseDNSRecord {
        try await http.get(path: "/reverse-dns/elastic-ip/\(id)", as: Exoscale.ReverseDNSRecord.self)
    }

    /// Creates or updates the PTR DNS record for an Elastic IP.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - domainName: The PTR target domain name.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateElasticIP(id: String, domainName: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpdateReverseDNSRecordRequest(domainName: domainName))
        return try await http.post(
            path: "/reverse-dns/elastic-ip/\(id)",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Deletes the PTR DNS record for an Elastic IP.
    ///
    /// - Parameter id: The Elastic IP identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteElasticIP(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/reverse-dns/elastic-ip/\(id)", as: Exoscale.Operation.self)
    }

    /// Queries the PTR DNS record for an instance.
    ///
    /// - Parameter id: The instance identifier.
    /// - Returns: The PTR DNS record returned by the API.
    public func getInstance(id: String) async throws -> Exoscale.ReverseDNSRecord {
        try await http.get(path: "/reverse-dns/instance/\(id)", as: Exoscale.ReverseDNSRecord.self)
    }

    /// Creates or updates the PTR DNS record for an instance.
    ///
    /// - Parameters:
    ///   - id: The instance identifier.
    ///   - domainName: The PTR target domain name.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateInstance(id: String, domainName: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpdateReverseDNSRecordRequest(domainName: domainName))
        return try await http.post(
            path: "/reverse-dns/instance/\(id)",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Deletes the PTR DNS record for an instance.
    ///
    /// - Parameter id: The instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteInstance(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/reverse-dns/instance/\(id)", as: Exoscale.Operation.self)
    }
}
