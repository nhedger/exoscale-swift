import Foundation

extension DBaaSThanosOperations.StartMaintenance {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-thanos/\(name)/maintenance/start"
            )
        }
    }
}
