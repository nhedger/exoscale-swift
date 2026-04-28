/// Access to DNS API operations.
public final class DNSResource {
    let http: Http.Client

    /// Access to DNS domain API operations.
    public lazy var domains = DomainsResource(http: http)

    /// Access to DNS record API operations.
    public lazy var records = RecordsResource(http: http)

    init(http: Http.Client) {
        self.http = http
    }
}
