import Foundation

/// Access to Elastic IP API operations.
public struct ElasticIPsResource {
    public enum Field: String, Sendable {
        case description
    }

    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists Elastic IPs.
    ///
    /// - Returns: The Elastic IPs returned by the API.
    public func list() async throws -> [Exoscale.ElasticIP] {
        let response = try await http.get(path: "/elastic-ip", as: ListElasticIPsResponse.self)
        return response.elasticIPs
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
        let body = try JSONEncoder().encode(
            CreateElasticIPRequest(
                addressFamily: addressFamily,
                description: description,
                healthcheck: healthcheck,
                labels: labels
            )
        )

        return try await http.post(path: "/elastic-ip", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves an Elastic IP by identifier.
    ///
    /// - Parameter id: The Elastic IP identifier.
    /// - Returns: The Elastic IP returned by the API.
    public func get(id: String) async throws -> Exoscale.ElasticIP {
        try await http.get(path: "/elastic-ip/\(id)", as: Exoscale.ElasticIP.self)
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
        let body = try JSONEncoder().encode(
            UpdateElasticIPRequest(
                description: description,
                healthcheck: healthcheck,
                labels: labels
            )
        )

        return try await http.put(path: "/elastic-ip/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes an Elastic IP.
    ///
    /// - Parameter id: The Elastic IP identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/elastic-ip/\(id)", as: Exoscale.Operation.self)
    }

    /// Resets an Elastic IP field to its default value.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - field: The Elastic IP field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetField(id: String, field: Field) async throws -> Exoscale.Operation {
        try await http.delete(path: "/elastic-ip/\(id)/\(field.rawValue)", as: Exoscale.Operation.self)
    }

    /// Attaches an Elastic IP to a compute instance.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func attach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ElasticIPInstanceRequest(instanceID: instanceID))
        return try await http.put(path: "/elastic-ip/\(id):attach", body: body, as: Exoscale.Operation.self)
    }

    /// Detaches an Elastic IP from a compute instance.
    ///
    /// - Parameters:
    ///   - id: The Elastic IP identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func detach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ElasticIPInstanceRequest(instanceID: instanceID))
        return try await http.put(path: "/elastic-ip/\(id):detach", body: body, as: Exoscale.Operation.self)
    }
}
