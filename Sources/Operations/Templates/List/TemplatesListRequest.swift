import Foundation

extension TemplatesOperations.List {
    struct Request: HttpRequest {
        let visibility: Exoscale.Template.Visibility?
        let family: String?

        func resolve() throws -> Http.Request {
            var query: [String: String?] = [:]

            if let visibility {
                query["visibility"] = visibility.rawValue
            }

            if let family {
                query["family"] = family
            }

            return Http.Request(
                method: .get,
                path: "/template",
                query: query
            )
        }
    }
}
