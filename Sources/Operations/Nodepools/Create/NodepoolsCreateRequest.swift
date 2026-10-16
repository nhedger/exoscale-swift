import Foundation

extension NodepoolsOperations.Create {
    struct Request: HttpRequest {
        let clusterID: String
        let name: String
        let size: Int
        let diskSize: Int
        let instanceTypeID: String
        let antiAffinityGroupIDs: [String]?
        let description: String?
        let publicIPAssignment: Exoscale.SKSNodepool.PublicIPAssignment?
        let labels: [String: String]?
        let taints: [String: Exoscale.SKSNodepool.Taint]?
        let securityGroupIDs: [String]?
        let privateNetworkIDs: [String]?
        let kubeletImageGC: Exoscale.SKSNodepool.KubeletImageGC?
        let instancePrefix: String?
        let deployTargetID: String?
        let addons: [Exoscale.SKSNodepool.Addon]?
        let nvidiaMIGProfiles: Exoscale.NvidiaMIGProfiles?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateSKSNodepoolBody(
                    antiAffinityGroups: antiAffinityGroupIDs?.map(SKSNodepoolReference.init(id:)),
                    description: description,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    taints: taints,
                    securityGroups: securityGroupIDs?.map(SKSNodepoolReference.init(id:)),
                    name: name,
                    instanceType: SKSNodepoolReference(id: instanceTypeID),
                    privateNetworks: privateNetworkIDs?.map(SKSNodepoolReference.init(id:)),
                    size: size,
                    kubeletImageGC: kubeletImageGC,
                    instancePrefix: instancePrefix,
                    deployTarget: deployTargetID.map(SKSNodepoolReference.init(id:)),
                    addons: addons,
                    diskSize: diskSize,
                    nvidiaMIGProfiles: nvidiaMIGProfiles
                )
            )

            return Http.Request(
                method: .post,
                path: "/sks-cluster/\(clusterID)/nodepool",
                body: body
            )
        }
    }
}
