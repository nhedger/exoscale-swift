import Foundation
import Testing

@testable import Exoscale

@Test("DBaaS service type request bodies encode")
func dbaasServiceTypeRequestBodiesEncode() throws {
    let maintenance = Exoscale.DBaaS.Maintenance(dayOfWeek: "monday", time: "10:00:00")

    let grafanaData = try JSONEncoder().encode(
        CreateDBaaSGrafanaServiceRequest(
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

    let kafkaData = try JSONEncoder().encode(
        DBaaSKafkaServiceRequest(
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

    let mysqlData = try JSONEncoder().encode(
        CreateDBaaSMySQLServiceRequest(
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

    let opensearchData = try JSONEncoder().encode(
        CreateDBaaSOpenSearchServiceRequest(
            maxIndexCount: 10,
            keepIndexRefreshInterval: true,
            ipFilter: ["10.0.0.0/24"],
            terminationProtection: true,
            forkFromService: "source-os",
            indexPatterns: [.init(maxIndexCount: 5, sortingAlgorithm: "creation_date", pattern: "logs.*")],
            maintenance: maintenance,
            indexTemplate: .init(mappingNestedObjectsLimit: 10_000, numberOfReplicas: 1, numberOfShards: 3),
            opensearchSettings: ["action_auto_create_index_enabled": .bool(true)],
            version: "2",
            recoveryBackupName: "backup-1",
            plan: "startup-4",
            opensearchDashboards: .init(opensearchRequestTimeout: 30_000, enabled: true, maxOldSpaceSize: 128)
        )
    )
    let opensearchObject = try #require(JSONSerialization.jsonObject(with: opensearchData) as? [String: Any])
    let opensearchDashboards = try #require(opensearchObject["opensearch-dashboards"] as? [String: Any])

    let thanosData = try JSONEncoder().encode(
        CreateDBaaSThanosServiceRequest(
            maintenance: maintenance,
            plan: "startup-4",
            terminationProtection: true,
            ipFilter: ["10.0.0.0/24"],
            thanosSettings: ["compactor": .object(["retention.days": .integer(30)])]
        )
    )
    let thanosObject = try #require(JSONSerialization.jsonObject(with: thanosData) as? [String: Any])

    let valkeyData = try JSONEncoder().encode(
        CreateDBaaSValkeyServiceRequest(
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

    let valkeyUserData = try JSONEncoder().encode(
        CreateDBaaSValkeyUserRequest(
            username: "app",
            accessControl: .init(categories: ["+@read"], channels: ["*"], commands: ["+get"], keys: ["app:*"])
        )
    )
    let valkeyUserObject = try #require(JSONSerialization.jsonObject(with: valkeyUserData) as? [String: Any])
    let valkeyAccessControl = try #require(valkeyUserObject["access-control"] as? [String: Any])

    #expect(grafanaObject["plan"] as? String == "startup-4")
    #expect(grafanaObject["fork-from-service"] as? String == "source-grafana")
    #expect(grafanaSettings["allow_embedding"] as? Bool == true)
    #expect(kafkaAuth["certificate"] as? Bool == true)
    #expect(kafkaObject["kafka-rest-enabled"] as? Bool == true)
    #expect(kafkaObject["schema-registry-enabled"] as? Bool == true)
    #expect(mysqlObject["binlog-retention-period"] as? Int == 86400)
    #expect(mysqlMigration["dbname"] as? String == "app")
    #expect(mysqlMigration["method"] as? String == "dump")
    #expect(opensearchObject["keep-index-refresh-interval"] as? Bool == true)
    #expect(opensearchDashboards["max-old-space-size"] as? Int == 128)
    #expect(thanosObject["thanos-settings"] != nil)
    #expect(valkeyObject["recovery-backup-name"] as? String == "backup-1")
    #expect(valkeyAccessControl["keys"] as? [String] == ["app:*"])
}

@Test("DBaaS service type responses decode")
func dbaasServiceTypeResponsesDecode() throws {
    let grafana = try JSONDecoder().decode(
        Exoscale.DBaaS.Grafana.Service.self,
        from: Data(#"{"name":"grafana","plan":"startup-4","type":"grafana","state":"running","connection-info":{"uri":"https://grafana.example.com","username":"avnadmin","password":"secret"},"grafana-settings":{"allow_embedding":true}}"#.utf8)
    )
    let kafka = try JSONDecoder().decode(
        Exoscale.DBaaS.Kafka.Service.self,
        from: Data(#"{"name":"kafka","plan":"startup-4","type":"kafka","state":"running","authentication-methods":{"certificate":true,"sasl":true},"connection-info":{"nodes":["kafka.example.com:9092"],"connect-uri":"https://connect.example.com"},"schema-registry-enabled":true,"users":[{"username":"app","access-cert":"cert"}]}"#.utf8)
    )
    let mysql = try JSONDecoder().decode(
        Exoscale.DBaaS.MySQL.Service.self,
        from: Data(#"{"name":"mysql","plan":"startup-4","type":"mysql","state":"running","connection-info":{"uri":["mysql://user:pass@mysql.example.com/defaultdb"],"params":[{"host":"mysql.example.com"}]},"databases":["defaultdb"],"mysql-settings":{"sql_require_primary_key":true}}"#.utf8)
    )
    let opensearch = try JSONDecoder().decode(
        Exoscale.DBaaS.OpenSearch.Service.self,
        from: Data(#"{"name":"os","plan":"startup-4","type":"opensearch","state":"running","connection-info":{"uri":["https://os.example.com"],"dashboard-uri":"https://dash.example.com"},"index-template":{"number-of-shards":3},"opensearch-dashboards":{"enabled":true}}"#.utf8)
    )
    let thanos = try JSONDecoder().decode(
        Exoscale.DBaaS.Thanos.Service.self,
        from: Data(#"{"name":"thanos","plan":"startup-4","type":"thanos","state":"running","connection-info":{"query-uri":"https://query.example.com"},"thanos-settings":{"compactor":{"retention.days":30}}}"#.utf8)
    )
    let valkey = try JSONDecoder().decode(
        Exoscale.DBaaS.Valkey.Service.self,
        from: Data(#"{"name":"valkey","plan":"startup-4","type":"valkey","state":"running","connection-info":{"uri":["rediss://valkey.example.com"],"password":"secret"},"users":[{"username":"app","access-control":{"keys":["app:*"]}}]}"#.utf8)
    )
    let kafkaACL = try JSONDecoder().decode(
        Exoscale.DBaaS.Kafka.ACLConfig.self,
        from: Data(#"{"topic-acl":[{"id":"acl-1","username":"app","topic":"events","permission":"readwrite"}],"schema-registry-acl":[{"id":"acl-2","username":"app","resource":"subject","permission":"schema_registry_read"}]}"#.utf8)
    )
    let openSearchACL = try JSONDecoder().decode(
        Exoscale.DBaaS.OpenSearch.ACLConfig.self,
        from: Data(#"{"acl-enabled":true,"extended-acl-enabled":false,"acls":[{"username":"app","rules":[{"index":"logs-*","permission":"read"}]}]}"#.utf8)
    )
    let valkeyUsers = try JSONDecoder().decode(
        DBaaSValkeyUsersResponse.self,
        from: Data(#"{"users":[{"username":"app","access-control":{"commands":["+get"]}}]}"#.utf8)
    )

    #expect(grafana.connectionInfo?.uri == "https://grafana.example.com")
    #expect(grafana.grafanaSettings?["allow_embedding"] == .bool(true))
    #expect(kafka.authenticationMethods?.sasl == true)
    #expect(kafka.connectionInfo?.connectURI == "https://connect.example.com")
    #expect(mysql.connectionInfo?.params?.first?["host"] == "mysql.example.com")
    #expect(mysql.mysqlSettings?["sql_require_primary_key"] == .bool(true))
    #expect(opensearch.indexTemplate?.numberOfShards == 3)
    #expect(opensearch.opensearchDashboards?.enabled == true)
    #expect(thanos.connectionInfo?.queryURI == "https://query.example.com")
    #expect(thanos.thanosSettings?["compactor"] == .object(["retention.days": .integer(30)]))
    #expect(valkey.connectionInfo?.password == "secret")
    #expect(valkey.users?.first?.accessControl?.keys == ["app:*"])
    #expect(kafkaACL.topicACL?.first?.permission == .readwrite)
    #expect(kafkaACL.schemaRegistryACL?.first?.permission == .read)
    #expect(openSearchACL.aclEnabled == true)
    #expect(openSearchACL.acls?.first?.rules?.first?.permission == .read)
    #expect(valkeyUsers.users.first?.accessControl?.commands == ["+get"])
}

@Test("DBaaS service type settings and secrets decode")
func dbaasServiceTypeSettingsAndSecretsDecode() throws {
    let settingsSchema = #"{"type":"object","additionalProperties":false,"properties":{"enabled":{"type":"boolean"}}}"#
    let grafanaSettings = try JSONDecoder().decode(
        GetDBaaSGrafanaSettingsResponse.self,
        from: Data("{\"settings\":{\"grafana\":\(settingsSchema)}}".utf8)
    )
    let kafkaSettings = try JSONDecoder().decode(
        GetDBaaSKafkaSettingsResponse.self,
        from: Data("{\"settings\":{\"kafka\":\(settingsSchema),\"kafka-connect\":\(settingsSchema),\"schema-registry\":\(settingsSchema)}}".utf8)
    )
    let mysqlSettings = try JSONDecoder().decode(
        GetDBaaSMySQLSettingsResponse.self,
        from: Data("{\"settings\":{\"mysql\":\(settingsSchema)}}".utf8)
    )
    let opensearchSettings = try JSONDecoder().decode(
        GetDBaaSOpenSearchSettingsResponse.self,
        from: Data("{\"settings\":{\"opensearch\":\(settingsSchema)}}".utf8)
    )
    let thanosSettings = try JSONDecoder().decode(
        GetDBaaSThanosSettingsResponse.self,
        from: Data("{\"settings\":{\"thanos\":\(settingsSchema)}}".utf8)
    )
    let valkeySettings = try JSONDecoder().decode(
        GetDBaaSValkeySettingsResponse.self,
        from: Data("{\"settings\":{\"valkey\":\(settingsSchema)}}".utf8)
    )

    let kafkaSecrets = try JSONDecoder().decode(
        Exoscale.DBaaS.Kafka.UserSecrets.self,
        from: Data(#"{"username":"app","password":"secret","access-cert":"cert","access-key":"key"}"#.utf8)
    )
    let connectSecrets = try JSONDecoder().decode(
        Exoscale.DBaaS.Kafka.ConnectUserSecrets.self,
        from: Data(#"{"username":"connect","password":"secret"}"#.utf8)
    )
    let mysqlSecrets = try JSONDecoder().decode(
        Exoscale.DBaaS.MySQL.UserSecrets.self,
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
