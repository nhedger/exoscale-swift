import Foundation

extension BlockStorageOperations.ResizeVolume {
    struct Request: HttpRequest {
        let id: String
        let size: Int

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ResizeBlockStorageVolumeBody(size: size))

            return Http.Request(
                method: .put,
                path: "/block-storage/\(id):resize-volume",
                body: body
            )
        }
    }
}
