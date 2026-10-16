import Foundation

extension InstancePoolsOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let applicationConsistentSnapshotEnabled: Bool?
        let antiAffinityGroupIDs: [String]?
        let description: String?
        let publicIPAssignment: Exoscale.InstancePool.PublicIPAssignment?
        let labels: [String: String]?
        let securityGroupIDs: [String]?
        let elasticIPIDs: [String]?
        let name: String?
        let instanceTypeID: String?
        let minAvailable: Int?
        let privateNetworkIDs: [String]?
        let templateID: String?
        let sshKeyName: String?
        let instancePrefix: String?
        let userData: String?
        let deployTargetID: String?
        let ipv6Enabled: Bool?
        let diskSize: Int?
        let sshKeyNames: [String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateInstancePoolBody(
                    applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                    antiAffinityGroups: antiAffinityGroupIDs?.map(InstanceIDReference.init(id:)),
                    description: description,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    securityGroups: securityGroupIDs?.map(InstanceIDReference.init(id:)),
                    elasticIPs: elasticIPIDs?.map(InstanceIDReference.init(id:)),
                    name: name,
                    instanceType: instanceTypeID.map(InstanceIDReference.init(id:)),
                    minAvailable: minAvailable,
                    privateNetworks: privateNetworkIDs?.map(InstanceIDReference.init(id:)),
                    template: templateID.map(InstanceIDReference.init(id:)),
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
                method: .put,
                path: "/instance-pool/\(id)",
                body: body
            )
        }
    }
}
