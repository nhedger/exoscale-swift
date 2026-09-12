struct VPCRequest: Encodable, Sendable {
    let name: String?
    let description: String?
    let labels: [String: String]?
}

struct VPCSubnetRequest: Encodable, Sendable {
    let name: String?
    let description: String?
    let labels: [String: String]?
    let ipv4Block: String?
    var addressFamily: String?
    var addressSpace: String?

    enum CodingKeys: String, CodingKey {
        case name, description, labels
        case ipv4Block = "ipv4-block"
        case addressFamily = "addressfamily"
        case addressSpace = "address-space"
    }
}

struct VPCRouteRequest: Encodable, Sendable {
    let destination: String
    let target: String
    let description: String?
}

struct VPCSubnetInstanceRequest: Encodable, Sendable {
    struct Instance: Encodable, Sendable {
        let id: String
    }

    let instance: Instance
    var ipv4: String?
}
