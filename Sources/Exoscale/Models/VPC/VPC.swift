import Foundation

public extension Exoscale {
    /// Virtual private cloud (beta).
    struct VPC: Codable, Sendable {
        public let id: String?
        public let name: String?
        public let description: String?
        public let createdAt: Date?
        public let labels: [String: String]?

        enum CodingKeys: String, CodingKey {
            case id, name, description, labels
            case createdAt = "created-at"
        }
    }

    /// VPC subnet (beta). Instance attachments are returned by detail endpoints.
    struct VPCSubnet: Codable, Sendable {
        public struct Instance: Codable, Sendable {
            public let id: String?
            public let ipv4: String?
        }

        public let id: String?
        public let name: String?
        public let description: String?
        public let createdAt: Date?
        public let labels: [String: String]?
        public let addressFamily: String?
        public let addressSpace: String?
        public let ipv4Block: String?
        public let instances: [Instance]?

        enum CodingKeys: String, CodingKey {
            case id, name, description, labels, instances
            case createdAt = "created-at"
            case addressFamily = "addressfamily"
            case addressSpace = "address-space"
            case ipv4Block = "ipv4-block"
        }
    }

    /// A VPC or subnet route (beta).
    struct VPCRoute: Codable, Sendable {
        public enum Kind: String, Codable, Sendable {
            case subnet = "Subnet"
            case vpc = "Vpc"
        }

        public let id: String?
        public let kind: Kind?
        public let description: String?
        public let destination: String?
        public let target: String?
    }
}
