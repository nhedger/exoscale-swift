public extension Exoscale {
    /// Network load balancers, spreading traffic across the instances of instance pools.
    struct LoadBalancers: Sendable {
        let client: HTTPClient

        /// Lists the load balancers.
        public func list() async throws -> [LoadBalancer] {
            try await client.send(.get, "/load-balancer", unwrapping: "load-balancers")
        }

        /// Retrieves a load balancer.
        public func get(id: String) async throws -> LoadBalancer {
            try await client.send(.get, "/load-balancer/\(id)")
        }

        /// Creates a load balancer.
        ///
        /// - Parameter addressFamily: Whether it gets an IPv4 or IPv6 address. The API defaults to IPv4.
        public func create(
            name: String,
            addressFamily: AddressFamily? = nil,
            description: String? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/load-balancer", body: [
                "name": name,
                "addressfamily": addressFamily,
                "description": description,
                "labels": labels
            ] as JSONBody)
        }

        /// Updates a load balancer. Only the values passed are changed.
        public func update(
            id: String,
            name: String? = nil,
            description: String? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/load-balancer/\(id)", body: [
                "name": name,
                "description": description,
                "labels": labels
            ] as JSONBody)
        }

        /// Resets a setting of a load balancer to its default, such as removing its labels.
        public func reset(_ field: LoadBalancer.Field, id: String) async throws -> Operation {
            try await client.send(.delete, "/load-balancer/\(id)/\(field)")
        }

        /// Deletes a load balancer and its services.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/load-balancer/\(id)")
        }

        // MARK: Services

        /// Retrieves a service of a load balancer.
        public func service(id: String, of loadBalancerID: String) async throws -> LoadBalancer.Service {
            try await client.send(.get, "/load-balancer/\(loadBalancerID)/service/\(id)")
        }

        /// Adds a service, sending traffic from one port to an instance pool.
        ///
        /// - Parameters:
        ///   - loadBalancerID: The load balancer's identifier.
        ///   - name: The service's name.
        ///   - instancePoolID: The instance pool receiving the traffic.
        ///   - protocol: The protocol to balance.
        ///   - port: The port traffic arrives on.
        ///   - targetPort: The port to send traffic to on the instances.
        ///   - strategy: How to pick an instance for each connection.
        ///   - healthcheck: The health check deciding which instances receive traffic.
        ///   - description: The service's description.
        public func addService(
            to loadBalancerID: String,
            name: String,
            instancePoolID: String,
            protocol: LoadBalancer.TransportProtocol,
            port: Int,
            targetPort: Int,
            strategy: LoadBalancer.Strategy,
            healthcheck: LoadBalancer.Healthcheck,
            description: String? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/load-balancer/\(loadBalancerID)/service", body: [
                "name": name,
                "instance-pool": ["id": instancePoolID],
                "protocol": `protocol`,
                "port": port,
                "target-port": targetPort,
                "strategy": strategy,
                "healthcheck": healthcheck,
                "description": description
            ] as JSONBody)
        }

        /// Updates a service. Only the values passed are changed.
        public func updateService(
            id: String,
            of loadBalancerID: String,
            name: String? = nil,
            protocol: LoadBalancer.TransportProtocol? = nil,
            port: Int? = nil,
            targetPort: Int? = nil,
            strategy: LoadBalancer.Strategy? = nil,
            healthcheck: LoadBalancer.Healthcheck? = nil,
            description: String? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/load-balancer/\(loadBalancerID)/service/\(id)", body: [
                "name": name,
                "protocol": `protocol`,
                "port": port,
                "target-port": targetPort,
                "strategy": strategy,
                "healthcheck": healthcheck,
                "description": description
            ] as JSONBody)
        }

        /// Removes a service's description.
        public func removeServiceDescription(id: String, of loadBalancerID: String) async throws -> Operation {
            try await client.send(.delete, "/load-balancer/\(loadBalancerID)/service/\(id)/description")
        }

        /// Deletes a service.
        public func deleteService(id: String, of loadBalancerID: String) async throws -> Operation {
            try await client.send(.delete, "/load-balancer/\(loadBalancerID)/service/\(id)")
        }
    }
}
