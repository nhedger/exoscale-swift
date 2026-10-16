import Foundation

extension OrganizationOperations.ImpactReport {
    struct Request: HttpRequest {
        let from: String?
        let to: String?

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/environmental-impact/report",
                query: ["from": from, "to": to]
            )
        }
    }
}
