import Foundation

/// Access to DNS record API operations.
public struct RecordsResource: Sendable {
    let http: Http.Client

    /// Lists DNS domain records for a domain.
    ///
    /// - Parameter domainID: The DNS domain identifier.
    /// - Returns: The DNS domain records returned by the API.
    public func list(domainID: String) async throws -> [Exoscale.Record] {
        try await http.execute(RecordsOperations.List(request: .init(domainID: domainID)))
    }

    /// Creates a DNS domain record.
    ///
    /// - Parameters:
    ///   - domainID: The DNS domain identifier.
    ///   - name: The DNS domain record name.
    ///   - type: The DNS domain record type.
    ///   - content: The DNS domain record content.
    ///   - ttl: Optional DNS domain record TTL.
    ///   - priority: Optional DNS domain record priority.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        domainID: String,
        name: String,
        type: Exoscale.Record.RecordType,
        content: String,
        ttl: Int? = nil,
        priority: Int? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            RecordsOperations.Create(
                request: .init(
                    domainID: domainID,
                    name: name,
                    type: type,
                    content: content,
                    ttl: ttl,
                    priority: priority
                )
            )
        )
    }

    /// Retrieves a DNS domain record by identifier.
    ///
    /// - Parameters:
    ///   - domainID: The DNS domain identifier.
    ///   - recordID: The DNS domain record identifier.
    /// - Returns: The DNS domain record returned by the API.
    public func get(domainID: String, recordID: String) async throws -> Exoscale.Record {
        try await http.execute(RecordsOperations.Get(request: .init(domainID: domainID, recordID: recordID)))
    }

    /// Updates a DNS domain record.
    ///
    /// - Parameters:
    ///   - domainID: The DNS domain identifier.
    ///   - recordID: The DNS domain record identifier.
    ///   - name: Optional DNS domain record name.
    ///   - content: Optional DNS domain record content.
    ///   - ttl: Optional DNS domain record TTL.
    ///   - priority: Optional DNS domain record priority.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        domainID: String,
        recordID: String,
        name: String? = nil,
        content: String? = nil,
        ttl: Int? = nil,
        priority: Int? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            RecordsOperations.Update(
                request: .init(
                    domainID: domainID,
                    recordID: recordID,
                    name: name,
                    content: content,
                    ttl: ttl,
                    priority: priority
                )
            )
        )
    }

    /// Deletes a DNS domain record by identifier.
    ///
    /// - Parameters:
    ///   - domainID: The DNS domain identifier.
    ///   - recordID: The DNS domain record identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(domainID: String, recordID: String) async throws -> Exoscale.Operation {
        try await http.execute(RecordsOperations.Delete(request: .init(domainID: domainID, recordID: recordID)))
    }
}
