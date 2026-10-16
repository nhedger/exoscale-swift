import Foundation

extension DomainsOperations.Create {
    struct Request: HttpRequest {
        let unicodeName: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateDomainBody(unicodeName: unicodeName))

            return Http.Request(
                method: .post,
                path: "/dns-domain",
                body: body
            )
        }
    }
}
