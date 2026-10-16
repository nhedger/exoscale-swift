import Foundation

struct ListVPCsData: Decodable, Sendable {
    let vpcs: [Exoscale.VPC.Payload]
}
