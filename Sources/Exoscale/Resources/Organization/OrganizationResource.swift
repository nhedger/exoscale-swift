/// Access to organization API operations.
public struct OrganizationResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves the current organization.
    ///
    /// - Returns: The organization returned by the API.
    public func get() async throws -> Exoscale.Organization {
        try await http.get(path: "/organization", as: Exoscale.Organization.self)
    }

    /// Retrieves the environmental impact report for the current organization.
    ///
    /// - Parameter period: Reporting period to retrieve.
    /// - Returns: The environmental impact report returned by the API.
    public func envImpact(period: String) async throws -> Exoscale.EnvImpactReport {
        try await http.get(path: "/env-impact/\(period)", as: Exoscale.EnvImpactReport.self)
    }

    /// Retrieves aggregated usage reports for the current organization.
    ///
    /// - Parameter period: Optional reporting period filter.
    /// - Returns: The usage report returned by the API.
    public func usageReport(period: String? = nil) async throws -> Exoscale.UsageReport {
        try await http.get(path: "/usage-report", query: ["period": period], as: Exoscale.UsageReport.self)
    }
}
