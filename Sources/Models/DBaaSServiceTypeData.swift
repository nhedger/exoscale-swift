import Foundation

extension Exoscale.DBaaS.ServiceType {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: String?
        let availableVersions: [String]?
        let defaultVersion: String?
        let description: String?
        let plans: [Plan]?
    }
}

extension Exoscale.DBaaS.ServiceType.Payload {
    enum CodingKeys: String, CodingKey {
        case name
        case availableVersions = "available-versions"
        case defaultVersion = "default-version"
        case description
        case plans
    }
}
