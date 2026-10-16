import Foundation

extension InstancesOperations.ResetPassword {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/instance/\(id):reset-password"
            )
        }
    }
}
