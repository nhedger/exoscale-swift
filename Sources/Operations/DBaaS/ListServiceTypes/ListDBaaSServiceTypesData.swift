import Foundation

/// Response for listing DBaaS service types.
struct ListDBaaSServiceTypesData: Decodable, Sendable {
    let dbaasServiceTypes: [Exoscale.DBaaS.ServiceType.Payload]

    enum CodingKeys: String, CodingKey {
        case dbaasServiceTypes = "dbaas-service-types"
    }
}
