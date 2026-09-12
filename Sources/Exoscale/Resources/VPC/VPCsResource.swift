import Foundation

/// Access to VPC networking operations (beta).
public struct VPCsResource: Sendable {
    let http: Http.Client

    /// Lists VPCs.
    public func list() async throws -> [Exoscale.VPC] {
        let response = try await http.get(path: "/vpc", as: ListVPCsResponse.self)
        return response.vpcs
    }

    /// Retrieves a VPC.
    public func get(id: String) async throws -> Exoscale.VPC {
        try await http.get(path: "/vpc/\(id)", as: Exoscale.VPC.self)
    }

    /// Creates a VPC asynchronously.
    public func create(name: String, description: String? = nil, labels: [String: String]? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(VPCRequest(name: name, description: description, labels: labels))
        return try await http.post(path: "/vpc", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a VPC and returns its current details.
    public func update(id: String, name: String? = nil, description: String? = nil, labels: [String: String]? = nil) async throws -> Exoscale.VPC {
        let body = try JSONEncoder().encode(VPCRequest(name: name, description: description, labels: labels))
        return try await http.put(path: "/vpc/\(id)", body: body, as: Exoscale.VPC.self)
    }

    /// Deletes a VPC synchronously.
    public func delete(id: String) async throws {
        _ = try await http.delete(path: "/vpc/\(id)", as: EmptyResponse.self)
    }

    /// Accesses the subnets belonging to a VPC.
    public func subnets(vpcID: String) -> VPCSubnetsResource {
        VPCSubnetsResource(http: http, vpcID: vpcID)
    }

    /// Lists routes across a VPC.
    public func routes(vpcID: String) async throws -> [Exoscale.VPCRoute] {
        let response = try await http.get(path: "/vpc/\(vpcID)/route", as: ListVPCRoutesResponse.self)
        return response.routes
    }
}

/// Access to a VPC's subnets (beta).
public struct VPCSubnetsResource: Sendable {
    let http: Http.Client
    let vpcID: String

    private var path: String { "/vpc/\(vpcID)/subnet" }

    public func list() async throws -> [Exoscale.VPCSubnet] {
        let response = try await http.get(path: path, as: ListVPCSubnetsResponse.self)
        return response.subnets
    }

    public func get(id: String) async throws -> Exoscale.VPCSubnet {
        try await http.get(path: "\(path)/\(id)", as: Exoscale.VPCSubnet.self)
    }

    /// Creates a private IPv4 subnet, the currently supported address family and space.
    public func create(name: String, description: String? = nil, labels: [String: String]? = nil, ipv4Block: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(VPCSubnetRequest(
            name: name, description: description, labels: labels, ipv4Block: ipv4Block,
            addressFamily: "inet4", addressSpace: "private"
        ))
        return try await http.post(path: path, body: body, as: Exoscale.Operation.self)
    }

    public func update(id: String, name: String? = nil, description: String? = nil, labels: [String: String]? = nil, ipv4Block: String? = nil) async throws -> Exoscale.VPCSubnet {
        let body = try JSONEncoder().encode(VPCSubnetRequest(name: name, description: description, labels: labels, ipv4Block: ipv4Block))
        return try await http.put(path: "\(path)/\(id)", body: body, as: Exoscale.VPCSubnet.self)
    }

    public func delete(id: String) async throws {
        _ = try await http.delete(path: "\(path)/\(id)", as: EmptyResponse.self)
    }

    public func attachInstance(id: String, instanceID: String, ipv4: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(VPCSubnetInstanceRequest(instance: .init(id: instanceID), ipv4: ipv4))
        return try await http.put(path: "\(path)/\(id)/attach", body: body, as: Exoscale.Operation.self)
    }

    public func detachInstance(id: String, instanceID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(VPCSubnetInstanceRequest(instance: .init(id: instanceID)))
        return try await http.put(path: "\(path)/\(id)/detach", body: body, as: Exoscale.Operation.self)
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

    private var path: String { "/vpc/\(vpcID)/subnet/\(subnetID)/route" }

    public func list() async throws -> [Exoscale.VPCRoute] {
        let response = try await http.get(path: path, as: ListVPCRoutesResponse.self)
        return response.routes
    }

    public func create(destination: String, target: String, description: String? = nil) async throws -> Exoscale.VPCRoute {
        let body = try JSONEncoder().encode(VPCRouteRequest(destination: destination, target: target, description: description))
        return try await http.post(path: path, body: body, as: Exoscale.VPCRoute.self)
    }

    public func delete(id: String) async throws {
        _ = try await http.delete(path: "\(path)/\(id)", as: EmptyResponse.self)
    }
}
