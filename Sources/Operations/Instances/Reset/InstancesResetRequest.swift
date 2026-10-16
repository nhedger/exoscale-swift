import Foundation

extension InstancesOperations.Reset {
    struct Request: HttpRequest {
        let id: String
        let templateID: String?
        let diskSize: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                ResetInstanceBody(
                    template: templateID.map { InstanceIDReference(id: $0) },
                    diskSize: diskSize
                )
            )

            return Http.Request(
                method: .put,
                path: "/instance/\(id):reset",
                body: body
            )
        }
    }
}
