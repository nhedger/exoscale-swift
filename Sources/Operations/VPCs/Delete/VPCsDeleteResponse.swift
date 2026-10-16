import Foundation

extension VPCsOperations.Delete {
    struct Response: HttpResponse {
        let data: EmptyResponse

        func transform(client _: Http.Client) {}
    }
}
