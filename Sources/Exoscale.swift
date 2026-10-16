import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// An authenticated client for Exoscale resources in a configured zone.
public final class Exoscale: Sendable {
    /// Credentials, zone, and request defaults shared by this client's resources.
    public let config: Exoscale.Config

    let http: Http.Client

    /// Access to AI consumption quota operations.
    public let ai: AIResource

    /// Access to AI API key operations.
    public let aiAPIKeys: AIAPIKeysResource

    /// Access to anti-affinity group API operations.
    public let antiAffinityGroups: AntiAffinityGroupsResource

    /// Access to IAM API key operations.
    public let apiKeys: APIKeysResource

    /// Access to block storage API operations.
    public let blockStorage: BlockStorageResource

    /// Access to DBaaS ClickHouse API operations (beta).
    public let clickhouse: DBaaSClickHouseResource

    /// Access to SKS cluster API operations.
    public let clusters: ClustersResource

    /// Access to KMS crypto API operations.
    public let crypto: CryptoResource

    /// Access to DBaaS service-wide API operations.
    public let dbaas: DBaaSResource

    /// Access to AI deployment API operations.
    public let deployments: DeploymentsResource

    /// Access to Deploy Target API operations.
    public let deployTargets: DeployTargetsResource

    /// Access to DNS domain API operations.
    public let domains: DomainsResource

    /// Access to Elastic IP API operations.
    public let elasticIPs: ElasticIPsResource

    /// Access to audit event API operations.
    public let events: EventsResource

    /// Access to DBaaS external endpoint API operations.
    public let externalEndpoints: DBaaSExternalEndpointsResource

    /// Access to DBaaS external integration API operations.
    public let externalIntegrations: DBaaSExternalIntegrationsResource

    /// Access to DBaaS Grafana API operations.
    public let grafana: DBaaSGrafanaResource

    /// Access to Instance Pool API operations.
    public let instancePools: InstancePoolsResource

    /// Access to compute instance API operations.
    public let instances: InstancesResource

    /// Access to compute instance type API operations.
    public let instanceTypes: InstanceTypesResource

    /// Access to DBaaS service integration API operations.
    public let integrations: DBaaSIntegrationsResource

    /// Access to DBaaS Kafka API operations.
    public let kafka: DBaaSKafkaResource

    /// Access to KMS key API operations.
    public let kmsKeys: KMSKeysResource

    /// Access to network load balancer API operations.
    public let loadBalancers: LoadBalancersResource

    /// Access to AI model API operations.
    public let models: ModelsResource

    /// Access to DBaaS MySQL API operations.
    public let mysql: DBaaSMySQLResource

    /// Access to SKS nodepool API operations.
    public let nodepools: NodepoolsResource

    /// Access to SKS nodepool template API operations.
    public let nodepoolTemplates: NodepoolTemplatesResource

    /// Access to object storage API operations.
    public let objectStorage: ObjectStorageResource

    /// Access to DBaaS OpenSearch API operations.
    public let opensearch: DBaaSOpenSearchResource

    /// Access to operation API operations.
    public let operations: OperationsResource

    /// Access to organization API operations.
    public let organization: OrganizationResource

    /// Access to IAM organization policy API operations.
    public let organizationPolicy: OrganizationPolicyResource

    /// Access to DBaaS PostgreSQL API operations.
    public let postgresql: DBaaSPostgreSQLResource

    /// Access to Private Network API operations.
    public let privateNetworks: PrivateNetworksResource

    /// Access to quota API operations.
    public let quotas: QuotasResource

    /// Access to DNS record API operations.
    public let records: RecordsResource

    /// Access to reverse DNS API operations.
    public let reverseDNS: ReverseDNSResource

    /// Access to IAM role API operations.
    public let roles: RolesResource

    /// Access to Security Group API operations.
    public let securityGroups: SecurityGroupsResource

    /// Access to compute snapshot API operations.
    public let snapshots: SnapshotsResource

    /// Access to SSH key API operations.
    public let sshKeys: SSHKeysResource

    /// Access to compute template API operations.
    public let templates: TemplatesResource

    /// Access to DBaaS Thanos API operations.
    public let thanos: DBaaSThanosResource

    /// Access to organization user API operations.
    public let users: UsersResource

