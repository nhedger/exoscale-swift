import Foundation

/// Request body for scaling a compute instance.
struct ScaleInstanceBody: Encodable, Sendable {
    let instanceType: InstanceIDReference

    enum CodingKeys: String, CodingKey {
        case instanceType = "instance-type"
    }
}
