import Foundation

extension DBaaSExternalEndpointsOperations.Attach {
    struct Request: HttpRequest {
        let sourceServiceName: String
        let destinationEndpointID: String
        let type: Exoscale.DBaaS.ExternalEndpointType

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                AttachDBaaSExternalEndpointBody(destinationEndpointID: destinationEndpointID, type: type)
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-external-endpoint/\(sourceServiceName)/attach",
                body: body
            )
        }
    }
}
