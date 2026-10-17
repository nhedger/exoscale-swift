import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// A client for the Exoscale API in one zone.
///
/// ```swift
/// let exoscale = try Exoscale()
/// let instances = try await exoscale.instances.list()
/// ```
public final class Exoscale: Sendable {
    /// The credentials, zone and request settings this client uses.
    public let configuration: Configuration

    let client: HTTPClient

    /// Creates a client from a configuration.
    ///
    /// - Parameters:
    ///   - configuration: The credentials, zone and request settings to use.
    ///   - sessionConfiguration: The URL session configuration, for example to set timeouts or to
    ///     answer requests locally in tests.
    /// - Throws: ``ClientError/invalidZone(_:)`` when the zone can't be part of a hostname.
    public init(configuration: Configuration, sessionConfiguration: URLSessionConfiguration = .default) throws {
        self.configuration = configuration
        client = try HTTPClient(configuration: configuration, sessionConfiguration: sessionConfiguration)
    }

    /// Creates a client from explicit credentials.
    ///
    /// - Parameters:
    ///   - apiKey: The API key, such as `EXO…`.
    ///   - apiSecret: The API secret.
    ///   - zone: The zone to work in.
    public convenience init(apiKey: String, apiSecret: String, zone: Zone = .chGva2) throws {
        try self.init(configuration: Configuration(apiKey: apiKey, apiSecret: apiSecret, zone: zone))
    }

    /// Creates a client from the `EXOSCALE_API_KEY`, `EXOSCALE_API_SECRET`, `EXOSCALE_ZONE` and
    /// `EXOSCALE_USER_AGENT` environment variables.
    public convenience init() throws {
        try self.init(configuration: Configuration.fromEnvironment())
    }

    /// Dedicated inference: AI models, deployments and their API keys.
    public var ai: AI {
        AI(client: client)
    }

    /// API keys of the organization.
    public var apiKeys: APIKeys {
        APIKeys(client: client)
    }

    /// Groups whose instances run on different hypervisors.
    public var antiAffinityGroups: AntiAffinityGroups {
        AntiAffinityGroups(client: client)
    }

    /// Block storage volumes and their snapshots.
    public var blockStorage: BlockStorage {
        BlockStorage(client: client)
    }

    /// Encryption, decryption and signatures with KMS keys.
    public var crypto: Crypto {
        Crypto(client: client)
    }

    /// Managed database services (DBaaS).
    public var dbaas: DBaaS {
        DBaaS(client: client)
    }

    /// Dedicated hypervisors and edge locations instances can be placed on.
    public var deployTargets: DeployTargets {
        DeployTargets(client: client)
    }

    /// The environmental impact of the organization's usage (beta).
    public var environmentalImpact: EnvironmentalImpact {
        EnvironmentalImpact(client: client)
    }

    /// The organization's audit trail of requests that changed something through the API.
    public var events: Events {
        Events(client: client)
    }

    /// DNS domains hosted by Exoscale.
    public var domains: Domains {
        Domains(client: client)
    }

    /// Elastic IPs: public IP addresses that can move between instances.
    public var elasticIPs: ElasticIPs {
        ElasticIPs(client: client)
    }

    /// Compute instances.
    public var instances: Instances {
        Instances(client: client)
    }

    /// Instance pools: groups of identical instances kept at a given size.
    public var instancePools: InstancePools {
        InstancePools(client: client)
    }

    /// Instance types, which set an instance's CPU, memory and GPUs.
    public var instanceTypes: InstanceTypes {
        InstanceTypes(client: client)
    }

    /// External key stores, whose keys are held outside Exoscale (beta).
    public var keyStores: KeyStores {
        KeyStores(client: client)
    }

    /// Keys of the Key Management Service (KMS).
    public var kmsKeys: KMSKeys {
        KMSKeys(client: client)
    }

    /// Network load balancers, spreading traffic across the instances of instance pools.
    public var loadBalancers: LoadBalancers {
        LoadBalancers(client: client)
    }

    /// Simple Object Storage (SOS) buckets.
    public var objectStorage: ObjectStorage {
        ObjectStorage(client: client)
    }

    /// The organization, its balance and its usage.
    public var organization: OrganizationResource {
        OrganizationResource(client: client)
    }

    /// The organization's IAM policy, which applies on top of every role's.
    public var organizationPolicy: OrganizationPolicy {
        OrganizationPolicy(client: client)
    }

    /// Private networks: layer 2 networks between instances in a zone.
    public var privateNetworks: PrivateNetworks {
        PrivateNetworks(client: client)
    }

    /// The organization's resource quotas.
    public var quotas: Quotas {
        Quotas(client: client)
    }

    /// Reverse DNS (PTR) records of instances and Elastic IPs.
    public var reverseDNS: ReverseDNS {
        ReverseDNS(client: client)
    }

    /// IAM roles.
    public var roles: Roles {
        Roles(client: client)
    }

    /// Security groups: sets of firewall rules applied to the instances in them.
    public var securityGroups: SecurityGroups {
        SecurityGroups(client: client)
    }

    /// Managed Kubernetes clusters (SKS).
    public var sksClusters: SKSClusters {
        SKSClusters(client: client)
    }

    /// Snapshots of instances' root disks.
    public var snapshots: Snapshots {
        Snapshots(client: client)
    }

    /// SSH public keys that can be installed on new instances.
    public var sshKeys: SSHKeys {
        SSHKeys(client: client)
    }

    /// Disk images instances are created from.
    public var templates: Templates {
        Templates(client: client)
    }

    /// Users of the organization.
    public var users: Users {
        Users(client: client)
    }

    /// Virtual private clouds: routed private networks for instances (beta).
    public var vpcs: VPCs {
        VPCs(client: client)
    }

    /// The zones Exoscale operates.
    public var zones: Zones {
        Zones(client: client)
    }

    /// Asynchronous operations started by calls that change resources.
    public var operations: Operations {
        Operations(client: client)
    }
}
