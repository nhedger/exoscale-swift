import Foundation

public final class Exoscale: Sendable {
    public let config: Exoscale.Config

    let http: Http.Client

    /// Access to AI API operations.
    public let ai: AIResource

    /// Access to audit API operations.
    public let audit: AuditResource

    /// Access to block storage API operations.
    public let blockStorage: BlockStorageResource

    /// Access to compute API operations.
    public let compute: ComputeResource

    /// Access to DBaaS API operations.
    public let dbaas: DBaaSResource

    /// Access to DNS API operations.
    public let dns: DNSResource

    /// Access to IAM API operations.
    public let iam: IAMResource

    /// Access to KMS API operations.
    public let kms: KMSResource

    /// Access to object storage API operations.
    public let objectStorage: ObjectStorageResource

    /// Access to operation API operations.
    public let operations: OperationsResource

    /// Access to organization API operations.
    public let organization: OrganizationResource

    /// Access to quota API operations.
    public let quotas: QuotasResource

    /// Access to SKS API operations.
    public let sks: SKSResource

    /// Access to zone-related API operations.
    public let zones: ZonesResource

    init(config: Exoscale.Config) {
        let http = Http.Client(config: config)

        self.config = config
        self.http = http
        self.ai = AIResource(http: http)
        self.audit = AuditResource(http: http)
        self.blockStorage = BlockStorageResource(http: http)
        self.compute = ComputeResource(http: http)
        self.dbaas = DBaaSResource(http: http)
        self.dns = DNSResource(http: http)
        self.iam = IAMResource(http: http)
        self.kms = KMSResource(http: http)
        self.objectStorage = ObjectStorageResource(http: http)
        self.operations = OperationsResource(http: http)
        self.organization = OrganizationResource(http: http)
        self.quotas = QuotasResource(http: http)
        self.sks = SKSResource(http: http)
        self.zones = ZonesResource(http: http)
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
