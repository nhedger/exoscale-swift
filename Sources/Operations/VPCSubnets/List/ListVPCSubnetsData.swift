import Foundation

struct ListVPCSubnetsData: Decodable, Sendable {
    let subnets: [Exoscale.VPCSubnet.Payload]
}
