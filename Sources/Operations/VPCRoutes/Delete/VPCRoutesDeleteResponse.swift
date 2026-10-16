import Foundation

extension VPCRoutesOperations.Delete {
    struct Response: HttpResponse {
        let data: EmptyResponse

        func transform(client _: Http.Client) {}
    }
}
