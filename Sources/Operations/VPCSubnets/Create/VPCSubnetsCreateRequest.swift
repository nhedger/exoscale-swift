import Foundation

extension VPCSubnetsOperations.Create {
    struct Request: HttpRequest {
        let vpcID: String
        let name: String
        let description: String?
        let labels: [String: String]?
        let ipv4Block: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(VPCSubnetBody(
                name: name, description: description, labels: labels, ipv4Block: ipv4Block,
                addressFamily: "inet4", addressSpace: "private"
            ))

            return Http.Request(
                method: .post,
                path: "/vpc/\(vpcID)/subnet",
                body: body
            )
        }
    }
}
