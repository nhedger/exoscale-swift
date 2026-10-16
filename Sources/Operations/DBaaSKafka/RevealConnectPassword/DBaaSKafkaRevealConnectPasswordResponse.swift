import Foundation

extension DBaaSKafkaOperations.RevealConnectPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Kafka.ConnectUserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Kafka.ConnectUserSecrets {
            Exoscale.DBaaS.Kafka.ConnectUserSecrets(data: data, client: client)
        }
    }
}
