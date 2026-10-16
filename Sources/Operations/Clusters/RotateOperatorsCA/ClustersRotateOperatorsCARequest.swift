import Foundation

extension ClustersOperations.RotateOperatorsCA {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/sks-cluster/\(id)/rotate-operators-ca"
            )
        }
    }
}
