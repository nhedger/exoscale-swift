import Foundation

extension Exoscale.DBaaS.Kafka.Service.ConnectionInfo {
    enum CodingKeys: String, CodingKey {
        case nodes
        case accessCert = "access-cert"
        case accessKey = "access-key"
        case connectURI = "connect-uri"
        case restURI = "rest-uri"
        case registryURI = "registry-uri"
    }
}

public extension Exoscale.DBaaS.Kafka.Service {
    struct ConnectionInfo: Codable, Hashable, Sendable {
        public let nodes: [String]?
        public let accessCert: String?
        public let accessKey: String?
        public let connectURI: String?
        public let restURI: String?
        public let registryURI: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            nodes: [String]? = nil,
            accessCert: String? = nil,
            accessKey: String? = nil,
            connectURI: String? = nil,
            restURI: String? = nil,
            registryURI: String? = nil
        ) {
            self.nodes = nodes
            self.accessCert = accessCert
            self.accessKey = accessKey
            self.connectURI = connectURI
            self.restURI = restURI
            self.registryURI = registryURI
        }
    }
}

extension Exoscale.DBaaS.Kafka.Service.User {
    enum CodingKeys: String, CodingKey {
        case type
        case username
        case password
        case accessCert = "access-cert"
        case accessCertExpiry = "access-cert-expiry"
        case accessKey = "access-key"
    }
}

public extension Exoscale.DBaaS.Kafka.Service {
    struct User: Codable, Hashable, Sendable {
        public let type: String?
        public let username: String?
        public let password: String?
        public let accessCert: String?
        public let accessCertExpiry: Date?
        public let accessKey: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            type: String? = nil,
            username: String? = nil,
            password: String? = nil,
            accessCert: String? = nil,
            accessCertExpiry: Date? = nil,
            accessKey: String? = nil
        ) {
            self.type = type
            self.username = username
            self.password = password
            self.accessCert = accessCert
            self.accessCertExpiry = accessCertExpiry
            self.accessKey = accessKey
        }
    }
}
