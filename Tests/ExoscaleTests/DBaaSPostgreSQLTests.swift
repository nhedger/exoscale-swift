import Foundation
import Testing

@testable import Exoscale

@Test("DBaaS PostgreSQL service request bodies encode")
func dbaasPostgreSQLServiceRequestBodiesEncode() throws {
    let createData = try JSONEncoder().encode(
        CreateDBaaSPostgreSQLServiceRequest(
            pgbouncerSettings: ["pool_mode": .string("transaction")],
            backupSchedule: .init(backupHour: 2, backupMinute: 30),
            variant: .timescale,
            integrations: [
                .init(
                    type: "read_replica",
                    sourceService: "source-pg",
                    destinationService: "replica-pg",
                    settings: ["sync": .bool(true)]
                ),
            ],
            timescaledbSettings: ["max_background_workers": .integer(8)],
            ipFilter: ["10.0.0.0/24"],
            terminationProtection: true,
            forkFromService: "source-pg",
            synchronousReplication: .quorum,
            recoveryBackupTime: "2026-04-27T10:00:00Z",
            pglookoutSettings: ["max_failover_replication_time_lag": .integer(60)],
            maintenance: .init(dayOfWeek: "monday", time: "10:00:00"),
            adminUsername: "admin",
            version: "16",
            plan: "startup-4",
            workMem: 16,
            sharedBuffersPercentage: 30,
            pgSettings: ["max_connections": .integer(100)],
            adminPassword: "super-secret",
            migration: .init(
                host: "old-db.example.com",
                port: 5432,
                password: "password",
                ssl: true,
                username: "postgres",
                databaseName: "app",
                method: .replication
            )
        )
    )
    let createObject = try #require(JSONSerialization.jsonObject(with: createData) as? [String: Any])
    let backupSchedule = try #require(createObject["backup-schedule"] as? [String: Any])
    let maintenance = try #require(createObject["maintenance"] as? [String: Any])
    let integration = try #require((createObject["integrations"] as? [[String: Any]])?.first)
    let migration = try #require(createObject["migration"] as? [String: Any])
    let pgSettings = try #require(createObject["pg-settings"] as? [String: Any])

    let updateData = try JSONEncoder().encode(
        UpdateDBaaSPostgreSQLServiceRequest(
            pgbouncerSettings: nil,
            backupSchedule: .init(backupHour: 4),
            variant: .aiven,
            timescaledbSettings: nil,
            ipFilter: ["192.0.2.0/24"],
            terminationProtection: false,
            synchronousReplication: .off,
            pglookoutSettings: nil,
            maintenance: .init(dayOfWeek: "tuesday", time: "11:00:00"),
            version: "17",
            plan: "business-8",
            workMem: 32,
            sharedBuffersPercentage: 40,
            pgSettings: ["log_min_duration_statement": .integer(500)],
            migration: nil
        )
    )
    let updateObject = try #require(JSONSerialization.jsonObject(with: updateData) as? [String: Any])

    #expect(createObject["plan"] as? String == "startup-4")
    #expect(createObject["version"] as? String == "16")
    #expect(createObject["variant"] as? String == "timescale")
    #expect(createObject["ip-filter"] as? [String] == ["10.0.0.0/24"])
    #expect(createObject["termination-protection"] as? Bool == true)
    #expect(createObject["synchronous-replication"] as? String == "quorum")
    #expect(createObject["admin-username"] as? String == "admin")
    #expect(createObject["admin-password"] as? String == "super-secret")
    #expect(createObject["fork-from-service"] as? String == "source-pg")
    #expect(createObject["recovery-backup-time"] as? String == "2026-04-27T10:00:00Z")
    #expect(createObject["work-mem"] as? Int == 16)
    #expect(createObject["shared-buffers-percentage"] as? Int == 30)
    #expect(backupSchedule["backup-hour"] as? Int == 2)
    #expect(backupSchedule["backup-minute"] as? Int == 30)
    #expect(maintenance["dow"] as? String == "monday")
    #expect(integration["type"] as? String == "read_replica")
    #expect(integration["source-service"] as? String == "source-pg")
    #expect(integration["dest-service"] as? String == "replica-pg")
    #expect(migration["host"] as? String == "old-db.example.com")
    #expect(migration["dbname"] as? String == "app")
    #expect(migration["method"] as? String == "replication")
    #expect(pgSettings["max_connections"] as? Int == 100)
    #expect(updateObject["plan"] as? String == "business-8")
    #expect(updateObject["synchronous-replication"] as? String == "off")
    #expect(updateObject["admin-password"] == nil)
}

