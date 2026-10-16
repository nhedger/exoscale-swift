import Foundation

public extension Exoscale {
    /// SKS nodepool returned by the API.
    struct SKSNodepool: Hashable, Sendable {
        public let antiAffinityGroups: [Reference]?
        public let description: String?
        public let publicIPAssignment: PublicIPAssignment?
        public let labels: [String: String]?
        public let taints: [String: Taint]?
        public let securityGroups: [Reference]?
        public let name: String?
        public let instanceType: Reference?
        public let privateNetworks: [Reference]?
        public let template: Reference?
        public let state: State?
        public let size: Int?
        public let kubeletImageGC: KubeletImageGC?
        public let instancePool: Reference?
        public let instancePrefix: String?
        public let deployTarget: Reference?
        public let addons: [Addon]?
        public let id: String?
        public let diskSize: Int?
        public let version: String?
        public let createdAt: Date?
        public let nvidiaMIGProfiles: NvidiaMIGProfiles?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            antiAffinityGroups: [Reference]? = nil,
            description: String? = nil,
            publicIPAssignment: PublicIPAssignment? = nil,
            labels: [String: String]? = nil,
            taints: [String: Taint]? = nil,
            securityGroups: [Reference]? = nil,
            name: String? = nil,
            instanceType: Reference? = nil,
            privateNetworks: [Reference]? = nil,
            template: Reference? = nil,
            state: State? = nil,
            size: Int? = nil,
            kubeletImageGC: KubeletImageGC? = nil,
            instancePool: Reference? = nil,
            instancePrefix: String? = nil,
            deployTarget: Reference? = nil,
            addons: [Addon]? = nil,
            id: String? = nil,
            diskSize: Int? = nil,
            version: String? = nil,
            createdAt: Date? = nil,
            nvidiaMIGProfiles: NvidiaMIGProfiles? = nil
        ) {
            self.antiAffinityGroups = antiAffinityGroups
            self.description = description
            self.publicIPAssignment = publicIPAssignment
            self.labels = labels
            self.taints = taints
            self.securityGroups = securityGroups
            self.name = name
            self.instanceType = instanceType
            self.privateNetworks = privateNetworks
            self.template = template
            self.state = state
            self.size = size
            self.kubeletImageGC = kubeletImageGC
            self.instancePool = instancePool
            self.instancePrefix = instancePrefix
            self.deployTarget = deployTarget
            self.addons = addons
            self.id = id
            self.diskSize = diskSize
            self.version = version
            self.createdAt = createdAt
            self.nvidiaMIGProfiles = nvidiaMIGProfiles
        }

        init(data: Payload, client _: Http.Client) {
            antiAffinityGroups = data.antiAffinityGroups
            description = data.description
            publicIPAssignment = data.publicIPAssignment
            labels = data.labels
            taints = data.taints
            securityGroups = data.securityGroups
            name = data.name
            instanceType = data.instanceType
            privateNetworks = data.privateNetworks
            template = data.template
            state = data.state
            size = data.size
            kubeletImageGC = data.kubeletImageGC
            instancePool = data.instancePool
            instancePrefix = data.instancePrefix
            deployTarget = data.deployTarget
            addons = data.addons
            id = data.id
            diskSize = data.diskSize
            version = data.version
            createdAt = data.createdAt
            nvidiaMIGProfiles = data.nvidiaMIGProfiles
        }
    }
}

public extension Exoscale.SKSNodepool {
    struct Reference: Codable, Hashable, Sendable {
        public let id: String?

        public init(id: String? = nil) {
            self.id = id
        }
    }
}

public extension Exoscale.SKSNodepool.Taint {
    enum Effect: Exoscale.ExtensibleEnum {
        case noExecute
        case noSchedule
        case preferNoSchedule
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.noExecute, .noSchedule, .preferNoSchedule]

        public var rawValue: String {
            switch self {
            case .noExecute: "NoExecute"
            case .noSchedule: "NoSchedule"
            case .preferNoSchedule: "PreferNoSchedule"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.SKSNodepool {
    struct Taint: Codable, Hashable, Sendable {
        public let value: String?
        public let effect: Effect?

        public init(value: String? = nil, effect: Effect? = nil) {
            self.value = value
            self.effect = effect
        }
    }
}

extension Exoscale.SKSNodepool.KubeletImageGC {
    enum CodingKeys: String, CodingKey {
        case highThreshold = "high-threshold"
        case lowThreshold = "low-threshold"
        case minAge = "min-age"
    }
}

public extension Exoscale.SKSNodepool {
    struct KubeletImageGC: Codable, Hashable, Sendable {
        public let highThreshold: Int?
        public let lowThreshold: Int?
        public let minAge: String?

        public init(
            highThreshold: Int? = nil,
            lowThreshold: Int? = nil,
            minAge: String? = nil
        ) {
            self.highThreshold = highThreshold
            self.lowThreshold = lowThreshold
            self.minAge = minAge
        }
    }
}

public extension Exoscale.SKSNodepool {
    enum PublicIPAssignment: Exoscale.ExtensibleEnum {
        case inet4
        case dual
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.inet4, .dual]

        public var rawValue: String {
            switch self {
            case .inet4: "inet4"
            case .dual: "dual"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.SKSNodepool {
    enum State: Exoscale.ExtensibleEnum {
        case renewingToken
        case creating
        case deleting
        case running
        case scaling
        case updating
        case degraded
        case error
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .renewingToken,
            .creating,
            .deleting,
            .running,
            .scaling,
            .updating,
            .degraded,
            .error
        ]

        public var rawValue: String {
            switch self {
            case .renewingToken: "renewing-token"
            case .creating: "creating"
            case .deleting: "deleting"
            case .running: "running"
            case .scaling: "scaling"
            case .updating: "updating"
            case .degraded: "degraded"
            case .error: "error"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.SKSNodepool {
    enum Addon: Exoscale.ExtensibleEnum {
        case storageLVM
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.storageLVM]

        public var rawValue: String {
            switch self {
            case .storageLVM: "storage-lvm"
            case let .unknown(value): value
            }
        }
    }
}
