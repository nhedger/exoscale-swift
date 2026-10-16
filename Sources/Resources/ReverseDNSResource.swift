import Foundation

/// Access to reverse DNS API operations.
public struct ReverseDNSResource: Sendable {
    let http: Http.Client

    /// Queries the PTR DNS record for an Elastic IP.
    ///
    /// - Parameter id: The Elastic IP identifier.
    /// - Returns: The PTR DNS record returned by the API.
    public func getElasticIP(id: String) async throws -> Exoscale.ReverseDNSRecord {
        try await http.execute(ReverseDNSOperations.GetElasticIP(request: .init(id: id)))
    }

    /// Creates or updates the PTR DNS record for an Elastic IP.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - domainName: The PTR target domain name.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateElasticIP(id: String, domainName: String) async throws -> Exoscale.Operation {
        try await http.execute(ReverseDNSOperations.UpdateElasticIP(request: .init(id: id, domainName: domainName)))
    }

    /// Deletes the PTR DNS record for an Elastic IP.
    ///
    /// - Parameter id: The Elastic IP identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteElasticIP(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ReverseDNSOperations.DeleteElasticIP(request: .init(id: id)))
    }

    /// Queries the PTR DNS record for an instance.
    ///
    /// - Parameter id: The instance identifier.
    /// - Returns: The PTR DNS record returned by the API.
    public func getInstance(id: String) async throws -> Exoscale.ReverseDNSRecord {
        try await http.execute(ReverseDNSOperations.GetInstance(request: .init(id: id)))
    }

    /// Creates or updates the PTR DNS record for an instance.
    ///
    /// - Parameters:
    ///   - id: The instance identifier.
    ///   - domainName: The PTR target domain name.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateInstance(id: String, domainName: String) async throws -> Exoscale.Operation {
        try await http.execute(ReverseDNSOperations.UpdateInstance(request: .init(id: id, domainName: domainName)))
    }

    /// Deletes the PTR DNS record for an instance.
    ///
    /// - Parameter id: The instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteInstance(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ReverseDNSOperations.DeleteInstance(request: .init(id: id)))
    }
}
