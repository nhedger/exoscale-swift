import Foundation

extension DBaaSOperations.CaCertificate {
    struct Response: HttpResponse {
        let data: GetDBaaSCACertificateData

        func transform(client _: Http.Client) -> String {
            data.certificate
        }
    }
}
