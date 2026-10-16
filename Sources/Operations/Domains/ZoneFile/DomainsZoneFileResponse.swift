import Foundation

extension DomainsOperations.ZoneFile {
    struct Response: HttpResponse {
        let data: DomainZoneFileData

        func transform(client _: Http.Client) -> String {
            data.zoneFile
        }
    }
}
