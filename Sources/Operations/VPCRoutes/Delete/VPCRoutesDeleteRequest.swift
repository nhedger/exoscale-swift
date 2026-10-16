import Foundation

extension VPCRoutesOperations.Delete {
    struct Request: HttpRequest {
        let vpcID: String
        let subnetID: String
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/vpc/\(vpcID)/subnet/\(subnetID)/route/\(id)"
            )
        }
    }
}
