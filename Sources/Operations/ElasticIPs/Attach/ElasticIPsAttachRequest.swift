import Foundation

extension ElasticIPsOperations.Attach {
    struct Request: HttpRequest {
        let id: String
        let instanceID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ElasticIPInstanceBody(instanceID: instanceID))

            return Http.Request(
                method: .put,
                path: "/elastic-ip/\(id):attach",
                body: body
            )
        }
    }
}
