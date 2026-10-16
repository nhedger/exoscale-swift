import Foundation

extension AIOperations.ConsumptionQuota {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ai/quota"
            )
        }
    }
}
