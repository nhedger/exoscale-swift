import Foundation

/// Access to VPC networking operations (beta).
public struct VPCsResource: Sendable {
    let http: Http.Client

    /// Lists VPCs.
    public func list() async throws -> [Exoscale.VPC] {
        try await http.execute(VPCsOperations.List(request: .init()))
    }

    /// Retrieves a VPC.
    public func get(id: String) async throws -> Exoscale.VPC {
        try await http.execute(VPCsOperations.Get(request: .init(id: id)))
    }

    /// Creates a VPC asynchronously.
    public func create(name: String, description: String? = nil,
                       labels: [String: String]? = nil) async throws -> Exoscale.Operation {
        try await http.execute(
            VPCsOperations.Create(request: .init(name: name, description: description, labels: labels))
        )
    }

    /// Updates a VPC and returns its current details.
    public func update(
        id: String,
        name: String? = nil,
        description: String? = nil,
        labels: [String: String]? = nil
    ) async throws -> Exoscale.VPC {
        try await http.execute(
            VPCsOperations.Update(request: .init(id: id, name: name, description: description, labels: labels))
        )
    }

    /// Deletes a VPC synchronously.
    public func delete(id: String) async throws {
        try await http.execute(VPCsOperations.Delete(request: .init(id: id)))
    }

    /// Accesses the subnets belonging to a VPC.
    public func subnets(vpcID: String) -> VPCSubnetsResource {
        VPCSubnetsResource(http: http, vpcID: vpcID)
    }

    /// Lists routes across a VPC.
    public func routes(vpcID: String) async throws -> [Exoscale.VPCRoute] {
        try await http.execute(VPCsOperations.Routes(request: .init(vpcID: vpcID)))
    }
}

/// Access to a VPC's subnets (beta).
public struct VPCSubnetsResource: Sendable {
    let http: Http.Client
    let vpcID: String

    public func list() async throws -> [Exoscale.VPCSubnet] {
        try await http.execute(VPCSubnetsOperations.List(request: .init(vpcID: vpcID)))
    }

    public func get(id: String) async throws -> Exoscale.VPCSubnet {
        try await http.execute(VPCSubnetsOperations.Get(request: .init(vpcID: vpcID, id: id)))
    }

    /// Creates a private IPv4 subnet, the currently supported address family and space.
    public func create(
        name: String,
        description: String? = nil,
        labels: [String: String]? = nil,
        ipv4Block: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            VPCSubnetsOperations.Create(
                request: .init(vpcID: vpcID, name: name, description: description, labels: labels, ipv4Block: ipv4Block)
            )
        )
    }

    public func update(
        id: String,
        name: String? = nil,
        description: String? = nil,
        labels: [String: String]? = nil,
        ipv4Block: String? = nil
    ) async throws -> Exoscale.VPCSubnet {
        try await http.execute(
            VPCSubnetsOperations.Update(
                request: .init(
                    vpcID: vpcID,
                    id: id,
                    name: name,
                    description: description,
                    labels: labels,
                    ipv4Block: ipv4Block
                )
            )
        )
    }

    public func delete(id: String) async throws {
        try await http.execute(VPCSubnetsOperations.Delete(request: .init(vpcID: vpcID, id: id)))
    }

    public func attachInstance(id: String, instanceID: String, ipv4: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(
            VPCSubnetsOperations.AttachInstance(request: .init(
                vpcID: vpcID,
                id: id,
                instanceID: instanceID,
                ipv4: ipv4
            ))
        )
    }

    public func detachInstance(id: String, instanceID: String) async throws -> Exoscale.Operation {
        try await http.execute(
            VPCSubnetsOperations.DetachInstance(request: .init(vpcID: vpcID, id: id, instanceID: instanceID))
        )
    }

    public func routes(subnetID: String) -> VPCRoutesResource {
        VPCRoutesResource(http: http, vpcID: vpcID, subnetID: subnetID)
    }
}

/// Access to a subnet's routes (beta).
public struct VPCRoutesResource: Sendable {
    let http: Http.Client
    let vpcID: String
    let subnetID: String

    public func list() async throws -> [Exoscale.VPCRoute] {
        try await http.execute(VPCRoutesOperations.List(request: .init(vpcID: vpcID, subnetID: subnetID)))
    }

    public func create(destination: String, target: String, description: String? = nil) async throws -> Exoscale
        .VPCRoute {
        try await http.execute(
            VPCRoutesOperations.Create(
                request: .init(
                    vpcID: vpcID,
                    subnetID: subnetID,
                    destination: destination,
                    target: target,
                    description: description
                )
            )
        )
    }

    public func delete(id: String) async throws {
        try await http.execute(VPCRoutesOperations.Delete(request: .init(vpcID: vpcID, subnetID: subnetID, id: id)))
    }
}
