import Foundation

extension DBaaSKafkaOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Kafka.Service.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Kafka.Service {
            Exoscale.DBaaS.Kafka.Service(data: data, client: client)
        }
    }
}
