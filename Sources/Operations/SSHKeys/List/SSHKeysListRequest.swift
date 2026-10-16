import Foundation

extension SSHKeysOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ssh-key"
            )
        }
    }
}
