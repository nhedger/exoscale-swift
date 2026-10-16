import Foundation

extension DeploymentsOperations.ListInstanceTypes {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/instance-type"
            )
        }
    }
}
