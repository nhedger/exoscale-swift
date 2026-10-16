import Foundation

struct VPCBody: Encodable, Sendable {
    let name: String?
    let description: String?
    let labels: [String: String]?
}
