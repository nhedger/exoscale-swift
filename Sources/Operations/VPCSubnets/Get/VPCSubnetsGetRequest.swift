import Foundation

extension VPCSubnetsOperations.Get {
    struct Request: HttpRequest {
        let vpcID: String
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/vpc/\(vpcID)/subnet/\(id)"
            )
        }
    }
}
