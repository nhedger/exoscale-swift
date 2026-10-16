import Foundation

extension InstancePoolsOperations.EvictMembers {
    struct Request: HttpRequest {
        let id: String
        let instanceIDs: [String]

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(EvictInstancePoolMembersBody(instances: instanceIDs))

            return Http.Request(
                method: .put,
                path: "/instance-pool/\(id):evict",
                body: body
            )
        }
    }
}
