/// Access to compute API operations.
public final class ComputeResource {
    let http: Http.Client

    /// Access to anti-affinity group API operations.
    public lazy var antiAffinityGroups = AntiAffinityGroupsResource(http: http)

    /// Access to Deploy Target API operations.
    public lazy var deployTargets = DeployTargetsResource(http: http)

    /// Access to Elastic IP API operations.
    public lazy var elasticIPs = ElasticIPsResource(http: http)

    /// Access to compute instance API operations.
    public lazy var instances = InstancesResource(http: http)

    /// Access to Instance Pool API operations.
    public lazy var instancePools = InstancePoolsResource(http: http)

    /// Access to compute instance type API operations.
    public lazy var instanceTypes = InstanceTypesResource(http: http)

    /// Access to network load balancer API operations.
    public lazy var loadBalancers = LoadBalancersResource(http: http)

    /// Access to Private Network API operations.
    public lazy var privateNetworks = PrivateNetworksResource(http: http)

    /// Access to reverse DNS API operations.
    public lazy var reverseDNS = ReverseDNSResource(http: http)

    /// Access to Security Group API operations.
    public lazy var securityGroups = SecurityGroupsResource(http: http)

    /// Access to snapshot API operations.
    public lazy var snapshots = SnapshotsResource(http: http)

    /// Access to SSH key API operations.
    public lazy var sshKeys = SSHKeysResource(http: http)

    /// Access to template API operations.
    public lazy var templates = TemplatesResource(http: http)

    init(http: Http.Client) {
        self.http = http
    }
}
