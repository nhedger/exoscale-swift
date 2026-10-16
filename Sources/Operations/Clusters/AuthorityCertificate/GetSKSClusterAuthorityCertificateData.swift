import Foundation

/// Response for retrieving an SKS cluster authority certificate.
struct GetSKSClusterAuthorityCertificateData: Decodable, Sendable {
    let caCert: String

    enum CodingKeys: String, CodingKey {
        case caCert = "cacert"
    }
}
