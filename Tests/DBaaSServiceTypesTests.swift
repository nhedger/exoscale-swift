@testable import Exoscale
import Foundation
import Testing

@Test("DBaaS service type request bodies encode (grafanaData)")
func dbaasServiceTypeRequestBodiesEncodeGrafanaData() throws {
    let maintenance = Exoscale.DBaaS.Maintenance(dayOfWeek: "monday", time: "10:00:00")

    let grafanaData = try JSONEncoder().encode(
        CreateDBaaSGrafanaServiceBody(
            maintenance: maintenance,
            plan: "startup-4",
            terminationProtection: true,
            forkFromService: "source-grafana",
            grafanaSettings: ["allow_embedding": .bool(true)],
            ipFilter: ["10.0.0.0/24"]
        )
    )
    let grafanaObject = try #require(JSONSerialization.jsonObject(with: grafanaData) as? [String: Any])
    let grafanaSettings = try #require(grafanaObject["grafana-settings"] as? [String: Any])

    #expect(grafanaObject["plan"] as? String == "startup-4")
    #expect(grafanaObject["fork-from-service"] as? String == "source-grafana")
    #expect(grafanaSettings["allow_embedding"] as? Bool == true)
}

@Test("DBaaS service type request bodies encode (kafkaData)")
func dbaasServiceTypeRequestBodiesEncodeKafkaData() throws {
    let maintenance = Exoscale.DBaaS.Maintenance(dayOfWeek: "monday", time: "10:00:00")

    let kafkaData = try JSONEncoder().encode(
        DBaaSKafkaServiceBody(
            authenticationMethods: .init(certificate: true, sasl: true),
            kafkaRestEnabled: true,
            kafkaConnectEnabled: true,
            ipFilter: ["10.0.0.0/24"],
            schemaRegistrySettings: ["topic_name_strategy_validation": .bool(true)],
            kafkaRestSettings: ["consumer_enable_auto_commit": .bool(false)],
            terminationProtection: true,
            kafkaConnectSettings: ["consumer_auto_offset_reset": .string("earliest")],
            maintenance: maintenance,
            kafkaSettings: ["auto_create_topics_enable": .bool(true)],
            schemaRegistryEnabled: true,
            version: "3.8",
            plan: "startup-4"
        )
    )
    let kafkaObject = try #require(JSONSerialization.jsonObject(with: kafkaData) as? [String: Any])
    let kafkaAuth = try #require(kafkaObject["authentication-methods"] as? [String: Any])
    #expect(kafkaAuth["certificate"] as? Bool == true)
    #expect(kafkaObject["kafka-rest-enabled"] as? Bool == true)
    #expect(kafkaObject["schema-registry-enabled"] as? Bool == true)
}

@Test("DBaaS service type request bodies encode (mysqlData)")
func dbaasServiceTypeRequestBodiesEncodeMysqlData() throws {
    let maintenance = Exoscale.DBaaS.Maintenance(dayOfWeek: "monday", time: "10:00:00")

    let mysqlData = try JSONEncoder().encode(
        CreateDBaaSMySQLServiceBody(
            backupSchedule: .init(backupHour: 2, backupMinute: 30),
            integrations: [.init(type: "read_replica", sourceService: "source-mysql")],
            ipFilter: ["10.0.0.0/24"],
            terminationProtection: true,
            forkFromService: "source-mysql",
            recoveryBackupTime: "2026-04-27T10:00:00Z",
            mysqlSettings: ["sql_require_primary_key": .bool(true)],
            maintenance: maintenance,
            adminUsername: "admin",
            version: "8",
            plan: "startup-4",
            adminPassword: "super-secret",
            migration: .init(host: "old-db.example.com", port: 3306, databaseName: "app", method: "dump"),
            binlogRetentionPeriod: 86400
        )
    )
    let mysqlObject = try #require(JSONSerialization.jsonObject(with: mysqlData) as? [String: Any])
    let mysqlMigration = try #require(mysqlObject["migration"] as? [String: Any])
    #expect(mysqlObject["binlog-retention-period"] as? Int == 86400)
    #expect(mysqlMigration["dbname"] as? String == "app")
    #expect(mysqlMigration["method"] as? String == "dump")
}

