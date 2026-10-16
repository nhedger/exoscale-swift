import Foundation

extension BlockStorageOperations.AttachVolume {
    struct Request: HttpRequest {
        let id: String
        let instanceID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                AttachBlockStorageVolumeBody(instance: InstanceIDReference(id: instanceID))
            )

            return Http.Request(
                method: .put,
                path: "/block-storage/\(id):attach",
                body: body
            )
        }
    }
}
