/// Access to organization API operations.
public struct OrganizationResource: Sendable {
    let http: Http.Client

    /// Retrieves the organization's live balance (beta).
    public func liveBalance() async throws -> Exoscale.LiveBalance {
        try await http.execute(OrganizationOperations.LiveBalance(request: .init()))
    }

    /// Retrieves the current organization.
    ///
    /// - Returns: The organization returned by the API.
    public func get() async throws -> Exoscale.Organization {
        try await http.execute(OrganizationOperations.Get(request: .init()))
    }

    /// Retrieves the environmental impact report for the current organization.
    ///
    /// - Parameter period: Reporting period to retrieve.
    /// - Returns: The environmental impact report returned by the API.
    public func envImpact(period: String) async throws -> Exoscale.EnvImpactReport {
        try await http.execute(OrganizationOperations.EnvImpact(request: .init(period: period)))
    }

    /// Retrieves the environmental impact of the organization's usage over a period (beta).
    ///
    /// - Parameters:
    ///   - from: Optional start of the period.
    ///   - to: Optional end of the period.
    /// - Returns: The impact broken down by zone and along the product catalog.
    public func impactReport(from: String? = nil, to: String? = nil) async throws -> Exoscale.ImpactBreakdown {
        try await http.execute(OrganizationOperations.ImpactReport(request: .init(from: from, to: to)))
    }

    /// Estimates the environmental impact of one unit of usage of one or more products (beta).
    ///
    /// - Parameters:
    ///   - sku: A product SKU such as `compute:ch-gva-2:instance:standard:medium`, which may use `*`
    ///     wildcards to match several products.
    ///   - metadata: Optional product-specific configuration details.
    /// - Returns: The estimated impact of each matching SKU.
    public func impactEstimate(
        sku: String,
        metadata: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.ImpactEstimate {
        try await http.execute(OrganizationOperations.ImpactEstimate(request: .init(sku: sku, metadata: metadata)))
    }

    /// Retrieves aggregated usage reports for the current organization.
    ///
    /// - Parameter period: Optional reporting period filter.
    /// - Returns: The usage report returned by the API.
    public func usageReport(period: String? = nil) async throws -> Exoscale.UsageReport {
        try await http.execute(OrganizationOperations.UsageReport(request: .init(period: period)))
    }
}
