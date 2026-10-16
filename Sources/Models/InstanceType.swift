public extension Exoscale {
    /// Compute instance type returned by the API.
    struct InstanceType: Hashable, Sendable {
        public let id: String?
        public let size: Size?
        public let family: Family?
        public let cpus: Int?
        public let gpus: Int?
        public let authorized: Bool?
        public let memory: Int?
        public let zones: [Exoscale.ZoneName]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            size: Size? = nil,
            family: Family? = nil,
            cpus: Int? = nil,
            gpus: Int? = nil,
            authorized: Bool? = nil,
            memory: Int? = nil,
            zones: [Exoscale.ZoneName]? = nil
        ) {
            self.id = id
            self.size = size
            self.family = family
            self.cpus = cpus
            self.gpus = gpus
            self.authorized = authorized
            self.memory = memory
            self.zones = zones
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            size = data.size
            family = data.family
            cpus = data.cpus
            gpus = data.gpus
            authorized = data.authorized
            memory = data.memory
            zones = data.zones
        }
    }
}

public extension Exoscale.InstanceType {
    enum Size: Exoscale.ExtensibleEnum {
        case large
        case huge
        case jumbo
        case medium
        case mega
        case small
        case extraLarge
        case titan48c
        case titan
        case micro
        case colossus
        case tiny
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .large,
            .huge,
            .jumbo,
            .medium,
            .mega,
            .small,
            .extraLarge,
            .titan48c,
            .titan,
            .micro,
            .colossus,
            .tiny
        ]

        public var rawValue: String {
            switch self {
            case .large: "large"
            case .huge: "huge"
            case .jumbo: "jumbo"
            case .medium: "medium"
            case .mega: "mega"
            case .small: "small"
            case .extraLarge: "extra-large"
            case .titan48c: "titan48c"
            case .titan: "titan"
            case .micro: "micro"
            case .colossus: "colossus"
            case .tiny: "tiny"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.InstanceType {
    enum Family: Exoscale.ExtensibleEnum {
        case gpu3
        case gpua30
        case gpu3080ti
        case gpu2
        case gpu
        case memory
        case gpua5000
        case gpub300
        case gpurtx6000pro
        case storage
        case standard
        case colossus
        case cpu
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .gpu3,
            .gpua30,
            .gpu3080ti,
            .gpu2,
            .gpu,
            .memory,
            .gpua5000,
            .gpub300,
            .gpurtx6000pro,
            .storage,
            .standard,
            .colossus,
            .cpu
        ]

        public var rawValue: String {
            switch self {
            case .gpu3: "gpu3"
            case .gpua30: "gpua30"
            case .gpu3080ti: "gpu3080ti"
            case .gpu2: "gpu2"
            case .gpu: "gpu"
            case .memory: "memory"
            case .gpua5000: "gpua5000"
            case .gpub300: "gpub300"
            case .gpurtx6000pro: "gpurtx6000pro"
            case .storage: "storage"
            case .standard: "standard"
            case .colossus: "colossus"
            case .cpu: "cpu"
            case let .unknown(value): value
            }
        }
    }
}
