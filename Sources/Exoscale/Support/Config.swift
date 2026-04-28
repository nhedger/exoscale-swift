import Foundation

extension Exoscale {
    /// SDK-level configuration used to construct an Exoscale client.
    public struct Config: Sendable {
        private enum EnvironmentKey {
            static let apiKey = "EXOSCALE_API_KEY"
            static let apiSecret = "EXOSCALE_API_SECRET"
            static let userAgent = "EXOSCALE_USER_AGENT"
            static let zone = "EXOSCALE_ZONE"
        }

        public enum Error: Swift.Error, Equatable, LocalizedError {
            case missingAPIKey
            case missingAPISecret
            case invalidZone(String)

            public var errorDescription: String? {
                switch self {
                case .missingAPIKey:
                    "Exoscale API key is required."
                case .missingAPISecret:
                    "Exoscale API secret is required."
                case .invalidZone(let value):
                    "Exoscale zone '\(value)' is invalid."
                }
            }
        }

        public static let fallbackZone: Exoscale.KnownZone = .chGva2
        public static let fallbackUserAgent = "exoscale-swift"

        public let apiKey: String
        public let apiSecret: String
        public let userAgent: String
        public let zone: Exoscale.KnownZone

        /// The Exoscale API base URL for the configured zone.
        public var apiEndpoint: URL {
            zone.apiEndpoint
        }

        /// The Exoscale SOS object storage base URL for the configured zone.
        public var sosEndpoint: URL {
            zone.sosEndpoint
        }

        public init(
            apiKey: String? = nil,
            apiSecret: String? = nil,
            zone: Exoscale.KnownZone? = nil,
            userAgent: String? = nil,
            environment: [String: String] = ProcessInfo.processInfo.environment
        ) throws {
            let resolved = try Self.validate(
                apiKey: apiKey,
                apiSecret: apiSecret,
                zone: zone,
                userAgent: userAgent,
                environment: environment
            )

            self.apiKey = resolved.apiKey
            self.apiSecret = resolved.apiSecret
            self.userAgent = resolved.userAgent
            self.zone = resolved.zone
        }

        private static func validate(
            apiKey: String?,
            apiSecret: String?,
            zone: Exoscale.KnownZone?,
            userAgent: String?,
            environment: [String: String]
        ) throws -> (
            apiKey: String,
            apiSecret: String,
            userAgent: String,
            zone: Exoscale.KnownZone
        ) {
            let resolvedAPIKey = try resolveRequiredValue(
                explicit: apiKey,
                environment: environment[EnvironmentKey.apiKey],
                error: .missingAPIKey
            )
            let resolvedAPISecret = try resolveRequiredValue(
                explicit: apiSecret,
                environment: environment[EnvironmentKey.apiSecret],
                error: .missingAPISecret
            )
            let resolvedUserAgent =
                userAgent ?? environment[EnvironmentKey.userAgent] ?? Self.fallbackUserAgent
            let resolvedZone = try resolveZone(zone: zone, environment: environment)

            return (
                apiKey: resolvedAPIKey,
                apiSecret: resolvedAPISecret,
                userAgent: resolvedUserAgent,
                zone: resolvedZone
            )
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
            zone: Exoscale.KnownZone?,
            environment: [String: String]
        ) throws -> Exoscale.KnownZone {
            if let zone {
                return zone
            }

            if let zoneValue = environment[EnvironmentKey.zone] {
                guard let zone = Exoscale.KnownZone(rawValue: zoneValue) else {
                    throw Error.invalidZone(zoneValue)
                }

                return zone
            }

            return Self.fallbackZone
        }
    }
}
