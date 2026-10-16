import Foundation

extension NodepoolTemplatesOperations.ActiveTemplateID {
    struct Request: HttpRequest {
        let kubernetesVersion: String
        let variant: NodepoolTemplatesResource.Variant

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/sks-template/\(kubernetesVersion)/\(variant.rawValue)"
            )
        }
    }
}