@Test("DBaaS service type request bodies encode (opensearchData)")
func dbaasServiceTypeRequestBodiesEncodeOpensearchData() throws {
    let maintenance = Exoscale.DBaaS.Maintenance(dayOfWeek: "monday", time: "10:00:00")

    let opensearchData = try JSONEncoder().encode(
        CreateDBaaSOpenSearchServiceBody(
            maxIndexCount: 10,
            keepIndexRefreshInterval: true,
            ipFilter: ["10.0.0.0/24"],
            terminationProtection: true,
            forkFromService: "source-os",
            indexPatterns: [.init(maxIndexCount: 5, sortingAlgorithm: "creation_date", pattern: "logs.*")],
            maintenance: maintenance,
            indexTemplate: .init(mappingNestedObjectsLimit: 10000, numberOfReplicas: 1, numberOfShards: 3),
            opensearchSettings: ["action_auto_create_index_enabled": .bool(true)],
            version: "2",
            recoveryBackupName: "backup-1",
            plan: "startup-4",
            opensearchDashboards: .init(opensearchRequestTimeout: 30000, enabled: true, maxOldSpaceSize: 128)
        )
    )
    let opensearchObject = try #require(JSONSerialization.jsonObject(with: opensearchData) as? [String: Any])
    let opensearchDashboards = try #require(opensearchObject["opensearch-dashboards"] as? [String: Any])
    #expect(opensearchObject["keep-index-refresh-interval"] as? Bool == true)
    #expect(opensearchDashboards["max-old-space-size"] as? Int == 128)
}

@Test("DBaaS service type request bodies encode (thanosData)")
func dbaasServiceTypeRequestBodiesEncodeThanosData() throws {
    let maintenance = Exoscale.DBaaS.Maintenance(dayOfWeek: "monday", time: "10:00:00")

    let thanosData = try JSONEncoder().encode(
        CreateDBaaSThanosServiceBody(
            maintenance: maintenance,
            plan: "startup-4",
            terminationProtection: true,
            ipFilter: ["10.0.0.0/24"],
            thanosSettings: ["compactor": .object(["retention.days": .integer(30)])]
        )
    )
    let thanosObject = try #require(JSONSerialization.jsonObject(with: thanosData) as? [String: Any])
    #expect(thanosObject["thanos-settings"] != nil)
}

@Test("DBaaS service type request bodies encode (valkeyData)")
func dbaasServiceTypeRequestBodiesEncodeValkeyData() throws {
    let maintenance = Exoscale.DBaaS.Maintenance(dayOfWeek: "monday", time: "10:00:00")

    let valkeyData = try JSONEncoder().encode(
        CreateDBaaSValkeyServiceBody(
            maintenance: maintenance,
            plan: "startup-4",
            terminationProtection: true,
            ipFilter: ["10.0.0.0/24"],
            migration: .init(host: "old-cache.example.com", port: 6379),
            valkeySettings: ["ssl": .bool(true)],
            forkFromService: "source-valkey",
            recoveryBackupName: "backup-1"
        )
    )
    let valkeyObject = try #require(JSONSerialization.jsonObject(with: valkeyData) as? [String: Any])
    #expect(valkeyObject["recovery-backup-name"] as? String == "backup-1")
}

@Test("DBaaS service type request bodies encode (valkeyUserData)")
func dbaasServiceTypeRequestBodiesEncodeValkeyUserData() throws {
    let valkeyUserData = try JSONEncoder().encode(
        CreateDBaaSValkeyUserBody(
            username: "app",
            accessControl: .init(categories: ["+@read"], channels: ["*"], commands: ["+get"], keys: ["app:*"])
        )
    )
    let valkeyUserObject = try #require(JSONSerialization.jsonObject(with: valkeyUserData) as? [String: Any])
    let valkeyAccessControl = try #require(valkeyUserObject["access-control"] as? [String: Any])
    #expect(valkeyAccessControl["keys"] as? [String] == ["app:*"])
}

@Test("DBaaS service type responses decode (grafana)")
func dbaasServiceTypeResponsesDecodeGrafana() throws {
    let grafana = try Exoscale.jsonDecoder().decode(
        Exoscale.DBaaS.Grafana.Service.Payload.self,
        from: DBaaSServiceTypesFixtures.grafana
    )

    #expect(grafana.connectionInfo?.uri == "https://grafana.example.com")
    #expect(grafana.grafanaSettings?["allow_embedding"] == .bool(true))
}

@Test("DBaaS service type responses decode (kafka)")
func dbaasServiceTypeResponsesDecodeKafka() throws {
    let kafka = try Exoscale.jsonDecoder().decode(
        Exoscale.DBaaS.Kafka.Service.Payload.self,
        from: DBaaSServiceTypesFixtures.kafka
    )
    #expect(kafka.authenticationMethods?.sasl == true)
    #expect(kafka.connectionInfo?.connectURI == "https://connect.example.com")
}

