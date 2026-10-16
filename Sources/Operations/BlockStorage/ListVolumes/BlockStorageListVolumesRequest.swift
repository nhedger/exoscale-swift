import Foundation

extension BlockStorageOperations.ListVolumes {
    struct Request: HttpRequest {
        let instanceID: String?

        func resolve() throws -> Http.Request {
            var query: [String: String?] = [:]

            if let instanceID {
                query["instance-id"] = instanceID
            }

            return Http.Request(
                method: .get,
                path: "/block-storage",
                query: query
            )
        }
    }
}
