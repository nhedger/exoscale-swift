import Foundation

extension ClustersOperations.UpgradeServiceLevel {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/sks-cluster/\(id)/upgrade-service-level"
            )
        }
    }
}
