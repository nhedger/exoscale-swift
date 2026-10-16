import Foundation

struct VPCSubnetInstanceBody: Encodable, Sendable {
    struct Instance: Encodable, Sendable {
        let id: String
    }

    let instance: Instance
    var ipv4: String?
}
