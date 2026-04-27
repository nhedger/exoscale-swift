/// Request body for creating a KMS key.
struct CreateKMSKeyRequest: Codable, Sendable {
    let name: String
    let description: String
    let usage: Exoscale.KMSKey.Usage
    let multiZone: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case usage
        case multiZone = "multi-zone"
    }
}
