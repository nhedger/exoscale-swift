import Foundation

extension Exoscale.DBaaS.Kafka.UserSecrets {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let username: String?
        let password: String?
        let accessCert: String?
        let accessCertExpiry: Date?
        let accessKey: String?
    }
}

extension Exoscale.DBaaS.Kafka.UserSecrets.Payload {
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case accessCert = "access-cert"
        case accessCertExpiry = "access-cert-expiry"
        case accessKey = "access-key"
    }
}
