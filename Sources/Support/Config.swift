import Foundation

public extension Exoscale {
    /// SDK-level configuration used to construct an Exoscale client.
    struct Config: Sendable {
        public static let fallbackZone: Exoscale.ZoneName = .chGva2
        public static let fallbackUserAgent = "exoscale-swift"

        public let apiKey: String
        public let apiSecret: String
        public let userAgent: String
        public let zone: Exoscale.ZoneName

        /// The Exoscale API base URL for the configured zone.
        public let apiEndpoint: URL

        /// The Exoscale SOS object storage base URL for the configured zone.
        public let sosEndpoint: URL

        public init(
            apiKey: String? = nil,
            apiSecret: String? = nil,
            zone: Exoscale.ZoneName? = nil,
            userAgent: String? = nil,
            environment: [String: String] = ProcessInfo.processInfo.environment
        ) throws {
            self.apiKey = try Self.resolveRequiredValue(
                explicit: apiKey,
                environment: environment[EnvironmentKey.apiKey],
                error: .missingAPIKey
            )
            self.apiSecret = try Self.resolveRequiredValue(
                explicit: apiSecret,
                environment: environment[EnvironmentKey.apiSecret],
                error: .missingAPISecret
            )
            self.userAgent =
                userAgent ?? environment[EnvironmentKey.userAgent] ?? Self.fallbackUserAgent
            let zone = Self.resolveZone(zone: zone, environment: environment)
            guard let endpoints = zone.endpoints else {
                throw Error.invalidZone(zone.rawValue)
            }
            self.zone = zone
            apiEndpoint = endpoints.api
            sosEndpoint = endpoints.sos
        }

        private static func resolveRequiredValue(
            explicit: String?,
            environment: String?,
            error: Error
        ) throws -> String {
            if let explicit, !explicit.isEmpty {
                return explicit
            }

            if let environment, !environment.isEmpty {
                return environment
            }

            throw error
        }

        private static func resolveZone(
            zone: Exoscale.ZoneName?,
            environment: [String: String]
        ) -> Exoscale.ZoneName {
            zone ?? environment[EnvironmentKey.zone].map(Exoscale.ZoneName.init(rawValue:)) ?? fallbackZone
        }
    }
}

extension Exoscale.Config {
    private enum EnvironmentKey {
        static let apiKey = "EXOSCALE_API_KEY"
        static let apiSecret = "EXOSCALE_API_SECRET"
        static let userAgent = "EXOSCALE_USER_AGENT"
        static let zone = "EXOSCALE_ZONE"
    }
}

public extension Exoscale.Config {
    enum Error: Swift.Error, Equatable, LocalizedError {
        case missingAPIKey
        case missingAPISecret
        case invalidZone(String)

        public var errorDescription: String? {
            switch self {
            case .missingAPIKey:
                "Exoscale API key is required."
            case .missingAPISecret:
                "Exoscale API secret is required."
            case let .invalidZone(value):
                "Exoscale zone '\(value)' is invalid."
            }
        }
    }
}

extension Exoscale.Config: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    /// Describes the configuration without its API secret, so it is safe to log.
    public var description: String {
        "Config(apiKey: \(apiKey), apiSecret: <redacted>, zone: \(zone), userAgent: \(userAgent))"
    }

    public var debugDescription: String {
        description
    }

    public var customMirror: Mirror {
        Mirror(self, children: [
            "apiKey": apiKey,
            "apiSecret": "<redacted>",
            "zone": zone,
            "userAgent": userAgent,
            "apiEndpoint": apiEndpoint,
            "sosEndpoint": sosEndpoint
        ])
    }
}
