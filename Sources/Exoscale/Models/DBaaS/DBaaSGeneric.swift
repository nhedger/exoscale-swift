public extension Exoscale.DBaaS {
    /// External endpoint type supported by DBaaS.
    enum ExternalEndpointType: String, Codable, Sendable {
        case prometheus
        case opensearch
        case rsyslog
        case datadog
        case elasticsearch
    }

    /// DBaaS service integration type.
    enum IntegrationType: String, Codable, Sendable {
        case datasource
        case logs
        case metrics
    }

    /// Sort order for DBaaS log queries.
    enum SortOrder: String, Codable, Sendable {
        case ascending = "asc"
        case descending = "desc"
    }

    /// Period for DBaaS metric queries.
    enum MetricsPeriod: String, Codable, Sendable {
        case hour
        case day
        case week
        case month
        case year
    }

    /// Common DBaaS service summary returned by the API.
    struct Service: Codable, Sendable {
        public let updatedAt: String?
        public let nodeCount: Int?
        public let nodeCPUCount: Int?
        public let integrations: [Integration]?
        public let zone: String?
        public let name: String?
        public let type: String?
        public let state: String?
        public let terminationProtection: Bool?
        public let notifications: [Notification]?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let createdAt: String?
        public let plan: String?

        enum CodingKeys: String, CodingKey {
            case updatedAt = "updated-at"
            case nodeCount = "node-count"
            case nodeCPUCount = "node-cpu-count"
            case integrations
            case zone
            case name
            case type
            case state
            case terminationProtection = "termination-protection"
            case notifications
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case createdAt = "created-at"
            case plan
        }
    }

    /// DBaaS service type returned by the API.
    struct ServiceType: Codable, Sendable {
        public struct Plan: Codable, Sendable {
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

        public let name: String?
        public let availableVersions: [String]?
        public let defaultVersion: String?
        public let description: String?
        public let plans: [Plan]?

        enum CodingKeys: String, CodingKey {
            case name
            case availableVersions = "available-versions"
            case defaultVersion = "default-version"
            case description
            case plans
        }
    }

    /// DBaaS service logs returned by the API.
    struct ServiceLogs: Codable, Sendable {
        public struct Entry: Codable, Sendable {
            public let unit: String?
            public let time: String?
            public let message: String?
            public let node: String?
        }

        public let offset: String?
        public let firstLogOffset: String?
        public let logs: [Entry]?

        enum CodingKeys: String, CodingKey {
            case offset
            case firstLogOffset = "first-log-offset"
            case logs
        }
    }

    /// DBaaS migration status returned by the API.
    struct MigrationStatus: Codable, Sendable {
        public struct Detail: Codable, Sendable {
            public let databaseName: String?
            public let error: String?
            public let method: String?
            public let status: String?

            enum CodingKeys: String, CodingKey {
                case databaseName = "dbname"
                case error
                case method
                case status
            }
        }

        public let error: String?
        public let method: String?
        public let status: String?
        public let details: [Detail]?
    }

    /// DBaaS external endpoint returned by the API.
    struct ExternalEndpoint: Codable, Sendable {
        public let name: String?
        public let type: ExternalEndpointType?
        public let id: String?
        public let settings: [String: Exoscale.JSONValue]?
    }

    /// DBaaS external endpoint type metadata returned by the API.
    struct ExternalEndpointTypeInfo: Codable, Sendable {
        public let type: ExternalEndpointType?
        public let serviceTypes: [String]?
        public let title: String?

        enum CodingKeys: String, CodingKey {
            case type
            case serviceTypes = "service-types"
            case title
        }
    }

    /// DBaaS external integration returned by the API.
    struct ExternalIntegration: Codable, Sendable {
        public let description: String?
        public let destinationEndpointName: String?
        public let destinationEndpointID: String?
        public let integrationID: String?
        public let status: String?
        public let sourceServiceName: String?
        public let sourceServiceType: String?
        public let type: String?

        enum CodingKeys: String, CodingKey {
            case description
            case destinationEndpointName = "dest-endpoint-name"
            case destinationEndpointID = "dest-endpoint-id"
            case integrationID = "integration-id"
            case status
            case sourceServiceName = "source-service-name"
            case sourceServiceType = "source-service-type"
            case type
        }
    }

    /// DBaaS integration type returned by the API.
    struct IntegrationTypeInfo: Codable, Sendable {
        public let type: IntegrationType?
        public let sourceDescription: String?
        public let sourceServiceTypes: [String]?
        public let destinationDescription: String?
        public let destinationServiceTypes: [String]?
        public let settings: [String: Exoscale.JSONValue]?

        enum CodingKeys: String, CodingKey {
            case type
            case sourceDescription = "source-description"
            case sourceServiceTypes = "source-service-types"
            case destinationDescription = "dest-description"
            case destinationServiceTypes = "dest-service-types"
            case settings
        }
    }

    /// DBaaS Datadog external integration settings.
    struct DatadogIntegrationSettings: Codable, Sendable {
        public let datadogDBMEnabled: Bool?
        public let datadogPGBouncerEnabled: Bool?

        public init(datadogDBMEnabled: Bool? = nil, datadogPGBouncerEnabled: Bool? = nil) {
            self.datadogDBMEnabled = datadogDBMEnabled
            self.datadogPGBouncerEnabled = datadogPGBouncerEnabled
        }

        enum CodingKeys: String, CodingKey {
            case datadogDBMEnabled = "datadog-dbm-enabled"
            case datadogPGBouncerEnabled = "datadog-pgbouncer-enabled"
        }
    }
}
