/// Access to SKS API operations.
public final class SKSResource: Sendable {
    let http: Http.Client

    /// Access to SKS cluster API operations.
    public let clusters: ClustersResource

    /// Access to SKS nodepool API operations.
    public let nodepools: NodepoolsResource

    /// Access to SKS nodepool template API operations.
    public let nodepoolTemplates: NodepoolTemplatesResource

    init(http: Http.Client) {
        self.http = http
        self.clusters = ClustersResource(http: http)
        self.nodepools = NodepoolsResource(http: http)
        self.nodepoolTemplates = NodepoolTemplatesResource(http: http)
    }
}
