/// Access to SKS API operations.
public final class SKSResource {
    let http: Http.Client

    /// Access to SKS cluster API operations.
    public lazy var clusters = ClustersResource(http: http)

    /// Access to SKS nodepool API operations.
    public lazy var nodepools = NodepoolsResource(http: http)

    /// Access to SKS nodepool template API operations.
    public lazy var nodepoolTemplates = NodepoolTemplatesResource(http: http)

    init(http: Http.Client) {
        self.http = http
    }
}
