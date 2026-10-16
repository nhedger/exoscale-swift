import Foundation

extension SSHKeysOperations.Delete {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/ssh-key/\(name)"
            )
        }
    }
}
