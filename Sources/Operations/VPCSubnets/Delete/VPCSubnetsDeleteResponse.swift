import Foundation

extension VPCSubnetsOperations.Delete {
    struct Response: HttpResponse {
        let data: EmptyResponse

        func transform(client _: Http.Client) {}
    }
}