@Test("DBaaS PostgreSQL action request bodies encode")
func dbaasPostgreSQLActionRequestBodiesEncode() throws {
    let createPoolData = try JSONEncoder().encode(
        CreateDBaaSPostgreSQLConnectionPoolRequest(
            name: "pool",
            databaseName: "app",
            mode: .transaction,
            size: 10,
            username: "app"
        )
    )
    let createPoolObject = try #require(JSONSerialization.jsonObject(with: createPoolData) as? [String: Any])

    let updatePoolData = try JSONEncoder().encode(
        UpdateDBaaSPostgreSQLConnectionPoolRequest(
            databaseName: "app2",
            mode: .session,
            size: 20,
            username: "app2"
        )
    )
    let updatePoolObject = try #require(JSONSerialization.jsonObject(with: updatePoolData) as? [String: Any])

    let createDatabaseData = try JSONEncoder().encode(
        CreateDBaaSPostgreSQLDatabaseRequest(databaseName: "app", lcCollate: "en_US.UTF-8", lcCType: "en_US.UTF-8")
    )
    let createDatabaseObject = try #require(JSONSerialization.jsonObject(with: createDatabaseData) as? [String: Any])

    let createUserData = try JSONEncoder().encode(
        CreateDBaaSPostgreSQLUserRequest(username: "app", allowReplication: true)
    )
    let createUserObject = try #require(JSONSerialization.jsonObject(with: createUserData) as? [String: Any])

    let updateReplicationData = try JSONEncoder().encode(
        UpdateDBaaSPostgreSQLUserReplicationRequest(allowReplication: false)
    )
    let updateReplicationObject = try #require(JSONSerialization.jsonObject(with: updateReplicationData) as? [String: Any])

    let resetPasswordData = try JSONEncoder().encode(ResetDBaaSPostgreSQLUserPasswordRequest(password: "new-secret"))
    let resetPasswordObject = try #require(JSONSerialization.jsonObject(with: resetPasswordData) as? [String: Any])

    let upgradeData = try JSONEncoder().encode(CheckDBaaSPostgreSQLUpgradeRequest(targetVersion: "17"))
    let upgradeObject = try #require(JSONSerialization.jsonObject(with: upgradeData) as? [String: Any])

    #expect(createPoolObject["name"] as? String == "pool")
    #expect(createPoolObject["database-name"] as? String == "app")
    #expect(createPoolObject["mode"] as? String == "transaction")
    #expect(createPoolObject["size"] as? Int == 10)
    #expect(createPoolObject["username"] as? String == "app")
    #expect(updatePoolObject["mode"] as? String == "session")
    #expect(updatePoolObject["database-name"] as? String == "app2")
    #expect(createDatabaseObject["database-name"] as? String == "app")
    #expect(createDatabaseObject["lc-collate"] as? String == "en_US.UTF-8")
    #expect(createDatabaseObject["lc-ctype"] as? String == "en_US.UTF-8")
    #expect(createUserObject["username"] as? String == "app")
    #expect(createUserObject["allow-replication"] as? Bool == true)
    #expect(updateReplicationObject["allow-replication"] as? Bool == false)
    #expect(resetPasswordObject["password"] as? String == "new-secret")
    #expect(upgradeObject["target-version"] as? String == "17")
}

