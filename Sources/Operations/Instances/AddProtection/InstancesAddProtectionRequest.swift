import Foundation

extension InstancesOperations.AddProtection {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .put,
                path: "/instance/\(id):add-protection"
            )
        }
    }
}
