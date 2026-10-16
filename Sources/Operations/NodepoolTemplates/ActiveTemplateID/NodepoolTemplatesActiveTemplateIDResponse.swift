import Foundation

extension NodepoolTemplatesOperations.ActiveTemplateID {
    struct Response: HttpResponse {
        let data: ActiveNodepoolTemplateData

        func transform(client _: Http.Client) -> String {
            data.activeTemplate
        }
    }
}
