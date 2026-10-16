import Foundation

extension ClustersOperations.RotateCSICredentials {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/sks-cluster/\(id)/rotate-csi-credentials"
            )
        }
    }
}