@Test("DBaaS service type responses decode (mysql)")
func dbaasServiceTypeResponsesDecodeMysql() throws {
    let mysql = try Exoscale.jsonDecoder().decode(
        Exoscale.DBaaS.MySQL.Service.Payload.self,
        from: DBaaSServiceTypesFixtures.mysql
    )
    #expect(mysql.connectionInfo?.params?.first?["host"] == "mysql.example.com")
    #expect(mysql.mysqlSettings?["sql_require_primary_key"] == .bool(true))
}

@Test("DBaaS service type responses decode (opensearch)")
func dbaasServiceTypeResponsesDecodeOpensearch() throws {
    let opensearch = try Exoscale.jsonDecoder().decode(
        Exoscale.DBaaS.OpenSearch.Service.Payload.self,
        from: DBaaSServiceTypesFixtures.opensearch
    )
    #expect(opensearch.indexTemplate?.numberOfShards == 3)
    #expect(opensearch.opensearchDashboards?.enabled == true)
}

@Test("DBaaS service type responses decode (thanos)")
func dbaasServiceTypeResponsesDecodeThanos() throws {
    let thanos = try Exoscale.jsonDecoder().decode(
        Exoscale.DBaaS.Thanos.Service.Payload.self,
        from: DBaaSServiceTypesFixtures.thanos
    )
    #expect(thanos.connectionInfo?.queryURI == "https://query.example.com")
    #expect(thanos.thanosSettings?["compactor"] == .object(["retention.days": .integer(30)]))
}

@Test("DBaaS service type responses decode (valkey)")
func dbaasServiceTypeResponsesDecodeValkey() throws {
    let valkey = try Exoscale.jsonDecoder().decode(
        Exoscale.DBaaS.Valkey.Service.Payload.self,
        from: DBaaSServiceTypesFixtures.valkey
    )
    #expect(valkey.connectionInfo?.password == "secret")
    #expect(valkey.users?.first?.accessControl?.keys == ["app:*"])
}

@Test("DBaaS service type responses decode (kafkaACL)")
func dbaasServiceTypeResponsesDecodeKafkaACL() throws {
    let kafkaACL = try JSONDecoder().decode(
        Exoscale.DBaaS.Kafka.ACLConfig.Payload.self,
        from: DBaaSServiceTypesFixtures.kafkaACL
    )
    #expect(kafkaACL.topicACL?.first?.permission == .readwrite)
    #expect(kafkaACL.schemaRegistryACL?.first?.permission == .read)
}

@Test("DBaaS service type responses decode (openSearchACL)")
func dbaasServiceTypeResponsesDecodeOpenSearchACL() throws {
    let openSearchACL = try JSONDecoder().decode(
        Exoscale.DBaaS.OpenSearch.ACLConfig.self,
        from: DBaaSServiceTypesFixtures.openSearchACL
    )
    #expect(openSearchACL.aclEnabled == true)
    #expect(openSearchACL.acls?.first?.rules?.first?.permission == .read)
}

