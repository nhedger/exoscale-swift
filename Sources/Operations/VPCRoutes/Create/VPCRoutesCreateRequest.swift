import Foundation

extension VPCRoutesOperations.Create {
    struct Request: HttpRequest {
        let vpcID: String
        let subnetID: String
        let destination: String
        let target: String
        let description: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(VPCRouteBody(
                destination: destination,
                target: target,
                description: description
            ))

            return Http.Request(
                method: .post,
                path: "/vpc/\(vpcID)/subnet/\(subnetID)/route",
                body: body
            )
        }
    }
}
