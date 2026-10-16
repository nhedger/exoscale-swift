import Foundation

extension DBaaSExternalEndpointsOperations.Detach {
    struct Request: HttpRequest {
        let sourceServiceName: String
        let integrationID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(DetachDBaaSExternalEndpointBody(integrationID: integrationID))

            return Http.Request(
                method: .put,
                path: "/dbaas-external-endpoint/\(sourceServiceName)/detach",
                body: body
            )
        }
    }
}