@Test("DBaaS PostgreSQL service decodes")
func dbaasPostgreSQLServiceDecodes() throws {
    let data = Data(
        """
        {
          "name": "primary-pg",
          "plan": "startup-4",
          "type": "pg",
          "state": "running",
          "zone": "ch-gva-2",
          "created-at": "2026-04-27T10:00:00Z",
          "updated-at": "2026-04-27T11:00:00Z",
          "node-count": 2,
          "node-cpu-count": 4,
          "disk-size": 102400,
          "node-memory": 8192,
          "prometheus-uri": { "host": "prometheus.example.com", "port": 9273 },
          "connection-info": {
            "uri": ["postgres://avnadmin:secret@db.example.com/defaultdb"],
            "params": [{ "host": "db.example.com", "port": "5432" }],
            "standby": [],
            "syncing": []
          },
          "backup-schedule": { "backup-hour": 2, "backup-minute": 30 },
          "connection-pools": [
            {
              "connection-uri": "postgres://app:secret@db.example.com/app",
              "database": "app",
              "mode": "transaction",
              "name": "pool",
              "size": 10,
              "username": "app"
            }
          ],
          "databases": ["defaultdb", "app"],
          "ip-filter": ["10.0.0.0/24"],
          "backups": [{ "backup-name": "backup-1", "backup-time": "2026-04-27T09:00:00Z", "data-size": 12345 }],
          "termination-protection": true,
          "notifications": [
            { "level": "notice", "message": "ok", "type": "service_end_of_life", "metadata": { "version": "13" } }
          ],
          "components": [
            { "component": "pg", "host": "db.example.com", "port": 5432, "route": "public", "usage": "primary" }
          ],
          "synchronous-replication": "quorum",
          "maintenance": {
            "dow": "monday",
            "time": "10:00:00",
            "updates": [
              {
                "description": "minor update",
                "deadline": "2026-05-01T10:00:00Z",
                "start-after": "2026-04-28T10:00:00Z",
                "start-at": "2026-04-29T10:00:00Z"
              }
            ]
          },
          "node-states": [
            {
              "name": "primary-pg-1",
              "role": "master",
              "state": "running",
              "progress-updates": [{ "completed": true, "phase": "finalize", "unit": "percent" }]
            }
          ],
          "pg-settings": { "max_connections": 100 },
          "pgbouncer-settings": { "pool_mode": "transaction" },
          "timescaledb-settings": { "max_background_workers": 8 },
          "pglookout-settings": { "max_failover_replication_time_lag": 60 },
          "uri": "postgres://avnadmin:secret@db.example.com/defaultdb",
          "uri-params": { "host": "db.example.com" },
          "version": "16",
          "work-mem": 16,
          "shared-buffers-percentage": 30,
          "max-connections": 100,
          "users": [{ "type": "primary", "username": "avnadmin", "allow-replication": true }]
        }
        """.utf8
    )

    let service = try JSONDecoder().decode(Exoscale.DBaaS.PostgreSQL.Service.self, from: data)

    #expect(service.name == "primary-pg")
    #expect(service.plan == "startup-4")
    #expect(service.state == "running")
    #expect(service.nodeCount == 2)
    #expect(service.prometheusURI?.host == "prometheus.example.com")
    #expect(service.connectionInfo?.params?.first?["host"] == "db.example.com")
    #expect(service.backupSchedule?.backupHour == 2)
    #expect(service.connectionPools?.first?.mode == .transaction)
    #expect(service.databases == ["defaultdb", "app"])
    #expect(service.backups?.first?.backupName == "backup-1")
    #expect(service.notifications?.first?.metadata?["version"] == .string("13"))
    #expect(service.components?.first?.port == 5432)
    #expect(service.synchronousReplication == .quorum)
    #expect(service.maintenance?.updates?.first?.description == "minor update")
    #expect(service.nodeStates?.first?.progressUpdates?.first?.completed == true)
    #expect(service.pgSettings?["max_connections"] == .integer(100))
    #expect(service.uriParams?["host"] == .string("db.example.com"))
    #expect(service.users?.first?.allowReplication == true)
}

