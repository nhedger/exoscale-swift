import Foundation

struct VPCRouteBody: Encodable, Sendable {
    let destination: String
    let target: String
    let description: String?
}
