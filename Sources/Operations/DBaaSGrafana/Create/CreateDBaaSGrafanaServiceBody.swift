import Foundation

/// Request body for creating a DBaaS Grafana service.
struct CreateDBaaSGrafanaServiceBody: Encodable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String
    let terminationProtection: Bool?
    let forkFromService: String?
    let grafanaSettings: [String: Exoscale.JSONValue]?
    let ipFilter: [String]?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case forkFromService = "fork-from-service"
        case grafanaSettings = "grafana-settings"
        case ipFilter = "ip-filter"
    }
}