    /// Access to DBaaS Valkey API operations.
    public let valkey: DBaaSValkeyResource

    /// Access to VPC networking API operations (beta).
    public let vpcs: VPCsResource

    /// Access to zone-related API operations.
    public let zones: ZonesResource

    /// Creates a client whose requests use `sessionConfiguration`, for example to set timeouts or
    /// to answer requests locally in tests.
    public init(config: Exoscale.Config, sessionConfiguration: URLSessionConfiguration) {
        http = Http.Client(config: config, sessionConfiguration: sessionConfiguration)
        self.config = config
        ai = AIResource(http: http)
        aiAPIKeys = AIAPIKeysResource(http: http)
        antiAffinityGroups = AntiAffinityGroupsResource(http: http)
        apiKeys = APIKeysResource(http: http)
        blockStorage = BlockStorageResource(http: http)
        clickhouse = DBaaSClickHouseResource(http: http)
        clusters = ClustersResource(http: http)
        crypto = CryptoResource(http: http)
        dbaas = DBaaSResource(http: http)
        deployments = DeploymentsResource(http: http)
        deployTargets = DeployTargetsResource(http: http)
        domains = DomainsResource(http: http)
        elasticIPs = ElasticIPsResource(http: http)
        events = EventsResource(http: http)
        externalEndpoints = DBaaSExternalEndpointsResource(http: http)
        externalIntegrations = DBaaSExternalIntegrationsResource(http: http)
        grafana = DBaaSGrafanaResource(http: http)
        instancePools = InstancePoolsResource(http: http)
        instances = InstancesResource(http: http)
        instanceTypes = InstanceTypesResource(http: http)
        integrations = DBaaSIntegrationsResource(http: http)
        kafka = DBaaSKafkaResource(http: http)
        kmsKeys = KMSKeysResource(http: http)
        loadBalancers = LoadBalancersResource(http: http)
        models = ModelsResource(http: http)
        mysql = DBaaSMySQLResource(http: http)
        nodepools = NodepoolsResource(http: http)
        nodepoolTemplates = NodepoolTemplatesResource(http: http)
        objectStorage = ObjectStorageResource(http: http)
        opensearch = DBaaSOpenSearchResource(http: http)
        operations = OperationsResource(http: http)
        organization = OrganizationResource(http: http)
        organizationPolicy = OrganizationPolicyResource(http: http)
        postgresql = DBaaSPostgreSQLResource(http: http)
        privateNetworks = PrivateNetworksResource(http: http)
        quotas = QuotasResource(http: http)
        records = RecordsResource(http: http)
        reverseDNS = ReverseDNSResource(http: http)
        roles = RolesResource(http: http)
        securityGroups = SecurityGroupsResource(http: http)
        snapshots = SnapshotsResource(http: http)
        sshKeys = SSHKeysResource(http: http)
        templates = TemplatesResource(http: http)
        thanos = DBaaSThanosResource(http: http)
        users = UsersResource(http: http)
        valkey = DBaaSValkeyResource(http: http)
        vpcs = VPCsResource(http: http)
        zones = ZonesResource(http: http)
    }
}

public extension Exoscale {
    /// Creates a client using explicit credentials or configuration defaults.
    ///
    /// Explicit values override the supplied configuration. Missing credentials
    /// and zone settings are resolved from the environment and SDK defaults.
    ///
    /// - Parameters:
    ///   - apiKey: An API key overriding the configured or environment value.
    ///   - apiSecret: The API secret overriding the configured or environment value.
    ///   - zone: The zone overriding the configured or environment value.
    ///   - config: Optional credentials and request defaults to use as a starting point.
    /// - Throws: `Config.Error` when credentials are missing or the zone is invalid.
    convenience init(
        apiKey: String? = nil,
        apiSecret: String? = nil,
        zone: Exoscale.ZoneName? = nil,
        config: Exoscale.Config? = nil
    ) throws {
        let resolvedConfig = try Exoscale.Config(
            apiKey: apiKey ?? config?.apiKey,
            apiSecret: apiSecret ?? config?.apiSecret,
            zone: zone ?? config?.zone,
            userAgent: config?.userAgent
        )

        self.init(config: resolvedConfig, sessionConfiguration: .default)
    }
}
