import Foundation

public extension Exoscale.DBaaS {
    /// External endpoint type supported by DBaaS.
    enum ExternalEndpointType: Exoscale.ExtensibleEnum {
        case prometheus
        case opensearch
        case rsyslog
        case datadog
        case elasticsearch
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.prometheus, .opensearch, .rsyslog, .datadog, .elasticsearch]

        public var rawValue: String {
            switch self {
            case .prometheus: "prometheus"
            case .opensearch: "opensearch"
            case .rsyslog: "rsyslog"
            case .datadog: "datadog"
            case .elasticsearch: "elasticsearch"
            case let .unknown(value): value
            }
        }
    }

    /// DBaaS service integration type.
    enum IntegrationType: Exoscale.ExtensibleEnum {
        case datasource
        case logs
        case metrics
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.datasource, .logs, .metrics]

        public var rawValue: String {
            switch self {
            case .datasource: "datasource"
            case .logs: "logs"
            case .metrics: "metrics"
            case let .unknown(value): value
            }
        }
    }

    /// Sort order for DBaaS log queries.
    enum SortOrder: Exoscale.ExtensibleEnum {
        case ascending
        case descending
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.ascending, .descending]

        public var rawValue: String {
            switch self {
            case .ascending: "asc"
            case .descending: "desc"
            case let .unknown(value): value
            }
        }
    }

    /// Period for DBaaS metric queries.
    enum MetricsPeriod: Exoscale.ExtensibleEnum {
        case hour
        case day
        case week
        case month
        case year
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.hour, .day, .week, .month, .year]

        public var rawValue: String {
            switch self {
            case .hour: "hour"
            case .day: "day"
            case .week: "week"
            case .month: "month"
            case .year: "year"
            case let .unknown(value): value
            }
        }
    }

    /// Common DBaaS service summary returned by the API.
    struct Service: Hashable, Sendable {
        public let updatedAt: Date?
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
        public let createdAt: Date?
        public let plan: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            updatedAt: Date? = nil,
            nodeCount: Int? = nil,
            nodeCPUCount: Int? = nil,
            integrations: [Integration]? = nil,
            zone: String? = nil,
            name: String? = nil,
            type: String? = nil,
            state: String? = nil,
            terminationProtection: Bool? = nil,
            notifications: [Notification]? = nil,
            diskSize: Int? = nil,
            nodeMemory: Int? = nil,
            createdAt: Date? = nil,
            plan: String? = nil
        ) {
            self.updatedAt = updatedAt
            self.nodeCount = nodeCount
            self.nodeCPUCount = nodeCPUCount
            self.integrations = integrations
            self.zone = zone
            self.name = name
            self.type = type
            self.state = state
            self.terminationProtection = terminationProtection
            self.notifications = notifications
            self.diskSize = diskSize
            self.nodeMemory = nodeMemory
            self.createdAt = createdAt
            self.plan = plan
        }

        init(data: Payload, client: Http.Client) {
            updatedAt = data.updatedAt
            nodeCount = data.nodeCount
            nodeCPUCount = data.nodeCPUCount
            integrations = data.integrations.map { $0.map { Exoscale.DBaaS.Integration(data: $0, client: client) } }
            zone = data.zone
            name = data.name
            type = data.type
            state = data.state
            terminationProtection = data.terminationProtection
            notifications = data.notifications.map { $0.map { Exoscale.DBaaS.Notification(data: $0, client: client) } }
            diskSize = data.diskSize
            nodeMemory = data.nodeMemory
            createdAt = data.createdAt
            plan = data.plan
        }
    }

    /// DBaaS service type returned by the API.
    struct ServiceType: Hashable, Sendable {
        public let name: String?
        public let availableVersions: [String]?
        public let defaultVersion: String?
        public let description: String?
        public let plans: [Plan]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: String? = nil,
            availableVersions: [String]? = nil,
            defaultVersion: String? = nil,
            description: String? = nil,
            plans: [Plan]? = nil
        ) {
            self.name = name
            self.availableVersions = availableVersions
            self.defaultVersion = defaultVersion
            self.description = description
            self.plans = plans
        }

        init(data: Payload, client _: Http.Client) {
            name = data.name
            availableVersions = data.availableVersions
            defaultVersion = data.defaultVersion
            description = data.description
            plans = data.plans
        }
    }

    /// DBaaS service logs returned by the API.
    struct ServiceLogs: Hashable, Sendable {
        public let offset: String?
        public let firstLogOffset: String?
        public let logs: [Entry]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            offset: String? = nil,
            firstLogOffset: String? = nil,
            logs: [Entry]? = nil
        ) {
            self.offset = offset
            self.firstLogOffset = firstLogOffset
            self.logs = logs
        }

        init(data: Payload, client _: Http.Client) {
            offset = data.offset
            firstLogOffset = data.firstLogOffset
            logs = data.logs
        }
    }

    /// DBaaS migration status returned by the API.
    struct MigrationStatus: Hashable, Sendable {
        public let error: String?
        public let method: String?
        public let status: String?
        public let details: [Detail]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            error: String? = nil,
            method: String? = nil,
            status: String? = nil,
            details: [Detail]? = nil
        ) {
            self.error = error
            self.method = method
            self.status = status
            self.details = details
        }

        init(data: Payload, client _: Http.Client) {
            error = data.error
            method = data.method
            status = data.status
            details = data.details
        }
    }

    /// DBaaS external endpoint returned by the API.
    struct ExternalEndpoint: Hashable, Sendable {
        public let name: String?
        public let type: ExternalEndpointType?
        public let id: String?
        public let settings: [String: Exoscale.JSONValue]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: String? = nil,
            type: ExternalEndpointType? = nil,
            id: String? = nil,
            settings: [String: Exoscale.JSONValue]? = nil
        ) {
            self.name = name
            self.type = type
            self.id = id
            self.settings = settings
        }

        init(data: Payload, client _: Http.Client) {
            name = data.name
            type = data.type
            id = data.id
            settings = data.settings
        }
    }

    /// DBaaS external endpoint type metadata returned by the API.
    struct ExternalEndpointTypeInfo: Hashable, Sendable {
        public let type: ExternalEndpointType?
        public let serviceTypes: [String]?
        public let title: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            type: ExternalEndpointType? = nil,
            serviceTypes: [String]? = nil,
            title: String? = nil
        ) {
            self.type = type
            self.serviceTypes = serviceTypes
            self.title = title
        }

        init(data: Payload, client _: Http.Client) {
            type = data.type
            serviceTypes = data.serviceTypes
            title = data.title
        }
    }

    /// DBaaS external integration returned by the API.
    struct ExternalIntegration: Hashable, Sendable {
        public let description: String?
        public let destinationEndpointName: String?
        public let destinationEndpointID: String?
        public let integrationID: String?
        public let status: String?
        public let sourceServiceName: String?
        public let sourceServiceType: String?
        public let type: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            destinationEndpointName: String? = nil,
            destinationEndpointID: String? = nil,
            integrationID: String? = nil,
            status: String? = nil,
            sourceServiceName: String? = nil,
            sourceServiceType: String? = nil,
            type: String? = nil
        ) {
            self.description = description
            self.destinationEndpointName = destinationEndpointName
            self.destinationEndpointID = destinationEndpointID
            self.integrationID = integrationID
            self.status = status
            self.sourceServiceName = sourceServiceName
            self.sourceServiceType = sourceServiceType
            self.type = type
        }

        init(data: Payload, client _: Http.Client) {
            description = data.description
            destinationEndpointName = data.destinationEndpointName
            destinationEndpointID = data.destinationEndpointID
            integrationID = data.integrationID
            status = data.status
            sourceServiceName = data.sourceServiceName
            sourceServiceType = data.sourceServiceType
            type = data.type
        }
    }

    /// DBaaS integration type returned by the API.
    struct IntegrationTypeInfo: Hashable, Sendable {
        public let type: IntegrationType?
        public let sourceDescription: String?
        public let sourceServiceTypes: [String]?
        public let destinationDescription: String?
        public let destinationServiceTypes: [String]?
        public let settings: [String: Exoscale.JSONValue]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            type: IntegrationType? = nil,
            sourceDescription: String? = nil,
            sourceServiceTypes: [String]? = nil,
            destinationDescription: String? = nil,
            destinationServiceTypes: [String]? = nil,
            settings: [String: Exoscale.JSONValue]? = nil
        ) {
            self.type = type
            self.sourceDescription = sourceDescription
            self.sourceServiceTypes = sourceServiceTypes
            self.destinationDescription = destinationDescription
            self.destinationServiceTypes = destinationServiceTypes
            self.settings = settings
        }

        init(data: Payload, client _: Http.Client) {
            type = data.type
            sourceDescription = data.sourceDescription
            sourceServiceTypes = data.sourceServiceTypes
            destinationDescription = data.destinationDescription
            destinationServiceTypes = data.destinationServiceTypes
            settings = data.settings
        }
    }

    /// DBaaS Datadog external integration settings.
    struct DatadogIntegrationSettings: Codable, Hashable, Sendable {
        public let datadogDBMEnabled: Bool?
        public let datadogPGBouncerEnabled: Bool?

        public init(datadogDBMEnabled: Bool? = nil, datadogPGBouncerEnabled: Bool? = nil) {
            self.datadogDBMEnabled = datadogDBMEnabled
            self.datadogPGBouncerEnabled = datadogPGBouncerEnabled
        }
    }
}
