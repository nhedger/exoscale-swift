import Foundation

extension ReverseDNSOperations.UpdateInstance {
    struct Request: HttpRequest {
        let id: String
        let domainName: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpdateReverseDNSRecordBody(domainName: domainName))

            return Http.Request(
                method: .post,
                path: "/reverse-dns/instance/\(id)",
                body: body
            )
        }
    }
}
