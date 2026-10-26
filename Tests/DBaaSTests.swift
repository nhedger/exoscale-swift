@testable import Exoscale
import Foundation
import Testing

@Test("DBaaS calls send the expected requests", arguments: [
    Call("list", "GET /dbaas-service", response: "{}") { _ = try await $0.dbaas.list() },
    Call("delete", "DELETE /dbaas-service/db-1") { _ = try await $0.dbaas.delete(name: "db-1") },
    Call("service types", "GET /dbaas-service-type", response: "{}") { _ = try await $0.dbaas.serviceTypes() },
    Call("service type", "GET /dbaas-service-type/pg", response: #"{"name":"pg"}"#) {
        _ = try await $0.dbaas.serviceType(name: "pg")
    },
    Call("CA certificate", "GET /dbaas-ca-certificate", response: #"{"certificate":"PEM"}"#) {
        _ = try await $0.dbaas.caCertificate()
    },
    Call("settings schemas", "GET /dbaas-settings-pg", response: #"{"settings":{}}"#) {
        _ = try await $0.dbaas.settingsSchemas(for: .postgres)
    },
    Call("logs", "POST /dbaas-service-logs/db-1", body: #"{"limit":100,"sort-order":"desc"}"#, response: "{}") {
        _ = try await $0.dbaas.logs(of: "db-1", limit: 100, sortOrder: .descending)
    },
    Call("metrics", "POST /dbaas-service-metrics/db-1", body: #"{"period":"day"}"#, response: "{}") {
        _ = try await $0.dbaas.metrics(of: "db-1", period: .day)
    },
    Call("migration status", "GET /dbaas-migration-status/db-1", response: "{}") {
        _ = try await $0.dbaas.migrationStatus(of: "db-1")
    },
    Call(
        "migration check",
        "POST /dbaas-task-migration-check/db-1",
        body: #"{"method":"dump","source-service-uri":"postgres://old"}"#
    ) {
        _ = try await $0.dbaas.checkMigration(into: "db-1", from: "postgres://old", method: .dump)
    },
    Call("task", "GET /dbaas-task/db-1/t-1", response: "{}") { _ = try await $0.dbaas.task(id: "t-1", of: "db-1") },
    Call("integration types", "GET /dbaas-integration-types", response: "{}") {
        _ = try await $0.dbaas.integrationTypes()
    },
    Call("integration settings", "GET /dbaas-integration-settings/metrics/pg/thanos", response: "{}") {
        _ = try await $0.dbaas.integrationSettingsSchema(type: "metrics", sourceType: "pg", destType: "thanos")
    },
    Call("integration", "GET /dbaas-integration/i-1", response: "{}") { _ = try await $0.dbaas.integration(id: "i-1") },
    Call(
        "create integration",
        "POST /dbaas-integration",
        body: #"{"dest-service":"metrics","integration-type":"metrics","source-service":"db-1"}"#
    ) {
        _ = try await $0.dbaas.createIntegration(type: .metrics, from: "db-1", to: "metrics")
    },
    Call("update integration", "PUT /dbaas-integration/i-1", body: #"{"settings":{"retention":7}}"#) {
        _ = try await $0.dbaas.updateIntegration(id: "i-1", settings: ["retention": 7])
    },
    Call("delete integration", "DELETE /dbaas-integration/i-1") { _ = try await $0.dbaas.deleteIntegration(id: "i-1") }
])
func dbaasCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("PostgreSQL calls send the expected requests", arguments: [
    Call("get", "GET /dbaas-postgres/db-1", response: #"{"name":"db-1","type":"pg","plan":"startup-4"}"#) {
        _ = try await $0.dbaas.postgres.get(name: "db-1")
    },
    Call(
        "create",
        "POST /dbaas-postgres/db-1",
        body: #"{"integrations":[{"source-service":"db-0","type":"read_replica"}],"#
            + #""maintenance":{"dow":"sunday","time":"03:00:00"},"pg-settings":{"max_connections":200},"#
            + #""plan":"startup-4","version":"17"}"#
    ) {
        _ = try await $0.dbaas.postgres.create(
            name: "db-1",
            plan: "startup-4",
            version: "17",
            maintenance: .init(day: .sunday, time: "03:00:00"),
            readReplicaOf: "db-0",
            pgSettings: ["max_connections": 200]
        )
    },
    Call(
        "update",
        "PUT /dbaas-postgres/db-1",
        body: #"{"migration":{"host":"old.example.com","ignore-dbs":"tmp","method":"replication","port":5432},"#
            + #""termination-protection":true}"#
    ) {
        _ = try await $0.dbaas.postgres.update(
            name: "db-1",
            terminationProtection: true,
            migration: .init(host: "old.example.com", port: 5432, ignoredDatabases: "tmp", method: .replication)
        )
    },
    Call("delete", "DELETE /dbaas-postgres/db-1") { _ = try await $0.dbaas.postgres.delete(name: "db-1") },
    Call("maintenance", "PUT /dbaas-postgres/db-1/maintenance/start") {
        _ = try await $0.dbaas.postgres.startMaintenance(name: "db-1")
    },
    Call("stop migration", "POST /dbaas-postgres/db-1/migration/stop") {
        _ = try await $0.dbaas.postgres.stopMigration(name: "db-1")
    },
    Call("upgrade check", "POST /dbaas-postgres/db-1/upgrade-check", body: #"{"target-version":"18"}"#,
         response: "{}") {
        _ = try await $0.dbaas.postgres.checkUpgrade(name: "db-1", toVersion: "18")
    },
    Call("create database", "POST /dbaas-postgres/db-1/database", body: #"{"database-name":"app","lc-collate":"C"}"#) {
        _ = try await $0.dbaas.postgres.createDatabase("app", in: "db-1", collate: "C")
    },
    Call("delete database", "DELETE /dbaas-postgres/db-1/database/app") {
        _ = try await $0.dbaas.postgres.deleteDatabase("app", from: "db-1")
    },
    Call("create user", "POST /dbaas-postgres/db-1/user", body: #"{"allow-replication":true,"username":"app"}"#) {
        _ = try await $0.dbaas.postgres.createUser("app", in: "db-1", allowReplication: true)
    },
    Call("delete user", "DELETE /dbaas-postgres/db-1/user/app") {
        _ = try await $0.dbaas.postgres.deleteUser("app", from: "db-1")
    },
    Call(
        "allow replication",
        "PUT /dbaas-postgres/db-1/user/app/allow-replication",
        body: #"{"allow-replication":false}"#,
        response: #"{"users":[]}"#
    ) {
        _ = try await $0.dbaas.postgres.setAllowReplication(false, forUser: "app", in: "db-1")
    },
    Call("reset password", "PUT /dbaas-postgres/db-1/user/app/password/reset", body: "{}") {
        _ = try await $0.dbaas.postgres.resetPassword(of: "app", in: "db-1")
    },
    Call("reveal password", "GET /dbaas-postgres/db-1/user/app/password/reveal", response: "{}") {
        _ = try await $0.dbaas.postgres.revealPassword(of: "app", in: "db-1")
    },
    Call(
        "create pool",
        "POST /dbaas-postgres/db-1/connection-pool",
        body: #"{"database-name":"app","mode":"transaction","name":"pool","size":10}"#
    ) {
        _ = try await $0.dbaas.postgres.createConnectionPool(
            "pool",
            in: "db-1",
            database: "app",
            mode: .transaction,
            size: 10
        )
    },
    Call("update pool", "PUT /dbaas-postgres/db-1/connection-pool/pool", body: #"{"size":20}"#) {
        _ = try await $0.dbaas.postgres.updateConnectionPool("pool", in: "db-1", size: 20)
    },
    Call("delete pool", "DELETE /dbaas-postgres/db-1/connection-pool/pool") {
        _ = try await $0.dbaas.postgres.deleteConnectionPool("pool", from: "db-1")
    }
])
func postgresCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("MySQL, Valkey, Grafana and Thanos calls send the expected requests", arguments: [
    Call(
        "MySQL create",
        "POST /dbaas-mysql/db-1",
        body: #"{"backup-schedule":{"backup-hour":2,"backup-minute":30},"plan":"hobbyist-2"}"#
    ) {
        _ = try await $0.dbaas.mysql.create(
            name: "db-1",
            plan: "hobbyist-2",
            backupSchedule: .init(hour: 2, minute: 30)
        )
    },
    Call("MySQL update", "PUT /dbaas-mysql/db-1", body: #"{"binlog-retention-period":600}"#) {
        _ = try await $0.dbaas.mysql.update(name: "db-1", binlogRetentionPeriod: 600)
    },
    Call("MySQL enable writes", "PUT /dbaas-mysql/db-1/enable/writes") {
        _ = try await $0.dbaas.mysql.enableWrites(name: "db-1")
    },
    Call("MySQL create database", "POST /dbaas-mysql/db-1/database", body: #"{"database-name":"app"}"#) {
        _ = try await $0.dbaas.mysql.createDatabase("app", in: "db-1")
    },
    Call(
        "MySQL create user",
        "POST /dbaas-mysql/db-1/user",
        body: #"{"authentication":"mysql_native_password","username":"app"}"#
    ) {
        _ = try await $0.dbaas.mysql.createUser("app", in: "db-1", authentication: .mysqlNativePassword)
    },
    Call(
        "MySQL reset password",
        "PUT /dbaas-mysql/db-1/user/app/password/reset",
        body: #"{"authentication":"caching_sha2_password","password":"pw"}"#
    ) {
        _ = try await $0.dbaas.mysql.resetPassword(
            of: "app",
            in: "db-1",
            to: "pw",
            authentication: .cachingSHA2Password
        )
    },
    Call("Valkey get", "GET /dbaas-valkey/kv-1", response: #"{"name":"kv-1","type":"valkey","plan":"startup-4"}"#) {
        _ = try await $0.dbaas.valkey.get(name: "kv-1")
    },
    Call("Valkey users", "GET /dbaas-valkey/kv-1/user", response: "{}") {
        _ = try await $0.dbaas.valkey.users(of: "kv-1")
    },
    Call(
        "Valkey create user",
        "POST /dbaas-valkey/kv-1/user",
        body: #"{"access-control":{"keys":["app:*"]},"username":"app"}"#
    ) {
        _ = try await $0.dbaas.valkey.createUser("app", in: "kv-1", accessControl: .init(keys: ["app:*"]))
    },
    Call(
        "Valkey access control",
        "PUT /dbaas-valkey/kv-1/user/app",
        body: #"{"access-control":{"commands":["+get"]}}"#
    ) {
        _ = try await $0.dbaas.valkey.setAccessControl(.init(commands: ["+get"]), forUser: "app", in: "kv-1")
    },
    Call("Grafana create", "POST /dbaas-grafana/graf", body: #"{"ip-filter":["0.0.0.0/0"],"plan":"hobbyist-2"}"#) {
        _ = try await $0.dbaas.grafana.create(name: "graf", plan: "hobbyist-2", ipFilter: ["0.0.0.0/0"])
    },
    Call("Grafana reset password", "PUT /dbaas-grafana/graf/user/avnadmin/password/reset",
         body: #"{"password":"pw"}"#) {
        _ = try await $0.dbaas.grafana.resetPassword(of: "avnadmin", in: "graf", to: "pw")
    },
    Call(
        "Thanos update",
        "PUT /dbaas-thanos/metrics",
        body: #"{"thanos-settings":{"compactor":{"retention-days":30}}}"#
    ) {
        _ = try await $0.dbaas.thanos.update(name: "metrics", thanosSettings: ["compactor": ["retention-days": 30]])
    },
    Call("Thanos reveal", "GET /dbaas-thanos/metrics/user/avnadmin/password/reveal", response: "{}") {
        _ = try await $0.dbaas.thanos.revealPassword(of: "avnadmin", in: "metrics")
    }
])
func otherEngineCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Kafka, OpenSearch and ClickHouse calls send the expected requests", arguments: [
    Call(
        "Kafka create",
        "POST /dbaas-kafka/events",
        body: #"{"authentication-methods":{"sasl":true},"kafka-connect-enabled":true,"plan":"business-4"}"#
    ) {
        _ = try await $0.dbaas.kafka.create(
            name: "events",
            plan: "business-4",
            authenticationMethods: .init(sasl: true),
            kafkaConnectEnabled: true
        )
    },
    Call("Kafka ACLs", "GET /dbaas-kafka/events/acl-config", response: "{}") {
        _ = try await $0.dbaas.kafka.acls(of: "events")
    },
    Call(
        "Kafka topic ACL",
        "POST /dbaas-kafka/events/topic/acl-config",
        body: #"{"permission":"read","topic":"orders","username":"app"}"#
    ) {
        _ = try await $0.dbaas.kafka.addTopicACL(
            .init(username: "app", topic: "orders", permission: "read"),
            to: "events"
        )
    },
    Call("Kafka delete topic ACL", "DELETE /dbaas-kafka/events/topic/acl-config/acl-1") {
        _ = try await $0.dbaas.kafka.deleteTopicACL(id: "acl-1", from: "events")
    },
    Call(
        "Kafka registry ACL",
        "POST /dbaas-kafka/events/schema-registry/acl-config",
        body: #"{"permission":"schema_registry_read","resource":"Subject:orders","username":"app"}"#
    ) {
        _ = try await $0.dbaas.kafka.addSchemaRegistryACL(
            .init(username: "app", resource: "Subject:orders", permission: "schema_registry_read"),
            to: "events"
        )
    },
    Call("Kafka delete registry ACL", "DELETE /dbaas-kafka/events/schema-registry/acl-config/acl-2") {
        _ = try await $0.dbaas.kafka.deleteSchemaRegistryACL(id: "acl-2", from: "events")
    },
    Call("Kafka create user", "POST /dbaas-kafka/events/user", body: #"{"username":"app"}"#) {
        _ = try await $0.dbaas.kafka.createUser("app", in: "events")
    },
    Call("Kafka connect password", "GET /dbaas-kafka/events/connect/password/reveal", response: "{}") {
        _ = try await $0.dbaas.kafka.revealConnectPassword(of: "events")
    },
    Call(
        "OpenSearch create",
        "POST /dbaas-opensearch/search",
        body: #"{"index-template":{"number-of-shards":2},"opensearch-dashboards":{"enabled":true},"#
            + #""plan":"startup-8"}"#
    ) {
        _ = try await $0.dbaas.opensearch.create(
            name: "search",
            plan: "startup-8",
            indexTemplate: .init(numberOfShards: 2),
            dashboards: .init(enabled: true)
        )
    },
    Call("OpenSearch ACL", "GET /dbaas-opensearch/search/acl-config", response: "{}") {
        _ = try await $0.dbaas.opensearch.aclConfig(of: "search")
    },
    Call(
        "OpenSearch set ACL",
        "PUT /dbaas-opensearch/search/acl-config",
        body: #"{"acl-enabled":true,"acls":[{"rules":[{"index":"logs-*","permission":"read"}],"username":"app"}]}"#
    ) {
        _ = try await $0.dbaas.opensearch.setACLConfig(
            .init(
                aclEnabled: true,
                acls: [.init(username: "app", rules: [.init(index: "logs-*", permission: "read")])]
            ),
            of: "search"
        )
    },
    Call("ClickHouse users", "GET /dbaas-clickhouse/ch/user", response: "{}") {
        _ = try await $0.dbaas.clickhouse.users(of: "ch")
    },
    Call(
        "ClickHouse create user",
        "POST /dbaas-clickhouse/ch/user",
        body: #"{"roles":[{"uuid":"r-1"}],"username":"app"}"#,
        response: #"{"username":"app","password":"pw"}"#
    ) {
        _ = try await $0.dbaas.clickhouse.createUser("app", in: "ch", roleIDs: ["r-1"])
    },
    Call("ClickHouse delete user", "DELETE /dbaas-clickhouse/ch/user/u-1") {
        _ = try await $0.dbaas.clickhouse.deleteUser(uuid: "u-1", from: "ch")
    },
    Call("ClickHouse reset password", "PUT /dbaas-clickhouse/ch/user/app/password/reset", body: "{}", response: "{}") {
        _ = try await $0.dbaas.clickhouse.resetPassword(of: "app", in: "ch")
    },
    Call("ClickHouse roles", "GET /dbaas-clickhouse/ch/role", response: "{}") {
        _ = try await $0.dbaas.clickhouse.roles(of: "ch")
    },
    Call("ClickHouse delete role", "DELETE /dbaas-clickhouse/ch/role/r-1") {
        _ = try await $0.dbaas.clickhouse.deleteRole(uuid: "r-1", from: "ch")
    },
    Call("ClickHouse ACLs", "GET /dbaas-clickhouse/ch/acl-config", response: "{}") {
        _ = try await $0.dbaas.clickhouse.acls(of: "ch")
    }
])
func searchAndStreamingCalls(_ call: Call) async throws {
    try await check(call)
}
