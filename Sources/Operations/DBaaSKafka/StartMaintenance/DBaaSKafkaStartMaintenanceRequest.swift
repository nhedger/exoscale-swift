import Foundation

extension DBaaSKafkaOperations.StartMaintenance {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/dbaas-kafka/\(name)/maintenance/start"
            )
        }
    }
}
