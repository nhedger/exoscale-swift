import Foundation

/// Response for listing DBaaS services.
struct ListDBaaSServicesData: Decodable, Sendable {
    let dbaasServices: [Exoscale.DBaaS.Service.Payload]

    enum CodingKeys: String, CodingKey {
        case dbaasServices = "dbaas-services"
    }
}
