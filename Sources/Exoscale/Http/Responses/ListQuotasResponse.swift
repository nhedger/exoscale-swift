/// Response for listing organization quotas.
public struct ListQuotasResponse: Codable, Sendable {
    public let quotas: [Exoscale.Quota]
}
