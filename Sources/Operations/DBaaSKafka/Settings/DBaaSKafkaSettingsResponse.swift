import Foundation

extension DBaaSKafkaOperations.Settings {
    struct Response: HttpResponse {
        let data: GetDBaaSKafkaSettingsData

        func transform(client: Http.Client) -> Exoscale.DBaaS.Kafka.Settings {
            Exoscale.DBaaS.Kafka.Settings(data: data.settings, client: client)
        }
    }
}
