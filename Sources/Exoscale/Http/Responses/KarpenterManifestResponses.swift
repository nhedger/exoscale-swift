struct KarpenterNodepoolResponse: Decodable, Sendable {
    let nodepool: String
}

struct KarpenterNodeclassResponse: Decodable, Sendable {
    let exoscaleNodeclass: String

    enum CodingKeys: String, CodingKey {
        case exoscaleNodeclass = "exoscale-nodeclass"
    }
}
