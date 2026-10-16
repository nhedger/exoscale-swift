import Foundation

struct ListVPCRoutesData: Decodable, Sendable {
    let routes: [Exoscale.VPCRoute.Payload]
}
