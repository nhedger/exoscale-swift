import Foundation

extension DBaaSKafkaOperations.RevealUserPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Kafka.UserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Kafka.UserSecrets {
            Exoscale.DBaaS.Kafka.UserSecrets(data: data, client: client)
        }
    }
}
