import Foundation

extension InstancesOperations.RemoveProtection {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/instance/\(id):remove-protection"
            )
        }
    }
}
