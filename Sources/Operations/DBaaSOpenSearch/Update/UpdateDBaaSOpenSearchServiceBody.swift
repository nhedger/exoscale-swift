import Foundation

/// Request body for updating a DBaaS OpenSearch service.
struct UpdateDBaaSOpenSearchServiceBody: Encodable, Sendable {
    let maxIndexCount: Int?
    let keepIndexRefreshInterval: Bool?
    let ipFilter: [String]?
    let terminationProtection: Bool?
    let indexPatterns: [Exoscale.DBaaS.OpenSearch.IndexPattern]?
    let maintenance: Exoscale.DBaaS.Maintenance?
    let indexTemplate: Exoscale.DBaaS.OpenSearch.IndexTemplate?
    let opensearchSettings: [String: Exoscale.JSONValue]?
    let version: String?
    let plan: String?
    let opensearchDashboards: Exoscale.DBaaS.OpenSearch.Dashboards?

    enum CodingKeys: String, CodingKey {
        case maxIndexCount = "max-index-count"
        case keepIndexRefreshInterval = "keep-index-refresh-interval"
        case ipFilter = "ip-filter"
        case terminationProtection = "termination-protection"
        case indexPatterns = "index-patterns"
        case maintenance
        case indexTemplate = "index-template"
        case opensearchSettings = "opensearch-settings"
        case version
        case plan
        case opensearchDashboards = "opensearch-dashboards"
    }
}
