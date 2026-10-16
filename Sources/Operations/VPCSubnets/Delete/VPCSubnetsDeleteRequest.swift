import Foundation

extension VPCSubnetsOperations.Delete {
    struct Request: HttpRequest {
        let vpcID: String
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/vpc/\(vpcID)/subnet/\(id)"
            )
        }
    }
}
