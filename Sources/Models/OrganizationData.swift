import Foundation

extension Exoscale.Organization {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let name: String?
        let address: String?
        let postcode: String?
        let city: String?
        let country: String?
        let balance: Double?
        let currency: String?
    }
}
