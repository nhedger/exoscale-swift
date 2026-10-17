public extension Exoscale {
    /// An instance type, which sets an instance's CPU, memory and GPUs.
    struct InstanceType: Hashable, Codable, Sendable {
        /// The type's identifier.
        public let id: String
        /// The family, such as standard, memory-optimized or GPU.
        public let family: Family?
        /// The size within the family.
        public let size: Size?
        /// The number of CPU cores.
        public let cpus: Int?
        /// The number of GPUs.
        public let gpus: Int?
        /// The amount of memory.
        public let memory: Int?
        /// Whether the organization may use this type.
        public let authorized: Bool?
        /// The zones offering this type.
        public let zones: [Zone]?

        /// Creates an instance type, for example for previews and tests.
        public init(
            id: String,
            family: Family? = nil,
            size: Size? = nil,
            cpus: Int? = nil,
            gpus: Int? = nil,
            memory: Int? = nil,
            authorized: Bool? = nil,
            zones: [Zone]? = nil
        ) {
            self.id = id
            self.family = family
            self.size = size
            self.cpus = cpus
            self.gpus = gpus
            self.memory = memory
            self.authorized = authorized
            self.zones = zones
        }
    }
}

public extension Exoscale.InstanceType {
    /// An instance type family.
    struct Family: RawRepresentable, Hashable, Codable, Sendable {
        /// The family as the API names it.
        public let rawValue: String

        /// Creates a family, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// General purpose.
        public static let standard = Family(rawValue: "standard")
        /// CPU-optimized.
        public static let cpu = Family(rawValue: "cpu")
        /// Memory-optimized.
        public static let memory = Family(rawValue: "memory")
        /// Storage-optimized.
        public static let storage = Family(rawValue: "storage")
        /// Very large instances.
        public static let colossus = Family(rawValue: "colossus")
        /// NVIDIA Tesla P100 GPUs.
        public static let gpu = Family(rawValue: "gpu")
        /// NVIDIA Tesla V100 GPUs.
        public static let gpu2 = Family(rawValue: "gpu2")
        /// NVIDIA Tesla V100 GPUs, third generation.
        public static let gpu3 = Family(rawValue: "gpu3")
        /// NVIDIA GeForce RTX 3080 Ti GPUs.
        public static let gpu3080ti = Family(rawValue: "gpu3080ti")
        /// NVIDIA A30 GPUs.
        public static let gpuA30 = Family(rawValue: "gpua30")
        /// NVIDIA RTX A5000 GPUs.
        public static let gpuA5000 = Family(rawValue: "gpua5000")
        /// NVIDIA B300 GPUs.
        public static let gpuB300 = Family(rawValue: "gpub300")
        /// NVIDIA RTX PRO 6000 GPUs.
        public static let gpuRTX6000Pro = Family(rawValue: "gpurtx6000pro")
    }

    /// An instance type size.
    struct Size: RawRepresentable, Hashable, Codable, Sendable {
        /// The size as the API names it.
        public let rawValue: String

        /// Creates a size, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Micro.
        public static let micro = Size(rawValue: "micro")
        /// Tiny.
        public static let tiny = Size(rawValue: "tiny")
        /// Small.
        public static let small = Size(rawValue: "small")
        /// Medium.
        public static let medium = Size(rawValue: "medium")
        /// Large.
        public static let large = Size(rawValue: "large")
        /// Extra large.
        public static let extraLarge = Size(rawValue: "extra-large")
        /// Huge.
        public static let huge = Size(rawValue: "huge")
        /// Mega.
        public static let mega = Size(rawValue: "mega")
        /// Titan.
        public static let titan = Size(rawValue: "titan")
        /// Titan with 48 cores.
        public static let titan48c = Size(rawValue: "titan48c")
        /// Jumbo.
        public static let jumbo = Size(rawValue: "jumbo")
        /// Colossus.
        public static let colossus = Size(rawValue: "colossus")
    }
}
