import Foundation

extension ElasticIPsOperations.Create {
    struct Request: HttpRequest {
        let addressFamily: Exoscale.ElasticIP.AddressFamily?
        let description: String?
        let healthcheck: Exoscale.ElasticIP.Healthcheck?
        let labels: [String: String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateElasticIPBody(
                    addressFamily: addressFamily,
                    description: description,
                    healthcheck: healthcheck,
                    labels: labels
                )
            )

            return Http.Request(
                method: .post,
                path: "/elastic-ip",
                body: body
            )
        }
    }
}
