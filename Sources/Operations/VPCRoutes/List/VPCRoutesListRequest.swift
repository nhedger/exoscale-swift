import Foundation

extension VPCRoutesOperations.List {
    struct Request: HttpRequest {
        let vpcID: String
        let subnetID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/vpc/\(vpcID)/subnet/\(subnetID)/route"
            )
        }
    }
}
