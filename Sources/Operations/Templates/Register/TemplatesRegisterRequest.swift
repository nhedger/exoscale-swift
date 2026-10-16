import Foundation

extension TemplatesOperations.Register {
    struct Request: HttpRequest {
        let name: String
        let url: String
        let checksum: String
        let sshKeyEnabled: Bool
        let passwordEnabled: Bool
        let applicationConsistentSnapshotEnabled: Bool?
        let maintainer: String?
        let description: String?
        let defaultUser: String?
        let size: Int?
        let build: String?
        let bootMode: Exoscale.Template.BootMode?
        let version: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                RegisterTemplateBody(
                    applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                    maintainer: maintainer,
                    description: description,
                    sshKeyEnabled: sshKeyEnabled,
                    name: name,
                    defaultUser: defaultUser,
                    size: size,
                    passwordEnabled: passwordEnabled,
                    build: build,
                    checksum: checksum,
                    bootMode: bootMode,
                    url: url,
                    version: version
                )
            )

            return Http.Request(
                method: .post,
                path: "/template",
                body: body
            )
        }
    }
}
