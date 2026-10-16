import Foundation

extension VPCSubnetsOperations.DetachInstance {
    struct Request: HttpRequest {
        let vpcID: String
        let id: String
        let instanceID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(VPCSubnetInstanceBody(instance: .init(id: instanceID)))

            return Http.Request(
                method: .put,
                path: "/vpc/\(vpcID)/subnet/\(id)/detach",
                body: body
            )
        }
    }
}
