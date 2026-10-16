import Foundation

public extension Exoscale {
    /// Partial instance data returned by list endpoints and embedded resource responses.
    ///
    /// Call `resolve()` to retrieve full instance details and actions. Embedded
    /// objects reflect only the fields supplied by the list response.
    struct InstanceSummary: Hashable, Identifiable, Sendable {
        public let id: String
        /// The instance name, when included in the response.
        public let name: String?
        public let state: Instance.State?
        public let createdAt: Date?
        public let publicIpAssignment: Instance.PublicIPAssignment?
        public let publicIp: String?
        public let ipv6Address: String?
        public let macAddress: String?
        public let labels: [String: String]?
        public let securityGroups: [SecurityGroup]?
        public let instanceType: InstanceType?
        public let privateNetworks: [Instance.PrivateNetwork]?
        public let template: Template?
        public let sshKey: SSHKey?
        public let sshKeys: [SSHKey]?
        public let manager: Manager?

        let client: Http.Client

        /// Creates a model bound to `client`, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            state: Instance.State? = nil,
            createdAt: Date? = nil,
            publicIpAssignment: Instance.PublicIPAssignment? = nil,
            publicIp: String? = nil,
            ipv6Address: String? = nil,
            macAddress: String? = nil,
            labels: [String: String]? = nil,
            securityGroups: [SecurityGroup]? = nil,
            instanceType: InstanceType? = nil,
            privateNetworks: [Instance.PrivateNetwork]? = nil,
            template: Template? = nil,
            sshKey: SSHKey? = nil,
            sshKeys: [SSHKey]? = nil,
            manager: Manager? = nil,
            client: Exoscale
        ) {
            self.id = id
            self.name = name
            self.state = state
            self.createdAt = createdAt
            self.publicIpAssignment = publicIpAssignment
            self.publicIp = publicIp
            self.ipv6Address = ipv6Address
            self.macAddress = macAddress
            self.labels = labels
            self.securityGroups = securityGroups
            self.instanceType = instanceType
            self.privateNetworks = privateNetworks
            self.template = template
            self.sshKey = sshKey
            self.sshKeys = sshKeys
            self.manager = manager
            self.client = client.http
        }

        init(data: Payload, client: Http.Client) {
            id = data.id
            name = data.name
            state = data.state
            createdAt = data.createdAt
            publicIpAssignment = data.publicIpAssignment
            publicIp = data.publicIp
            ipv6Address = data.ipv6Address
            macAddress = data.macAddress
            labels = data.labels
            securityGroups = data.securityGroups?.map { SecurityGroup(data: $0, client: client) }
            instanceType = data.instanceType.map { InstanceType(data: $0, client: client) }
            privateNetworks = data.privateNetworks
            template = data.template.map { Template(data: $0, client: client) }
            sshKey = data.sshKey.map { SSHKey(data: $0, client: client) }
            sshKeys = data.sshKeys?.map { SSHKey(data: $0, client: client) }
            manager = data.manager.map { Manager(data: $0, client: client) }
            self.client = client
        }

        /// Retrieves a full instance snapshot using the originating client.
        public func resolve() async throws -> Instance {
            try await InstancesResource(http: client).get(id: id)
        }
    }
}
