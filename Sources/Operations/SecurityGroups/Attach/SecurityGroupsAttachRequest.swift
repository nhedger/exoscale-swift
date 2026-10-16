import Foundation

extension SecurityGroupsOperations.Attach {
    struct Request: HttpRequest {
        let id: String
        let instanceID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder()
                .encode(SecurityGroupInstanceBody(instance: InstanceIDReference(id: instanceID)))

            return Http.Request(
                method: .put,
                path: "/security-group/\(id):attach",
                body: body
            )
        }
    }
}
