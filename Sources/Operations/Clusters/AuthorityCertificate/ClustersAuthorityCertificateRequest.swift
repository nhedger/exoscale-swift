import Foundation

extension ClustersOperations.AuthorityCertificate {
    struct Request: HttpRequest {
        let id: String
        let authority: Exoscale.SKSCluster.Authority

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/sks-cluster/\(id)/authority/\(authority.rawValue)/cert"
            )
        }
    }
}
