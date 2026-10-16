import Foundation

extension DBaaSKafkaOperations.AclConfig {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Kafka.ACLConfig.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Kafka.ACLConfig {
            Exoscale.DBaaS.Kafka.ACLConfig(data: data, client: client)
        }
    }
}
