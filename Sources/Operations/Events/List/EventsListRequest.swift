import Foundation

extension EventsOperations.List {
    struct Request: HttpRequest {
        let from: String?
        let to: String?

        func resolve() throws -> Http.Request {
            var query: [String: String?] = [:]

            if let from {
                query["from"] = from
            }

            if let to {
                query["to"] = to
            }

            return Http.Request(
                method: .get,
                path: "/event",
                query: query
            )
        }
    }
}
