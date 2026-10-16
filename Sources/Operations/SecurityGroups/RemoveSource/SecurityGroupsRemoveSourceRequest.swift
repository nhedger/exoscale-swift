import Foundation

extension SecurityGroupsOperations.RemoveSource {
    struct Request: HttpRequest {
        let id: String
        let cidr: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(SecurityGroupExternalSourceBody(cidr: cidr))

            return Http.Request(
                method: .put,
                path: "/security-group/\(id):remove-source",
                body: body
            )
        }
    }
}
