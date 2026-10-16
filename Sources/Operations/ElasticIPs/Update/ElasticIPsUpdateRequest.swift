import Foundation

extension ElasticIPsOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let description: String?
        let healthcheck: Exoscale.ElasticIP.Healthcheck?
        let labels: [String: String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateElasticIPBody(
                    description: description,
                    healthcheck: healthcheck,
                    labels: labels
                )
            )

            return Http.Request(
                method: .put,
                path: "/elastic-ip/\(id)",
                body: body
            )
        }
    }
}
