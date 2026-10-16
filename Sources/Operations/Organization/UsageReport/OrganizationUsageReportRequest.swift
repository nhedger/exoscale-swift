import Foundation

extension OrganizationOperations.UsageReport {
    struct Request: HttpRequest {
        let period: String?

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/usage-report",
                query: ["period": period]
            )
        }
    }
}
