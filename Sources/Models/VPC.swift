import Foundation

public extension Exoscale {
    /// Virtual private cloud (beta).
    struct VPC: Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let description: String?
        public let createdAt: Date?
        public let labels: [String: String]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            description: String? = nil,
            createdAt: Date? = nil,
            labels: [String: String]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.labels = labels
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            name = data.name
            description = data.description
            createdAt = data.createdAt
            labels = data.labels
        }
    }

    /// VPC subnet (beta). Instance attachments are returned by detail endpoints.
    struct VPCSubnet: Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let description: String?
        public let createdAt: Date?
        public let labels: [String: String]?
        public let addressFamily: String?
        public let addressSpace: String?
        public let ipv4Block: String?
        public let instances: [Instance]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            description: String? = nil,
            createdAt: Date? = nil,
            labels: [String: String]? = nil,
            addressFamily: String? = nil,
            addressSpace: String? = nil,
            ipv4Block: String? = nil,
            instances: [Instance]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.labels = labels
            self.addressFamily = addressFamily
            self.addressSpace = addressSpace
            self.ipv4Block = ipv4Block
            self.instances = instances
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            name = data.name
            description = data.description
            createdAt = data.createdAt
            labels = data.labels
            addressFamily = data.addressFamily
            addressSpace = data.addressSpace
            ipv4Block = data.ipv4Block
            instances = data.instances
        }
    }

    /// A VPC or subnet route (beta).
    struct VPCRoute: Hashable, Sendable {
        public let id: String?
        public let kind: Kind?
        public let description: String?
        public let destination: String?
        public let target: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            kind: Kind? = nil,
            description: String? = nil,
            destination: String? = nil,
            target: String? = nil
        ) {
            self.id = id
            self.kind = kind
            self.description = description
            self.destination = destination
            self.target = target
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            kind = data.kind
            description = data.description
            destination = data.destination
            target = data.target
        }
    }
}

public extension Exoscale.VPCSubnet {
    struct Instance: Codable, Hashable, Sendable {
        public let id: String?
        public let ipv4: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            ipv4: String? = nil
        ) {
            self.id = id
            self.ipv4 = ipv4
        }
    }
}

public extension Exoscale.VPCRoute {
    enum Kind: Exoscale.ExtensibleEnum {
        case subnet
        case vpc
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.subnet, .vpc]

        public var rawValue: String {
            switch self {
            case .subnet: "Subnet"
            case .vpc: "Vpc"
            case let .unknown(value): value
            }
        }
    }
}
