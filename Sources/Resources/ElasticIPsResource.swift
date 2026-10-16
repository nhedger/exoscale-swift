import Foundation

/// Access to Elastic IP API operations.
public struct ElasticIPsResource: Sendable {
    public enum Field: String, Sendable {
        case description
    }

    let http: Http.Client

    /// Lists Elastic IPs.
    ///
    /// - Returns: The Elastic IPs returned by the API.
    public func list() async throws -> [Exoscale.ElasticIP] {
        try await http.execute(ElasticIPsOperations.List(request: .init()))
    }

    /// Creates an Elastic IP.
    ///
    /// - Parameters:
    ///   - addressFamily: Optional Elastic IP address family.
    ///   - description: Optional Elastic IP description.
    ///   - healthcheck: Optional Elastic IP healthcheck configuration.
    ///   - labels: Optional Elastic IP labels.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        addressFamily: Exoscale.ElasticIP.AddressFamily? = nil,
        description: String? = nil,
        healthcheck: Exoscale.ElasticIP.Healthcheck? = nil,
        labels: [String: String]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            ElasticIPsOperations.Create(
                request: .init(
                    addressFamily: addressFamily,
                    description: description,
                    healthcheck: healthcheck,
                    labels: labels
                )
            )
        )
    }

    /// Retrieves an Elastic IP by identifier.
    ///
    /// - Parameter id: The Elastic IP identifier.
    /// - Returns: The Elastic IP returned by the API.
    public func get(id: String) async throws -> Exoscale.ElasticIP {
        try await http.execute(ElasticIPsOperations.Get(request: .init(id: id)))
    }

    /// Updates an Elastic IP.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - description: Optional Elastic IP description.
    ///   - healthcheck: Optional Elastic IP healthcheck configuration.
    ///   - labels: Optional Elastic IP labels.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        description: String? = nil,
        healthcheck: Exoscale.ElasticIP.Healthcheck? = nil,
        labels: [String: String]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            ElasticIPsOperations.Update(
                request: .init(id: id, description: description, healthcheck: healthcheck, labels: labels)
            )
        )
    }

    /// Deletes an Elastic IP.
    ///
    /// - Parameter id: The Elastic IP identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(ElasticIPsOperations.Delete(request: .init(id: id)))
    }

    /// Resets an Elastic IP field to its default value.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - field: The Elastic IP field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetField(id: String, field: Field) async throws -> Exoscale.Operation {
        try await http.execute(ElasticIPsOperations.ResetField(request: .init(id: id, field: field)))
    }

    /// Attaches an Elastic IP to a compute instance.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func attach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        try await http.execute(ElasticIPsOperations.Attach(request: .init(id: id, instanceID: instanceID)))
    }

    /// Detaches an Elastic IP from a compute instance.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func detach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        try await http.execute(ElasticIPsOperations.Detach(request: .init(id: id, instanceID: instanceID)))
    }
}
