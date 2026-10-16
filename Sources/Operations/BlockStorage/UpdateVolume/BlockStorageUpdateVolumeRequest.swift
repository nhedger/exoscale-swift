import Foundation

extension BlockStorageOperations.UpdateVolume {
    struct Request: HttpRequest {
        let id: String
        let name: String?
        let labels: [String: String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpdateBlockStorageVolumeBody(name: name, labels: labels))

            return Http.Request(
                method: .put,
                path: "/block-storage/\(id)",
                body: body
            )
        }
    }
}
