import Foundation

extension DBaaSOpenSearchOperations.Update {
    struct Request: HttpRequest {
        let name: String
        let plan: String?
        let maxIndexCount: Int?
        let keepIndexRefreshInterval: Bool?
        let ipFilter: [String]?
        let terminationProtection: Bool?
        let indexPatterns: [Exoscale.DBaaS.OpenSearch.IndexPattern]?
        let maintenance: Exoscale.DBaaS.Maintenance?
        let indexTemplate: Exoscale.DBaaS.OpenSearch.IndexTemplate?
        let opensearchSettings: [String: Exoscale.JSONValue]?
        let version: String?
        let opensearchDashboards: Exoscale.DBaaS.OpenSearch.Dashboards?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateDBaaSOpenSearchServiceBody(
                    maxIndexCount: maxIndexCount,
                    keepIndexRefreshInterval: keepIndexRefreshInterval,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    indexPatterns: indexPatterns,
                    maintenance: maintenance,
                    indexTemplate: indexTemplate,
                    opensearchSettings: opensearchSettings,
                    version: version,
                    plan: plan,
                    opensearchDashboards: opensearchDashboards
                )
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-opensearch/\(name)",
                body: body
            )
        }
    }
}
