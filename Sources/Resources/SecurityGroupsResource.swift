import Foundation

/// Access to Security Group API operations.
public struct SecurityGroupsResource: Sendable {
    let http: Http.Client

    /// Lists Security Groups.
    ///
    /// - Parameter visibility: Optional visibility filter for private or public Security Groups.
    /// - Returns: The Security Groups returned by the API.
    public func list(visibility: Exoscale.SecurityGroup.Visibility? = nil) async throws -> [Exoscale.SecurityGroup] {
        try await http.execute(SecurityGroupsOperations.List(request: .init(visibility: visibility)))
    }

    /// Creates a Security Group.
    ///
    /// - Parameters:
    ///   - name: The Security Group name.
    ///   - description: Optional Security Group description.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(name: String, description: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(SecurityGroupsOperations.Create(request: .init(name: name, description: description)))
    }

    /// Retrieves a Security Group by identifier.
    ///
    /// - Parameter id: The Security Group identifier.
    /// - Returns: The Security Group returned by the API.
    public func get(id: String) async throws -> Exoscale.SecurityGroup {
        try await http.execute(SecurityGroupsOperations.Get(request: .init(id: id)))
    }

    /// Deletes a Security Group.
    ///
    /// - Parameter id: The Security Group identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(SecurityGroupsOperations.Delete(request: .init(id: id)))
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
        try await http.execute(
            SecurityGroupsOperations.CreateRule(
                request: .init(
                    id: id,
                    flowDirection: flowDirection,
                    networkProtocol: networkProtocol,
                    description: description,
                    network: network,
                    securityGroup: securityGroup,
                    icmp: icmp,
                    startPort: startPort,
                    endPort: endPort
                )
            )
        )
    }

    /// Deletes a Security Group rule.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - ruleID: The Security Group rule identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteRule(id: String, ruleID: String) async throws -> Exoscale.Operation {
        try await http.execute(SecurityGroupsOperations.DeleteRule(request: .init(id: id, ruleID: ruleID)))
    }

    /// Adds an external source as a member of a Security Group.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - cidr: The CIDR-formatted network to add.
    /// - Returns: The asynchronous operation returned by the API.
    public func addSource(id: String, cidr: String) async throws -> Exoscale.Operation {
        try await http.execute(SecurityGroupsOperations.AddSource(request: .init(id: id, cidr: cidr)))
    }

    /// Removes an external source from a Security Group.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - cidr: The CIDR-formatted network to remove.
    /// - Returns: The asynchronous operation returned by the API.
    public func removeSource(id: String, cidr: String) async throws -> Exoscale.Operation {
        try await http.execute(SecurityGroupsOperations.RemoveSource(request: .init(id: id, cidr: cidr)))
    }

    /// Attaches a compute instance to a Security Group.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func attach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        try await http.execute(SecurityGroupsOperations.Attach(request: .init(id: id, instanceID: instanceID)))
    }

    /// Detaches a compute instance from a Security Group.
    ///
    /// - Parameters:
    ///   - id: The Security Group identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func detach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        try await http.execute(SecurityGroupsOperations.Detach(request: .init(id: id, instanceID: instanceID)))
    }
}
