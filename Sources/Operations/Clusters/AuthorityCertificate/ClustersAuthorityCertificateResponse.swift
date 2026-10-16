import Foundation

extension ClustersOperations.AuthorityCertificate {
    struct Response: HttpResponse {
        let data: GetSKSClusterAuthorityCertificateData

        func transform(client _: Http.Client) -> String {
            data.caCert
        }
    }
}
