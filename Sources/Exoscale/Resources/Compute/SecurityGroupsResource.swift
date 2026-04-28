import Foundation

/// Access to Security Group API operations.
public struct SecurityGroupsResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists Security Groups.
    ///
    /// - Parameter visibility: Optional visibility filter for private or public Security Groups.
    /// - Returns: The Security Groups returned by the API.
    public func list(visibility: Exoscale.SecurityGroup.Visibility? = nil) async throws -> [Exoscale.SecurityGroup] {
        var query: [String: String?] = [:]

        if let visibility {
            query["visibility"] = visibility.rawValue
        }

        let response = try await http.get(path: "/security-group", query: query, as: ListSecurityGroupsResponse.self)
        return response.securityGroups
    }

    /// Creates a Security Group.
    ///
    /// - Parameters:
    ///   - name: The Security Group name.
    ///   - description: Optional Security Group description.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(name: String, description: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateSecurityGroupRequest(name: name, description: description))
        return try await http.post(path: "/security-group", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves a Security Group by identifier.
    ///
    /// - Parameter id: The Security Group identifier.
    /// - Returns: The Security Group returned by the API.
    public func get(id: String) async throws -> Exoscale.SecurityGroup {
        try await http.get(path: "/security-group/\(id)", as: Exoscale.SecurityGroup.self)
    }

    /// Deletes a Security Group.
    ///
    /// - Parameter id: The Security Group identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/security-group/\(id)", as: Exoscale.Operation.self)
    }

    /// Creates a Security Group rule.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - flowDirection: The network flow direction to match.
    ///   - networkProtocol: The network protocol to match.
    ///   - description: Optional Security Group rule description.
    ///   - network: Optional CIDR-formatted network allowed by the rule.
    ///   - securityGroup: Optional Security Group allowed by the rule.
    ///   - icmp: Optional ICMP details.
    ///   - startPort: Optional start port of the range.
    ///   - endPort: Optional end port of the range.
    /// - Returns: The asynchronous operation returned by the API.
    public func createRule(
        id: String,
        flowDirection: Exoscale.SecurityGroup.Rule.FlowDirection,
        networkProtocol: Exoscale.SecurityGroup.Rule.NetworkProtocol,
        description: String? = nil,
        network: String? = nil,
        securityGroup: Exoscale.SecurityGroup.Resource? = nil,
        icmp: Exoscale.SecurityGroup.Rule.ICMP? = nil,
        startPort: Int? = nil,
        endPort: Int? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateSecurityGroupRuleRequest(
                flowDirection: flowDirection,
                description: description,
                network: network,
                securityGroup: securityGroup,
                networkProtocol: networkProtocol,
                icmp: icmp,
                startPort: startPort,
                endPort: endPort
            )
        )

        return try await http.post(path: "/security-group/\(id)/rules", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a Security Group rule.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - ruleID: The Security Group rule identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteRule(id: String, ruleID: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/security-group/\(id)/rules/\(ruleID)", as: Exoscale.Operation.self)
    }

    /// Adds an external source as a member of a Security Group.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - cidr: The CIDR-formatted network to add.
    /// - Returns: The asynchronous operation returned by the API.
    public func addSource(id: String, cidr: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(SecurityGroupExternalSourceRequest(cidr: cidr))
        return try await http.put(path: "/security-group/\(id):add-source", body: body, as: Exoscale.Operation.self)
    }

    /// Removes an external source from a Security Group.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - cidr: The CIDR-formatted network to remove.
    /// - Returns: The asynchronous operation returned by the API.
    public func removeSource(id: String, cidr: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(SecurityGroupExternalSourceRequest(cidr: cidr))
        return try await http.put(path: "/security-group/\(id):remove-source", body: body, as: Exoscale.Operation.self)
    }

    /// Attaches a compute instance to a Security Group.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func attach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(SecurityGroupInstanceRequest(instance: InstanceIDReference(id: instanceID)))
        return try await http.put(path: "/security-group/\(id):attach", body: body, as: Exoscale.Operation.self)
    }

    /// Detaches a compute instance from a Security Group.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func detach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(SecurityGroupInstanceRequest(instance: InstanceIDReference(id: instanceID)))
        return try await http.put(path: "/security-group/\(id):detach", body: body, as: Exoscale.Operation.self)
    }
}
