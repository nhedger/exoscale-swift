import Foundation

/// Request body for creating a DBaaS Thanos service.
struct CreateDBaaSThanosServiceBody: Encodable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String
    let terminationProtection: Bool?
    let ipFilter: [String]?
    let thanosSettings: [String: Exoscale.JSONValue]?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case ipFilter = "ip-filter"
        case thanosSettings = "thanos-settings"
    }
}
