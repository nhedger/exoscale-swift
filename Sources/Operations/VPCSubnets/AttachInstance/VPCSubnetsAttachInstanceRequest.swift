import Foundation

extension VPCSubnetsOperations.AttachInstance {
    struct Request: HttpRequest {
        let vpcID: String
        let id: String
        let instanceID: String
        let ipv4: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder()
                .encode(VPCSubnetInstanceBody(instance: .init(id: instanceID), ipv4: ipv4))

            return Http.Request(
                method: .put,
                path: "/vpc/\(vpcID)/subnet/\(id)/attach",
                body: body
            )
        }
    }
}
