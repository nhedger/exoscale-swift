import Foundation

public extension Exoscale {
    /// A template SKS node pools can create their nodes from. List them with
    /// ``SKSClusters/templates(kubernetesVersion:variant:)``.
    struct SKSNodepoolTemplate: Hashable, Codable, Sendable {
        /// The template's identifier.
        public let id: String
        /// The template's name.
        public let name: String?
        /// Whether the template is for standard nodes or NVIDIA GPU nodes.
        public let variant: SKSNodepool.TemplateVariant?
        /// When the template was registered.
        public let createdAt: Date?

        /// Creates a template, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            variant: SKSNodepool.TemplateVariant? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.variant = variant
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, variant
            case createdAt = "created-at"
        }
    }
}
