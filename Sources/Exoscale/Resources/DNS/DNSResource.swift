/// Access to DNS API operations.
public final class DNSResource: Sendable {
    let http: Http.Client

    /// Access to DNS domain API operations.
    public let domains: DomainsResource

    /// Access to DNS record API operations.
    public let records: RecordsResource

    init(http: Http.Client) {
        self.http = http
        self.domains = DomainsResource(http: http)
        self.records = RecordsResource(http: http)
    }
}
