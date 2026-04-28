import Foundation

/// Access to network load balancer API operations.
public struct LoadBalancersResource {
    public enum Field: String, Sendable {
        case description
        case labels
    }

    public enum ServiceField: String, Sendable {
        case description
    }

    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists network load balancers.
    ///
    /// - Returns: The network load balancers returned by the API.
    public func list() async throws -> [Exoscale.LoadBalancer] {
        let response = try await http.get(path: "/load-balancer", as: ListLoadBalancersResponse.self)
        return response.loadBalancers
    }

    /// Creates a network load balancer.
    ///
    /// - Parameters:
    ///   - name: The load balancer name.
    ///   - description: Optional load balancer description.
    ///   - labels: Optional load balancer labels.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        name: String,
        description: String? = nil,
        labels: [String: String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateLoadBalancerRequest(
                name: name,
                description: description,
                labels: labels
            )
        )

        return try await http.post(path: "/load-balancer", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a network load balancer.
    ///
    /// - Parameter id: The load balancer identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/load-balancer/\(id)", as: Exoscale.Operation.self)
    }

    /// Retrieves a network load balancer by identifier.
    ///
    /// - Parameter id: The load balancer identifier.
    /// - Returns: The load balancer returned by the API.
    public func get(id: String) async throws -> Exoscale.LoadBalancer {
        try await http.get(path: "/load-balancer/\(id)", as: Exoscale.LoadBalancer.self)
    }

    /// Updates a network load balancer.
    ///
    /// - Parameters:
    ///   - id: The load balancer identifier.
    ///   - name: Optional load balancer name.
    ///   - description: Optional load balancer description.
    ///   - labels: Optional load balancer labels.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        name: String? = nil,
        description: String? = nil,
        labels: [String: String]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateLoadBalancerRequest(
                name: name,
                description: description,
                labels: labels
            )
        )

        return try await http.put(path: "/load-balancer/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Adds a service to a network load balancer.
    ///
    /// - Parameters:
    ///   - id: The load balancer identifier.
    ///   - name: The load balancer service name.
    ///   - instancePoolID: The target instance pool identifier.
    ///   - networkProtocol: The network traffic protocol.
    ///   - strategy: The load balancing strategy.
    ///   - port: The public load balancer port.
    ///   - targetPort: The backend instance port.
    ///   - healthcheck: The service healthcheck configuration.
    ///   - description: Optional service description.
    /// - Returns: The asynchronous operation returned by the API.
    public func addService(
        id: String,
        name: String,
        instancePoolID: String,
        networkProtocol: Exoscale.LoadBalancer.Service.NetworkProtocol,
        strategy: Exoscale.LoadBalancer.Service.Strategy,
        port: Int,
        targetPort: Int,
        healthcheck: Exoscale.LoadBalancer.Service.Healthcheck,
        description: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            AddLoadBalancerServiceRequest(
                name: name,
                description: description,
                instancePool: LoadBalancerInstancePoolReference(id: instancePoolID),
                networkProtocol: networkProtocol,
                strategy: strategy,
                port: port,
                targetPort: targetPort,
                healthcheck: healthcheck
            )
        )

        return try await http.post(path: "/load-balancer/\(id)/service", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a network load balancer service.
    ///
    /// - Parameters:
    ///   - id: The load balancer identifier.
    ///   - serviceID: The load balancer service identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteService(id: String, serviceID: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/load-balancer/\(id)/service/\(serviceID)", as: Exoscale.Operation.self)
    }

    /// Retrieves a network load balancer service by identifier.
    ///
    /// - Parameters:
    ///   - id: The load balancer identifier.
    ///   - serviceID: The load balancer service identifier.
    /// - Returns: The load balancer service returned by the API.
    public func getService(id: String, serviceID: String) async throws -> Exoscale.LoadBalancer.Service {
        try await http.get(path: "/load-balancer/\(id)/service/\(serviceID)", as: Exoscale.LoadBalancer.Service.self)
    }

    /// Updates a network load balancer service.
    ///
    /// - Parameters:
    ///   - id: The load balancer identifier.
    ///   - serviceID: The load balancer service identifier.
    ///   - name: Optional service name.
    ///   - description: Optional service description.
    ///   - networkProtocol: Optional network traffic protocol.
    ///   - strategy: Optional load balancing strategy.
    ///   - port: Optional public load balancer port.
    ///   - targetPort: Optional backend instance port.
    ///   - healthcheck: Optional service healthcheck configuration.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateService(
        id: String,
        serviceID: String,
        name: String? = nil,
        description: String? = nil,
        networkProtocol: Exoscale.LoadBalancer.Service.NetworkProtocol? = nil,
        strategy: Exoscale.LoadBalancer.Service.Strategy? = nil,
        port: Int? = nil,
        targetPort: Int? = nil,
        healthcheck: Exoscale.LoadBalancer.Service.Healthcheck? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateLoadBalancerServiceRequest(
                name: name,
                description: description,
                networkProtocol: networkProtocol,
                strategy: strategy,
                port: port,
                targetPort: targetPort,
                healthcheck: healthcheck
            )
        )

        return try await http.put(
            path: "/load-balancer/\(id)/service/\(serviceID)",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Resets a network load balancer service field to its default value.
    ///
    /// - Parameters:
    ///   - id: The load balancer identifier.
    ///   - serviceID: The load balancer service identifier.
    ///   - field: The service field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetServiceField(
        id: String,
        serviceID: String,
        field: ServiceField
    ) async throws -> Exoscale.Operation {
        try await http.delete(
            path: "/load-balancer/\(id)/service/\(serviceID)/\(field.rawValue)",
            as: Exoscale.Operation.self
        )
    }

    /// Resets a network load balancer field to its default value.
    ///
    /// - Parameters:
    ///   - id: The load balancer identifier.
    ///   - field: The load balancer field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetField(id: String, field: Field) async throws -> Exoscale.Operation {
        try await http.delete(path: "/load-balancer/\(id)/\(field.rawValue)", as: Exoscale.Operation.self)
    }
}
