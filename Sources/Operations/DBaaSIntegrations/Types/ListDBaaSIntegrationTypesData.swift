import Foundation

/// Response for listing DBaaS integration types.
struct ListDBaaSIntegrationTypesData: Decodable, Sendable {
    let dbaasIntegrationTypes: [Exoscale.DBaaS.IntegrationTypeInfo.Payload]

    enum CodingKeys: String, CodingKey {
        case dbaasIntegrationTypes = "dbaas-integration-types"
    }
}
