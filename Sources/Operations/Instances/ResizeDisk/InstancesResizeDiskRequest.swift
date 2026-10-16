import Foundation

extension InstancesOperations.ResizeDisk {
    struct Request: HttpRequest {
        let id: String
        let diskSize: Int

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ResizeInstanceDiskBody(diskSize: diskSize))

            return Http.Request(
                method: .put,
                path: "/instance/\(id):resize-disk",
                body: body
            )
        }
    }
}
