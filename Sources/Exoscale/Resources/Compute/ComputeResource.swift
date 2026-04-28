/// Access to compute API operations.
public final class ComputeResource: Sendable {
    let http: Http.Client

    /// Access to anti-affinity group API operations.
    public let antiAffinityGroups: AntiAffinityGroupsResource

    /// Access to Deploy Target API operations.
    public let deployTargets: DeployTargetsResource

    /// Access to Elastic IP API operations.
    public let elasticIPs: ElasticIPsResource

    /// Access to compute instance API operations.
    public let instances: InstancesResource

    /// Access to Instance Pool API operations.
    public let instancePools: InstancePoolsResource

    /// Access to compute instance type API operations.
    public let instanceTypes: InstanceTypesResource

    /// Access to network load balancer API operations.
    public let loadBalancers: LoadBalancersResource

    /// Access to Private Network API operations.
    public let privateNetworks: PrivateNetworksResource

    /// Access to reverse DNS API operations.
    public let reverseDNS: ReverseDNSResource

    /// Access to Security Group API operations.
    public let securityGroups: SecurityGroupsResource

    /// Access to snapshot API operations.
    public let snapshots: SnapshotsResource

    /// Access to SSH key API operations.
    public let sshKeys: SSHKeysResource

    /// Access to template API operations.
    public let templates: TemplatesResource

    init(http: Http.Client) {
        self.http = http
        self.antiAffinityGroups = AntiAffinityGroupsResource(http: http)
        self.deployTargets = DeployTargetsResource(http: http)
        self.elasticIPs = ElasticIPsResource(http: http)
        self.instances = InstancesResource(http: http)
        self.instancePools = InstancePoolsResource(http: http)
        self.instanceTypes = InstanceTypesResource(http: http)
        self.loadBalancers = LoadBalancersResource(http: http)
        self.privateNetworks = PrivateNetworksResource(http: http)
        self.reverseDNS = ReverseDNSResource(http: http)
        self.securityGroups = SecurityGroupsResource(http: http)
        self.snapshots = SnapshotsResource(http: http)
        self.sshKeys = SSHKeysResource(http: http)
        self.templates = TemplatesResource(http: http)
    }
}
