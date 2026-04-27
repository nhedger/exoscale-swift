public extension Exoscale {
    /// Compute instance type returned by the API.
    struct InstanceType: Codable, Sendable {
        public enum Size: String, Codable, Sendable {
            case large
            case huge
            case jumbo
            case medium
            case mega
            case small
            case extraLarge = "extra-large"
            case titan48c
            case titan
            case micro
            case colossus
            case tiny
        }

        public enum Family: String, Codable, Sendable {
            case gpu3
            case gpua30
            case gpu3080ti
            case gpu2
            case gpu
            case memory
            case gpua5000
            case gpurtx6000pro
            case storage
            case standard
            case colossus
            case cpu
        }

        public let id: String?
        public let size: Size?
        public let family: Family?
        public let cpus: Int?
        public let gpus: Int?
        public let authorized: Bool?
        public let memory: Int?
        public let zones: [Exoscale.KnownZone]?

        enum CodingKeys: String, CodingKey {
            case id
            case size
            case family
            case cpus
            case gpus
            case authorized
            case memory
            case zones
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decodeIfPresent(String.self, forKey: .id)

            if let rawSize = try container.decodeIfPresent(String.self, forKey: .size) {
                size = Size(rawValue: rawSize)
            } else {
                size = nil
            }

            if let rawFamily = try container.decodeIfPresent(String.self, forKey: .family) {
                family = Family(rawValue: rawFamily)
            } else {
                family = nil
            }

            cpus = try container.decodeIfPresent(Int.self, forKey: .cpus)
            gpus = try container.decodeIfPresent(Int.self, forKey: .gpus)
            authorized = try container.decodeIfPresent(Bool.self, forKey: .authorized)
            memory = try container.decodeIfPresent(Int.self, forKey: .memory)
            zones = try container.decodeIfPresent([Exoscale.KnownZone].self, forKey: .zones)
        }
    }
}
