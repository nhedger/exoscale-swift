import Foundation

extension ClustersOperations.DeprecatedResources {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/sks-cluster-deprecated-resources/\(id)"
            )
        }
    }
}
