/// Response for retrieving an SKS cluster authority certificate.
public struct GetSKSClusterAuthorityCertificateResponse: Codable, Sendable {
    public let caCert: String

    enum CodingKeys: String, CodingKey {
        case caCert = "cacert"
    }
}
