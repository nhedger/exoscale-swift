import Foundation

extension ZonesOperations.List {
    struct Response: HttpResponse {
        let data: ListZonesData

        func transform(client: Http.Client) -> [Exoscale.Zone] {
            data.zones.map { Exoscale.Zone(data: $0, client: client) }
        }
    }
}
