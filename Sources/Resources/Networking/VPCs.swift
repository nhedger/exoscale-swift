public extension Exoscale {
    /// Virtual private clouds: routed private networks for instances (beta).
    struct VPCs: Sendable {
        let client: HTTPClient

        /// Lists the VPCs.
        public func list() async throws -> [VPC] {
            try await client.send(.get, "/vpc", unwrapping: "vpcs")
        }

        /// Retrieves a VPC.
        public func get(id: String) async throws -> VPC {
            try await client.send(.get, "/vpc/\(id)")
        }

        /// Creates a VPC.
        public func create(
            name: String,
            description: String? = nil,
            dhcpOptions: VPC.DHCPOptions? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/vpc", body: [
                "name": name,
                "description": description,
                "dhcp-options": dhcpOptions,
                "labels": labels
            ] as JSONBody)
        }

        /// Updates a VPC. Only the values passed are changed.
        ///
        /// - Returns: The updated VPC.
        public func update(
            id: String,
            name: String? = nil,
            description: String? = nil,
            dhcpOptions: VPC.DHCPOptions? = nil,
            labels: [String: String]? = nil
        ) async throws -> VPC {
            try await client.send(.put, "/vpc/\(id)", body: [
                "name": name,
                "description": description,
                "dhcp-options": dhcpOptions,
                "labels": labels
            ] as JSONBody)
        }

        /// Deletes a VPC. It must have no subnets.
        public func delete(id: String) async throws {
            try await client.send(.delete, "/vpc/\(id)")
        }

        /// Lists the routes of a VPC and of all its subnets.
        public func routes(in id: String) async throws -> [Route] {
            try await client.send(.get, "/vpc/\(id)/route", unwrapping: "routes")
        }

        /// The subnets of a VPC.
        public func subnets(in vpcID: String) -> VPCSubnets {
            VPCSubnets(client: client, vpcID: vpcID)
        }
    }

    /// The subnets of one VPC (beta).
    struct VPCSubnets: Sendable {
        let client: HTTPClient
        /// The VPC's identifier.
        public let vpcID: String

        /// Lists the subnets.
        public func list() async throws -> [Subnet] {
            try await client.send(.get, "/vpc/\(vpcID)/subnet", unwrapping: "subnets")
        }

        /// Retrieves a subnet.
        public func get(id: String) async throws -> Subnet {
            try await client.send(.get, "/vpc/\(vpcID)/subnet/\(id)")
        }

        /// Creates a subnet with private IPv4 addresses.
        ///
        /// - Parameters:
        ///   - name: The subnet's name.
        ///   - ipv4Block: The subnet's IPv4 range, as a CIDR. Defaults to a free one.
        ///   - description: The subnet's description.
        ///   - labels: Labels to attach.
        public func create(
            name: String,
            ipv4Block: String? = nil,
            description: String? = nil,
            labels: [String: String]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/vpc/\(vpcID)/subnet", body: [
                "name": name,
                "addressfamily": AddressFamily.ipv4,
                "address-space": Subnet.AddressSpace.private,
                "ipv4-block": ipv4Block,
                "description": description,
                "labels": labels
            ] as JSONBody)
        }

        /// Updates a subnet. Only the values passed are changed.
        ///
        /// - Returns: The updated subnet.
        public func update(
            id: String,
            name: String? = nil,
            description: String? = nil,
            labels: [String: String]? = nil
        ) async throws -> Subnet {
            try await client.send(.put, "/vpc/\(vpcID)/subnet/\(id)", body: [
                "name": name,
                "description": description,
                "labels": labels
            ] as JSONBody)
        }

        /// Deletes a subnet. No instance may be attached to it.
        public func delete(id: String) async throws {
            try await client.send(.delete, "/vpc/\(vpcID)/subnet/\(id)")
        }

        /// Attaches an instance to a subnet.
        ///
        /// - Parameter ipv4: The address to give the instance. Defaults to a free one.
        public func attach(instanceID: String, to id: String, ipv4: String? = nil) async throws -> Operation {
            try await client.send(.put, "/vpc/\(vpcID)/subnet/\(id)/attach", body: [
                "instance": ["id": instanceID],
                "ipv4": ipv4
            ] as JSONBody)
        }

        /// Detaches an instance from a subnet.
        public func detach(instanceID: String, from id: String) async throws -> Operation {
            try await client.send(
                .put,
                "/vpc/\(vpcID)/subnet/\(id)/detach",
                body: ["instance": ["id": instanceID]] as JSONBody
            )
        }

        // MARK: Routes

        /// Lists the routes of a subnet.
        public func routes(in id: String) async throws -> [Route] {
            try await client.send(.get, "/vpc/\(vpcID)/subnet/\(id)/route", unwrapping: "routes")
        }

        /// Adds a route to a subnet.
        ///
        /// - Parameters:
        ///   - destination: The destination network, as a CIDR.
        ///   - target: The address to send the traffic to, such as an instance acting as a gateway.
        ///   - id: The subnet's identifier.
        ///   - description: The route's description.
        /// - Returns: The new route.
        public func addRoute(
            destination: String,
            target: String,
            to id: String,
            description: String? = nil
        ) async throws -> Route {
            try await client.send(.post, "/vpc/\(vpcID)/subnet/\(id)/route", body: [
                "destination": destination,
                "target": target,
                "description": description
            ] as JSONBody)
        }

        /// Deletes a route from a subnet.
        public func deleteRoute(_ routeID: String, from id: String) async throws {
            try await client.send(.delete, "/vpc/\(vpcID)/subnet/\(id)/route/\(routeID)")
        }
    }
}
