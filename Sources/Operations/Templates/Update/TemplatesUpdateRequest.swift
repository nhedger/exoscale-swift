import Foundation

extension TemplatesOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let name: String?
        let description: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateTemplateBody(
                    name: name,
                    description: description
                )
            )

            return Http.Request(
                method: .put,
                path: "/template/\(id)",
                body: body
            )
        }
    }
}
