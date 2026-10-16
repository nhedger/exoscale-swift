import Foundation

enum DBaaSPostgreSQLFixtures {
    static let data = Data(#"""
    {
      "backup-schedule" : {
        "backup-hour" : 2,
        "backup-minute" : 30
      },
      "backups" : [
        {
          "backup-name" : "backup-1",
          "backup-time" : "2026-04-27T09:00:00Z",
          "data-size" : 12345
        }
      ],
      "components" : [
        {
          "component" : "pg",
          "host" : "db.example.com",
          "port" : 5432,
          "route" : "public",
          "usage" : "primary"
        }
      ],
      "connection-info" : {
        "params" : [
          {
            "host" : "db.example.com",
            "port" : "5432"
          }
        ],
        "standby" : [

        ],
        "syncing" : [

        ],
        "uri" : [
          "postgres://avnadmin:secret@db.example.com/defaultdb"
        ]
      },
      "connection-pools" : [
        {
          "connection-uri" : "postgres://app:secret@db.example.com/app",
          "database" : "app",
          "mode" : "transaction",
          "name" : "pool",
          "size" : 10,
          "username" : "app"
        }
      ],
      "created-at" : "2026-04-27T10:00:00Z",
      "databases" : [
        "defaultdb",
        "app"
      ],
      "disk-size" : 102400,
      "ip-filter" : [
        "10.0.0.0/24"
      ],
      "maintenance" : {
        "dow" : "monday",
        "time" : "10:00:00",
        "updates" : [
          {
            "deadline" : "2026-05-01T10:00:00Z",
            "description" : "minor update",
            "start-after" : "2026-04-28T10:00:00Z",
            "start-at" : "2026-04-29T10:00:00Z"
          }
        ]
      },
      "max-connections" : 100,
      "name" : "primary-pg",
      "node-count" : 2,
      "node-cpu-count" : 4,
      "node-memory" : 8192,
      "node-states" : [
        {
          "name" : "primary-pg-1",
          "progress-updates" : [
            {
              "completed" : true,
              "phase" : "finalize",
              "unit" : "percent"
            }
          ],
          "role" : "master",
          "state" : "running"
        }
      ],
      "notifications" : [
        {
          "level" : "notice",
          "message" : "ok",
          "metadata" : {
            "version" : "13"
          },
          "type" : "service_end_of_life"
        }
      ],
      "pg-settings" : {
        "max_connections" : 100
      },
      "pgbouncer-settings" : {
        "pool_mode" : "transaction"
      },
      "pglookout-settings" : {
        "max_failover_replication_time_lag" : 60
      },
      "plan" : "startup-4",
      "prometheus-uri" : {
        "host" : "prometheus.example.com",
        "port" : 9273
      },
      "shared-buffers-percentage" : 30,
      "state" : "running",
      "synchronous-replication" : "quorum",
      "termination-protection" : true,
      "timescaledb-settings" : {
        "max_background_workers" : 8
      },
      "type" : "pg",
      "updated-at" : "2026-04-27T11:00:00Z",
      "uri" : "postgres://avnadmin:secret@db.example.com/defaultdb",
      "uri-params" : {
        "host" : "db.example.com"
      },
      "users" : [
        {
          "allow-replication" : true,
          "type" : "primary",
          "username" : "avnadmin"
        }
      ],
      "version" : "16",
      "work-mem" : 16,
      "zone" : "ch-gva-2"
    }
    """#.utf8)

    static let taskData = Data(#"""
    {
      "create-time" : "2026-04-27T10:00:00Z",
      "id" : "11111111-1111-1111-1111-111111111111",
      "result" : "ok",
      "result-codes" : [
        {
          "code" : "ready",
          "dbname" : "app"
        }
      ],
      "success" : true,
      "task-type" : "upgrade_check"
    }
    """#.utf8)

    static let settingsData = Data(#"""
    {
      "settings" : {
        "pg" : {
          "additionalProperties" : false,
          "properties" : {
            "work_mem" : {
              "type" : "integer"
            }
          },
          "title" : "postgresql.conf configuration values",
          "type" : "object"
        }
      }
    }
    """#.utf8)
}
