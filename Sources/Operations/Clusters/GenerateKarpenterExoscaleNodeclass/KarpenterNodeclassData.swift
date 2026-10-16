import Foundation

struct KarpenterNodeclassData: Decodable, Sendable {
    let exoscaleNodeclass: String

    enum CodingKeys: String, CodingKey {
        case exoscaleNodeclass = "exoscale-nodeclass"
    }
}
