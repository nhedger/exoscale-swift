import Foundation

public final class Exoscale {
    public let config: Exoscale.Config

    let http: Http.Client

    /// Access to AI API operations.
    public lazy var ai = AIResource(http: http)

    /// Access to audit API operations.
    public lazy var audit = AuditResource(http: http)

    /// Access to block storage API operations.
    public lazy var blockStorage = BlockStorageResource(http: http)

    /// Access to compute API operations.
    public lazy var compute = ComputeResource(http: http)

    /// Access to DBaaS API operations.
    public lazy var dbaas = DBaaSResource(http: http)

    /// Access to DNS API operations.
    public lazy var dns = DNSResource(http: http)

    /// Access to IAM API operations.
    public lazy var iam = IAMResource(http: http)

    /// Access to KMS API operations.
    public lazy var kms = KMSResource(http: http)

    /// Access to object storage API operations.
    public lazy var objectStorage = ObjectStorageResource(http: http)

    /// Access to operation API operations.
    public lazy var operations = OperationsResource(http: http)

    /// Access to organization API operations.
    public lazy var organization = OrganizationResource(http: http)

    /// Access to quota API operations.
    public lazy var quotas = QuotasResource(http: http)

    /// Access to SKS API operations.
    public lazy var sks = SKSResource(http: http)

    /// Access to zone-related API operations.
    public lazy var zones = ZonesResource(http: http)

    init(config: Exoscale.Config) {
        self.config = config
        self.http = Http.Client(config: config)
    }
}

extension Exoscale {
    public convenience init(
        apiKey: String? = nil,
        apiSecret: String? = nil,
        zone: Exoscale.KnownZone? = nil,
        config: Exoscale.Config? = nil
    ) throws {
        let resolvedConfig = try Exoscale.Config(
            apiKey: apiKey ?? config?.apiKey,
            apiSecret: apiSecret ?? config?.apiSecret,
            zone: zone ?? config?.zone,
            userAgent: config?.userAgent
        )

        self.init(config: resolvedConfig)
    }
}
