import Foundation

extension NodepoolsOperations.EvictMembers {
    struct Request: HttpRequest {
        let clusterID: String
        let id: String
        let instanceIDs: [String]

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(EvictSKSNodepoolMembersBody(instances: instanceIDs))

            return Http.Request(
                method: .put,
                path: "/sks-cluster/\(clusterID)/nodepool/\(id):evict",
                body: body
            )
        }
    }
}
