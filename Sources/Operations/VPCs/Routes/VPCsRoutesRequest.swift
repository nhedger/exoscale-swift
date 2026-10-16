import Foundation

extension VPCsOperations.Routes {
    struct Request: HttpRequest {
        let vpcID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/vpc/\(vpcID)/route"
            )
        }
    }
}
