import Foundation

extension SecurityGroupsOperations.List {
    struct Request: HttpRequest {
        let visibility: Exoscale.SecurityGroup.Visibility?

        func resolve() throws -> Http.Request {
            var query: [String: String?] = [:]

            if let visibility {
                query["visibility"] = visibility.rawValue
            }

            return Http.Request(
                method: .get,
                path: "/security-group",
                query: query
            )
        }
    }
}
