import Foundation

extension ClustersOperations.ListVersions {
    struct Request: HttpRequest {
        let includeDeprecated: Bool?

        func resolve() throws -> Http.Request {
            var query: [String: String?] = [:]

            if let includeDeprecated {
                query["include-deprecated"] = includeDeprecated ? "true" : "false"
            }

            return Http.Request(
                method: .get,
                path: "/sks-cluster-version",
                query: query
            )
        }
    }
}
