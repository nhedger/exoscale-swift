import Foundation

extension EventsOperations.List {
    struct Response: HttpResponse {
        let data: [Exoscale.Event.Payload]

        func transform(client: Http.Client) -> [Exoscale.Event] {
            data.map { Exoscale.Event(data: $0, client: client) }
        }
    }
}
