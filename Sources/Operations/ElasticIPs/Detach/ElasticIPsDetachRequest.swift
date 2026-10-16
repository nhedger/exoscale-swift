import Foundation

extension ElasticIPsOperations.Detach {
    struct Request: HttpRequest {
        let id: String
        let instanceID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ElasticIPInstanceBody(instanceID: instanceID))

            return Http.Request(
                method: .put,
                path: "/elastic-ip/\(id):detach",
                body: body
            )
        }
    }
}
