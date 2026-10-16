import Foundation

extension Exoscale.DBaaS.ServiceType.Plan {
    enum CodingKeys: String, CodingKey {
        case nodeCount = "node-count"
        case backupConfig = "backup-config"
        case nodeCPUCount = "node-cpu-count"
        case family
        case diskSpace = "disk-space"
        case authorized
        case name
        case maxMemoryPercent = "max-memory-percent"
        case zones
        case nodeMemory = "node-memory"
    }
}

public extension Exoscale.DBaaS.ServiceType {
    struct Plan: Codable, Hashable, Sendable {
        public let nodeCount: Int?
        public let backupConfig: [String: Exoscale.JSONValue]?
        public let nodeCPUCount: Int?
        public let family: String?
        public let diskSpace: Int?
        public let authorized: Bool?
        public let name: String?
        public let maxMemoryPercent: Int?
        public let zones: [String]?
        public let nodeMemory: Int?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            nodeCount: Int? = nil,
            backupConfig: [String: Exoscale.JSONValue]? = nil,
            nodeCPUCount: Int? = nil,
            family: String? = nil,
            diskSpace: Int? = nil,
            authorized: Bool? = nil,
            name: String? = nil,
            maxMemoryPercent: Int? = nil,
            zones: [String]? = nil,
            nodeMemory: Int? = nil
        ) {
            self.nodeCount = nodeCount
            self.backupConfig = backupConfig
            self.nodeCPUCount = nodeCPUCount
            self.family = family
            self.diskSpace = diskSpace
            self.authorized = authorized
            self.name = name
            self.maxMemoryPercent = maxMemoryPercent
            self.zones = zones
            self.nodeMemory = nodeMemory
        }
    }
}

public extension Exoscale.DBaaS.ServiceLogs {
    struct Entry: Codable, Hashable, Sendable {
        public let unit: String?
        public let time: String?
        public let message: String?
        public let node: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            unit: String? = nil,
            time: String? = nil,
            message: String? = nil,
            node: String? = nil
        ) {
            self.unit = unit
            self.time = time
            self.message = message
            self.node = node
        }
    }
}

extension Exoscale.DBaaS.MigrationStatus.Detail {
    enum CodingKeys: String, CodingKey {
        case databaseName = "dbname"
        case error
        case method
        case status
    }
}

public extension Exoscale.DBaaS.MigrationStatus {
    struct Detail: Codable, Hashable, Sendable {
        public let databaseName: String?
        public let error: String?
        public let method: String?
        public let status: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            databaseName: String? = nil,
            error: String? = nil,
            method: String? = nil,
            status: String? = nil
        ) {
            self.databaseName = databaseName
            self.error = error
            self.method = method
            self.status = status
        }
    }
}

extension Exoscale.DBaaS.DatadogIntegrationSettings {
    enum CodingKeys: String, CodingKey {
        case datadogDBMEnabled = "datadog-dbm-enabled"
        case datadogPGBouncerEnabled = "datadog-pgbouncer-enabled"
    }
}
