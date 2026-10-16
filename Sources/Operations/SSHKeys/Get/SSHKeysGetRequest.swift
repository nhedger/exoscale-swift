import Foundation

extension SSHKeysOperations.Get {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/ssh-key/\(name)"
            )
        }
    }
}
