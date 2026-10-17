public extension Exoscale {
    /// Security groups: sets of firewall rules applied to the instances in them.
    struct SecurityGroups: Sendable {
        let client: HTTPClient

        /// Lists security groups.
        ///
        /// - Parameter visibility: Only the organization's own groups, or only public ones.
        public func list(visibility: SecurityGroup.Visibility? = nil) async throws -> [SecurityGroup] {
            try await client.send(
                .get,
                "/security-group",
                query: ["visibility": visibility?.rawValue],
                unwrapping: "security-groups"
            )
        }

        /// Retrieves a security group.
        public func get(id: String) async throws -> SecurityGroup {
            try await client.send(.get, "/security-group/\(id)")
        }

        /// Creates a security group.
        public func create(name: String, description: String? = nil) async throws -> Operation {
            try await client.send(
                .post,
                "/security-group",
                body: ["name": name, "description": description] as JSONBody
            )
        }

        /// Deletes a security group. No instance may be in it.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/security-group/\(id)")
        }

        // MARK: Rules

        /// Adds a rule to a security group.
        ///
        /// Give either `network` or `securityGroup` as the other side of the traffic.
        ///
        /// - Parameters:
        ///   - id: The security group's identifier.
        ///   - flowDirection: Whether the rule allows incoming or outgoing traffic.
        ///   - protocol: The protocol to allow.
        ///   - network: The network the traffic comes from or goes to, as a CIDR.
        ///   - securityGroup: The security group whose members the traffic comes from or goes to.
        ///   - startPort: The first port of the range, for TCP and UDP.
        ///   - endPort: The last port of the range, for TCP and UDP.
        ///   - icmp: The ICMP type and code, for ICMP and ICMPv6.
        ///   - description: The rule's description.
        public func addRule(
            to id: String,
            flowDirection: SecurityGroup.FlowDirection,
            protocol: SecurityGroup.NetworkProtocol,
            network: String? = nil,
            securityGroup: SecurityGroup.Peer? = nil,
            startPort: Int? = nil,
            endPort: Int? = nil,
            icmp: SecurityGroup.ICMP? = nil,
            description: String? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/security-group/\(id)/rules", body: [
                "flow-direction": flowDirection,
                "protocol": `protocol`,
                "network": network,
                "security-group": securityGroup,
                "start-port": startPort,
                "end-port": endPort,
                "icmp": icmp,
                "description": description
            ] as JSONBody)
        }

        /// Deletes a rule from a security group.
        public func deleteRule(_ ruleID: String, from id: String) async throws -> Operation {
            try await client.send(.delete, "/security-group/\(id)/rules/\(ruleID)")
        }

        // MARK: Members

        /// Puts an instance in a security group.
        public func attach(instanceID: String, to id: String) async throws -> Operation {
            try await client.send(
                .put,
                "/security-group/\(id):attach",
                body: ["instance": ["id": instanceID]] as JSONBody
            )
        }

        /// Takes an instance out of a security group.
        public func detach(instanceID: String, from id: String) async throws -> Operation {
            try await client.send(
                .put,
                "/security-group/\(id):detach",
                body: ["instance": ["id": instanceID]] as JSONBody
            )
        }

        /// Treats a network as a member of a security group in other groups' rules.
        ///
        /// - Parameter cidr: The network, such as `198.51.100.0/24`.
        public func addSource(cidr: String, to id: String) async throws -> Operation {
            try await client.send(.put, "/security-group/\(id):add-source", body: ["cidr": cidr] as JSONBody)
        }

        /// Removes a network added with ``addSource(cidr:to:)``.
        public func removeSource(cidr: String, from id: String) async throws -> Operation {
            try await client.send(.put, "/security-group/\(id):remove-source", body: ["cidr": cidr] as JSONBody)
        }
    }
}
