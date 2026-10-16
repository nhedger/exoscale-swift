import Foundation

extension InstancePoolsOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let size: Int
        let instanceTypeID: String
        let templateID: String
        let diskSize: Int
        let applicationConsistentSnapshotEnabled: Bool?
        let antiAffinityGroupIDs: [String]?
        let description: String?
        let publicIPAssignment: Exoscale.InstancePool.PublicIPAssignment?
        let labels: [String: String]?
        let securityGroupIDs: [String]?
        let elasticIPIDs: [String]?
        let minAvailable: Int?
        let privateNetworkIDs: [String]?
        let sshKeyName: String?
        let instancePrefix: String?
        let userData: String?
        let deployTargetID: String?
        let ipv6Enabled: Bool?
        let sshKeyNames: [String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateInstancePoolBody(
                    applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                    antiAffinityGroups: antiAffinityGroupIDs?.map(InstanceIDReference.init(id:)),
                    description: description,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    securityGroups: securityGroupIDs?.map(InstanceIDReference.init(id:)),
                    elasticIPs: elasticIPIDs?.map(InstanceIDReference.init(id:)),
                    name: name,
                    instanceType: InstanceIDReference(id: instanceTypeID),
                    minAvailable: minAvailable,
                    privateNetworks: privateNetworkIDs?.map(InstanceIDReference.init(id:)),
                    template: InstanceIDReference(id: templateID),
                    size: size,
                    sshKey: sshKeyName.map(InstanceSSHKeyReference.init(name:)),
                    instancePrefix: instancePrefix,
                    userData: userData,
                    deployTarget: deployTargetID.map(InstanceIDReference.init(id:)),
                    ipv6Enabled: ipv6Enabled,
                    diskSize: diskSize,
                    sshKeys: sshKeyNames?.map(InstanceSSHKeyReference.init(name:))
                )
            )

            return Http.Request(
                method: .post,
                path: "/instance-pool",
                body: body
            )
        }
    }
}
