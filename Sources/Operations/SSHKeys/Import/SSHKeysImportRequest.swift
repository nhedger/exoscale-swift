import Foundation

extension SSHKeysOperations.Import {
    struct Request: HttpRequest {
        let name: String
        let publicKey: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ImportSSHKeyBody(name: name, publicKey: publicKey))
            return Http.Request(method: .post, path: "/ssh-key", body: body)
        }
    }
}
