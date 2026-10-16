import Foundation

extension NodepoolsOperations.Update {
    struct Request: HttpRequest {
        let clusterID: String
        let id: String
        let antiAffinityGroupIDs: [String]?
        let description: String?
        let publicIPAssignment: Exoscale.SKSNodepool.PublicIPAssignment?
        let labels: [String: String]?
        let taints: [String: Exoscale.SKSNodepool.Taint]?
        let securityGroupIDs: [String]?
        let name: String?
        let instanceTypeID: String?
        let privateNetworkIDs: [String]?
        let kubeletImageGC: Exoscale.SKSNodepool.KubeletImageGC?
        let instancePrefix: String?
        let deployTargetID: String?
        let diskSize: Int?
        let nvidiaMIGProfiles: Exoscale.NvidiaMIGProfiles?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateSKSNodepoolBody(
                    antiAffinityGroups: antiAffinityGroupIDs?.map(SKSNodepoolReference.init(id:)),
                    description: description,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    taints: taints,
                    securityGroups: securityGroupIDs?.map(SKSNodepoolReference.init(id:)),
                    name: name,
                    instanceType: instanceTypeID.map(SKSNodepoolReference.init(id:)),
                    privateNetworks: privateNetworkIDs?.map(SKSNodepoolReference.init(id:)),
                    kubeletImageGC: kubeletImageGC,
                    instancePrefix: instancePrefix,
                    deployTarget: deployTargetID.map(SKSNodepoolReference.init(id:)),
                    diskSize: diskSize,
                    nvidiaMIGProfiles: nvidiaMIGProfiles
                )
            )

            return Http.Request(
                method: .put,
                path: "/sks-cluster/\(clusterID)/nodepool/\(id)",
                body: body
            )
        }
    }
}
