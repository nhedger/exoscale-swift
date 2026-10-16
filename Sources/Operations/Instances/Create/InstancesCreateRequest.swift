import Foundation

extension InstancesOperations.Create {
    struct Request: HttpRequest {
        let diskSize: Int
        let instanceTypeID: String
        let templateID: String
        let applicationConsistentSnapshotEnabled: Bool?
        let antiAffinityGroupIDs: [String]?
        let publicIPAssignment: Exoscale.Instance.PublicIPAssignment?
        let labels: [String: String]?
        let autoStart: Bool?
        let securityGroupIDs: [String]?
        let name: String?
        let secureBootEnabled: Bool?
        let sshKeyName: String?
        let userData: String?
        let tpmEnabled: Bool?
        let deployTargetID: String?
        let ipv6Enabled: Bool?
        let sshKeyNames: [String]?
        var ipForwarding: Bool?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateInstanceBody(
                    applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                    antiAffinityGroups: antiAffinityGroupIDs?.map { InstanceIDReference(id: $0) },
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    autoStart: autoStart,
                    securityGroups: securityGroupIDs?.map { InstanceIDReference(id: $0) },
                    name: name,
                    instanceType: InstanceIDReference(id: instanceTypeID),
                    template: InstanceIDReference(id: templateID),
                    secureBootEnabled: secureBootEnabled,
                    sshKey: sshKeyName.map { InstanceSSHKeyReference(name: $0) },
                    userData: userData,
                    tpmEnabled: tpmEnabled,
                    deployTarget: deployTargetID.map { InstanceIDReference(id: $0) },
                    ipv6Enabled: ipv6Enabled,
                    diskSize: diskSize,
                    sshKeys: sshKeyNames?.map { InstanceSSHKeyReference(name: $0) },
                    ipForwarding: ipForwarding
                )
            )

            return Http.Request(
                method: .post,
                path: "/instance",
                body: body
            )
        }
    }
}