@Test("DBaaS PostgreSQL responses decode")
func dbaasPostgreSQLResponsesDecode() throws {
    let usersData = Data(#"{"users":[{"username":"app","allow-replication":true}]}"#.utf8)
    let usersResponse = try JSONDecoder().decode(DBaaSPostgreSQLUsersResponse.self, from: usersData)

    let secretsData = Data(#"{"username":"app","password":"secret"}"#.utf8)
    let secrets = try JSONDecoder().decode(Exoscale.DBaaS.PostgreSQL.UserSecrets.self, from: secretsData)

    let taskData = Data(
        #"{"id":"11111111-1111-1111-1111-111111111111","create-time":"2026-04-27T10:00:00Z","result":"ok","result-codes":[{"code":"ready","dbname":"app"}],"success":true,"task-type":"upgrade_check"}"#.utf8
    )
    let task = try JSONDecoder().decode(Exoscale.DBaaS.Task.self, from: taskData)

    let settingsData = Data(
        """
        {
          "settings": {
            "pg": {
              "type": "object",
              "title": "postgresql.conf configuration values",
              "additionalProperties": false,
              "properties": {
                "work_mem": { "type": "integer" }
              }
            }
          }
        }
        """.utf8
    )
    let settingsResponse = try JSONDecoder().decode(GetDBaaSPostgreSQLSettingsResponse.self, from: settingsData)

    #expect(usersResponse.users.first?.username == "app")
    #expect(usersResponse.users.first?.allowReplication == true)
    #expect(secrets.username == "app")
    #expect(secrets.password == "secret")
    #expect(task.id == "11111111-1111-1111-1111-111111111111")
    #expect(task.resultCodes?.first?.databaseName == "app")
    #expect(task.success == true)
    #expect(settingsResponse.settings.pg?.type == "object")
    #expect(settingsResponse.settings.pg?.additionalProperties == false)
    #expect(settingsResponse.settings.pg?.properties?["work_mem"] == .object(["type": .string("integer")]))
}

@Test("Client builds DBaaS PostgreSQL paths")
func clientBuildsDBaaSPostgreSQLPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let serviceRequest = try client.http.makeRequest("GET", path: "/dbaas-postgres/primary-pg")
    let createPoolRequest = try client.http.makeRequest("POST", path: "/dbaas-postgres/primary-pg/connection-pool")
    let updatePoolRequest = try client.http.makeRequest("PUT", path: "/dbaas-postgres/primary-pg/connection-pool/pool")
    let deleteDatabaseRequest = try client.http.makeRequest("DELETE", path: "/dbaas-postgres/primary-pg/database/app")
    let updateUserRequest = try client.http.makeRequest("PUT", path: "/dbaas-postgres/primary-pg/user/app/allow-replication")
    let settingsRequest = try client.http.makeRequest("GET", path: "/dbaas-settings-pg")

    #expect(serviceRequest.url?.path == "/v2/dbaas-postgres/primary-pg")
    #expect(createPoolRequest.url?.path == "/v2/dbaas-postgres/primary-pg/connection-pool")
    #expect(updatePoolRequest.url?.path == "/v2/dbaas-postgres/primary-pg/connection-pool/pool")
    #expect(deleteDatabaseRequest.url?.path == "/v2/dbaas-postgres/primary-pg/database/app")
    #expect(updateUserRequest.url?.path == "/v2/dbaas-postgres/primary-pg/user/app/allow-replication")
    #expect(settingsRequest.url?.path == "/v2/dbaas-settings-pg")
}
