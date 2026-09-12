struct ListVPCsResponse: Decodable, Sendable {
    let vpcs: [Exoscale.VPC]
}

struct ListVPCSubnetsResponse: Decodable, Sendable {
    let subnets: [Exoscale.VPCSubnet]
}

struct ListVPCRoutesResponse: Decodable, Sendable {
    let routes: [Exoscale.VPCRoute]
}

struct EmptyResponse: Decodable, Sendable {}
