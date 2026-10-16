import Foundation

extension VPCSubnetsOperations.Update {
    struct Request: HttpRequest {
        let vpcID: String
        let id: String
        let name: String?
        let description: String?
        let labels: [String: String]?
        let ipv4Block: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(VPCSubnetBody(
                name: name,
                description: description,
                labels: labels,
                ipv4Block: ipv4Block
            ))

            return Http.Request(
                method: .put,
                path: "/vpc/\(vpcID)/subnet/\(id)",
                body: body
            )
        }
    }
}