@Test("DBaaS service type responses decode (valkeyUsers)")
func dbaasServiceTypeResponsesDecodeValkeyUsers() throws {
    let valkeyUsers = try JSONDecoder().decode(
        DBaaSValkeyUsersData.self,
        from: Data(#"{"users":[{"username":"app","access-control":{"commands":["+get"]}}]}"#.utf8)
    )
    #expect(valkeyUsers.users.first?.accessControl?.commands == ["+get"])
}

@Test("DBaaS service type settings and secrets decode")
func dbaasServiceTypeSettingsAndSecretsDecode() throws {
    let settingsSchema = #"{"type":"object","additionalProperties":false,"properties":{"enabled":{"type":"boolean"}}}"#
    let grafanaSettings = try JSONDecoder().decode(
        GetDBaaSGrafanaSettingsData.self,
        from: Data("{\"settings\":{\"grafana\":\(settingsSchema)}}".utf8)
    )
    let kafkaSettings = try JSONDecoder().decode(
        GetDBaaSKafkaSettingsData.self,
        from: Data(("{\"settings\":{\"kafka\":\(settingsSchema),"
                + "\"kafka-connect\":\(settingsSchema),\"schema-registry\":\(settingsSchema)}}").utf8)
    )
    let mysqlSettings = try JSONDecoder().decode(
        GetDBaaSMySQLSettingsData.self,
        from: Data("{\"settings\":{\"mysql\":\(settingsSchema)}}".utf8)
    )
    let opensearchSettings = try JSONDecoder().decode(
        GetDBaaSOpenSearchSettingsData.self,
        from: Data("{\"settings\":{\"opensearch\":\(settingsSchema)}}".utf8)
    )
    let thanosSettings = try JSONDecoder().decode(
        GetDBaaSThanosSettingsData.self,
        from: Data("{\"settings\":{\"thanos\":\(settingsSchema)}}".utf8)
    )
    let valkeySettings = try JSONDecoder().decode(
        GetDBaaSValkeySettingsData.self,
        from: Data("{\"settings\":{\"valkey\":\(settingsSchema)}}".utf8)
    )

    let kafkaSecrets = try Exoscale.jsonDecoder().decode(
        Exoscale.DBaaS.Kafka.UserSecrets.Payload.self,
        from: Data(#"{"username":"app","password":"secret","access-cert":"cert","access-key":"key"}"#.utf8)
    )
    let connectSecrets = try JSONDecoder().decode(
        Exoscale.DBaaS.Kafka.ConnectUserSecrets.Payload.self,
        from: Data(#"{"username":"connect","password":"secret"}"#.utf8)
    )
    let mysqlSecrets = try JSONDecoder().decode(
        Exoscale.DBaaS.MySQL.UserSecrets.Payload.self,
        from: Data(#"{"username":"app","password":"secret"}"#.utf8)
    )

    #expect(grafanaSettings.settings.grafana?.additionalProperties == false)
    #expect(kafkaSettings.settings.kafkaConnect?.type == "object")
    #expect(mysqlSettings.settings.mysql?.properties?["enabled"] == .object(["type": .string("boolean")]))
    #expect(opensearchSettings.settings.opensearch?.type == "object")
    #expect(thanosSettings.settings.thanos?.type == "object")
    #expect(valkeySettings.settings.valkey?.type == "object")
    #expect(kafkaSecrets.accessCert == "cert")
    #expect(connectSecrets.username == "connect")
    #expect(mysqlSecrets.password == "secret")
}

@Test("Client builds DBaaS service type paths")
func clientBuildsDBaaSServiceTypePaths() throws {
    let client = try Exoscale(apiKey: "key", apiSecret: "secret", zone: .chGva2)

    let grafana = try client.http.makeRequest("PUT", path: "/dbaas-grafana/grafana/maintenance/start")
    let kafkaACL = try client.http.makeRequest("DELETE", path: "/dbaas-kafka/kafka/topic/acl-config/acl-1")
    let kafkaConnect = try client.http.makeRequest("GET", path: "/dbaas-kafka/kafka/connect/password/reveal")
    let mysqlWrites = try client.http.makeRequest("PUT", path: "/dbaas-mysql/mysql/enable/writes")
    let mysqlDatabase = try client.http.makeRequest("POST", path: "/dbaas-mysql/mysql/database")
    let opensearchACL = try client.http.makeRequest("PUT", path: "/dbaas-opensearch/os/acl-config")
    let thanosPassword = try client.http.makeRequest("GET", path: "/dbaas-thanos/thanos/user/app/password/reveal")
    let valkeyUsers = try client.http.makeRequest("GET", path: "/dbaas-valkey/valkey/user")
    let valkeyPassword = try client.http.makeRequest("PUT", path: "/dbaas-valkey/valkey/user/app/password/reset")
    let settings = try client.http.makeRequest("GET", path: "/dbaas-settings-opensearch")

    #expect(grafana.url?.path == "/v2/dbaas-grafana/grafana/maintenance/start")
    #expect(kafkaACL.url?.path == "/v2/dbaas-kafka/kafka/topic/acl-config/acl-1")
    #expect(kafkaConnect.url?.path == "/v2/dbaas-kafka/kafka/connect/password/reveal")
    #expect(mysqlWrites.url?.path == "/v2/dbaas-mysql/mysql/enable/writes")
    #expect(mysqlDatabase.url?.path == "/v2/dbaas-mysql/mysql/database")
    #expect(opensearchACL.url?.path == "/v2/dbaas-opensearch/os/acl-config")
    #expect(thanosPassword.url?.path == "/v2/dbaas-thanos/thanos/user/app/password/reveal")
    #expect(valkeyUsers.url?.path == "/v2/dbaas-valkey/valkey/user")
    #expect(valkeyPassword.url?.path == "/v2/dbaas-valkey/valkey/user/app/password/reset")
    #expect(settings.url?.path == "/v2/dbaas-settings-opensearch")
}
