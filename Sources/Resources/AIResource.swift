/// Access to AI consumption quota operations.
public struct AIResource: Sendable {
    let http: Http.Client

    /// Retrieves the organization's AI consumption quota in weighted units per minute.
    public func consumptionQuota() async throws -> Exoscale.AIConsumptionQuota {
        try await http.execute(AIOperations.ConsumptionQuota(request: .init()))
    }
}
