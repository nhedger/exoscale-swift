@testable import Exoscale
import Foundation
import Testing

@Test("PostgreSQL services decode their shared and own details")
func decodePostgresService() async throws {
    let postgres = try await decode(
        #"{"name":"db-1","type":"pg","plan":"startup-4","state":"running","zone":"ch-gva-2","version":"17","#
            + #""node-count":2,"termination-protection":true,"ip-filter":["10.0.0.0/8"],"#
            + #""maintenance":{"dow":"sunday","time":"03:00:00","updates":[{"description":"OS update"}]},"#
            + #""backups":[{"backup-name":"b-1","backup-time":"2026-01-02T03:04:05Z","data-size":10}],"#
            + #""node-states":[{"name":"db-1-1","state":"running","role":"master"}],"#
            + #""components":[{"component":"pg","host":"db.example.com","port":21699,"route":"dynamic"}],"#
            + #""prometheus-uri":{"host":"db.example.com","port":9273},"uri-params":{"port":"21699"},"#
            + #""connection-info":{"uri":["postgres://db"],"params":[{"host":"db"}]},"#
            + #""connection-pools":[{"name":"pool","database":"app","mode":"session","size":10,"#
            + #""username":"app","connection-uri":"postgres://pool"}],"#
            + #""users":[{"type":"primary","username":"avnadmin","password":"secret"}],"#
            + #""pg-settings":{"max_connections":200},"max-connections":200}"#,
        from: "/dbaas-postgres/db-1"
    ) { try await $0.dbaas.postgres.get(name: "db-1") }
    #expect(postgres == .init(
        service: .init(
            name: "db-1",
            type: "pg",
            plan: "startup-4",
            state: .running,
            zone: "ch-gva-2",
            version: "17",
            nodeCount: 2,
            terminationProtection: true,
            ipFilter: ["10.0.0.0/8"],
            maintenance: .init(day: .sunday, time: "03:00:00", updates: [.init(description: "OS update")]),
            backups: [.init(name: "b-1", time: Date(timeIntervalSince1970: 1_767_323_045), dataSize: 10)],
            nodeStates: [.init(name: "db-1-1", state: .running, role: .primary)],
            components: [.init(component: "pg", host: "db.example.com", port: 21699, route: "dynamic")],
            uriParams: ["port": "21699"],
            prometheusURI: .init(host: "db.example.com", port: 9273)
        ),
        connectionInfo: .init(uri: ["postgres://db"], params: [["host": "db"]]),
        users: [.init(username: "avnadmin", type: "primary", password: "secret")],
        connectionPools: [.init(
            name: "pool",
            database: "app",
            username: "app",
            mode: .session,
            size: 10,
            connectionURI: "postgres://pool"
        )],
        maxConnections: 200,
        pgSettings: ["max_connections": 200]
    ))
    #expect(postgres.state == .running)
    #expect(postgres.plan == "startup-4")

    let encoded = try JSON.encoder().encode(postgres)
    #expect(try JSON.decoder().decode(Exoscale.PostgresService.self, from: encoded) == postgres)
}

@Test("Kafka services and the service list decode")
func decodeKafkaAndServiceList() async throws {
    let kafka = try await decode(
        #"{"name":"events","type":"kafka","plan":"business-4","kafka-connect-enabled":true,"#
            + #""authentication-methods":{"certificate":true,"sasl":false},"#
            + #""connection-info":{"nodes":["k-1:9092"],"registry-uri":"https://registry"}}"#,
        from: "/dbaas-kafka/events"
    ) { try await $0.dbaas.kafka.get(name: "events") }
    #expect(kafka == .init(
        service: .init(name: "events", type: "kafka", plan: "business-4"),
        connectionInfo: .init(nodes: ["k-1:9092"], registryURI: "https://registry"),
        authenticationMethods: .init(certificate: true, sasl: false),
        kafkaConnectEnabled: true
    ))

    let services = try await decode(
        #"{"dbaas-services":[{"name":"db-1","type":"pg","plan":"startup-4","notifications":"#
            +
            #"[{"level":"warning","type":"service_end_of_life","message":"EOL","metadata":{"end-of-life":"2026"}}]}]}"#,
        from: "/dbaas-service"
    ) { try await $0.dbaas.list() }
    #expect(services == [.init(
        name: "db-1",
        type: "pg",
        plan: "startup-4",
        notifications: [.init(
            level: "warning",
            type: "service_end_of_life",
            message: "EOL",
            metadata: ["end-of-life": "2026"]
        )]
    )])
}

@Test("ClickHouse ACLs read both spellings of the default role flag")
func decodeClickHouseACLs() async throws {
    let acls = try await decode(
        #"{"users":[{"username":"app","roles":[{"name":"reader","default":true}],"#
            + #""privileges":[{"access-type":"SELECT","database":"app","partial-revoke":false}]}]}"#,
        from: "/dbaas-clickhouse/ch/acl-config"
    ) { try await $0.dbaas.clickhouse.acls(of: "ch") }
    #expect(acls == [.init(
        username: "app",
        roles: [.init(name: "reader", isDefault: true)],
        privileges: [.init(accessType: "SELECT", database: "app", isPartialRevoke: false)]
    )])

    let roles = try await decode(
        #"{"roles":[{"name":"admin","granted-roles":[{"name":"reader","is-default":false}],"#
            + #""privileges":[{"name":"ALL","grant-option":true}]}]}"#,
        from: "/dbaas-clickhouse/ch/role"
    ) { try await $0.dbaas.clickhouse.roles(of: "ch") }
    #expect(roles == [.init(
        name: "admin",
        privileges: [.init(name: "ALL", grantOption: true)],
        grantedRoles: [.init(name: "reader", isDefault: false)]
    )])
}

@Test("External endpoints decode their settings")
func decodeExternalEndpoints() async throws {
    let endpoint = try await decode(
        #"{"id":"e-1","name":"logs","type":"opensearch","#
            + #""settings":{"url":"https://search","index-prefix":"logs","index-days-max":7}}"#,
        from: "/dbaas-external-endpoint-opensearch/e-1"
    ) { try await $0.dbaas.externalEndpoints.get(id: "e-1", type: .opensearch) }
    #expect(endpoint == .init(
        id: "e-1",
        name: "logs",
        type: .opensearch,
        settings: .search(url: "https://search", indexPrefix: "logs", indexDaysMax: 7)
    ))
}

@Test("DBaaS users and credentials keep secrets out of descriptions")
func redactedDBaaSSecrets() {
    let user = Exoscale.DBaaSService.User(username: "app", password: "top-secret")
    let credentials = Exoscale.DBaaSService.Credentials(username: "app", password: "top-secret")
    for value in [user as Any, credentials as Any] {
        var dumped = ""
        dump(value, to: &dumped)
        #expect(!"\(value)".contains("top-secret"))
        #expect(!dumped.contains("top-secret"))
    }
}
