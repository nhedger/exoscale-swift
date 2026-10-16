import Foundation

extension ZonesOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/zone"
            )
        }
    }
}
