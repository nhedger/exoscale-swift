import Foundation

/// Response for retrieving the DBaaS CA certificate.
struct GetDBaaSCACertificateData: Decodable, Sendable {
    let certificate: String
}
