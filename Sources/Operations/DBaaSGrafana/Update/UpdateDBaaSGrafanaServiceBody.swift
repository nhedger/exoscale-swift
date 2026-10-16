import Foundation

/// Request body for updating a DBaaS Grafana service.
struct UpdateDBaaSGrafanaServiceBody: Encodable, Sendable {
    let maintenance: Exoscale.DBaaS.Maintenance?
    let plan: String?
    let terminationProtection: Bool?
    let grafanaSettings: [String: Exoscale.JSONValue]?
    let ipFilter: [String]?

    enum CodingKeys: String, CodingKey {
        case maintenance
        case plan
        case terminationProtection = "termination-protection"
        case grafanaSettings = "grafana-settings"
        case ipFilter = "ip-filter"
    }
}
