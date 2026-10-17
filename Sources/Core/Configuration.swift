import Foundation

public extension Exoscale {
    /// Credentials, zone and request settings for a client.
    struct Configuration: Sendable {
        /// The `User-Agent` sent when none is configured.
        public static let defaultUserAgent = "exoscale-swift"

        /// The API key, such as `EXO…`.
        public var apiKey: String
        /// The API secret.
        public var apiSecret: String
        /// The zone requests are sent to.
        public var zone: Zone
        /// The `User-Agent` header sent with every request.
        public var userAgent: String

        /// Creates a configuration.
        public init(
            apiKey: String,
            apiSecret: String,
            zone: Zone = .chGva2,
            userAgent: String = Configuration.defaultUserAgent
        ) {
            self.apiKey = apiKey
            self.apiSecret = apiSecret
            self.zone = zone
            self.userAgent = userAgent
        }

        /// Reads a configuration from `EXOSCALE_API_KEY`, `EXOSCALE_API_SECRET`, and optionally
        /// `EXOSCALE_ZONE` and `EXOSCALE_USER_AGENT`.
        ///
        /// - Throws: ``ClientError/missingCredentials`` when the key or secret is missing or empty.
        public static func fromEnvironment(
            _ environment: [String: String] = ProcessInfo.processInfo.environment
        ) throws -> Configuration {
            func value(_ name: String) -> String? {
                environment[name].flatMap { $0.isEmpty ? nil : $0 }
            }
            guard let apiKey = value("EXOSCALE_API_KEY"), let apiSecret = value("EXOSCALE_API_SECRET") else {
                throw ClientError.missingCredentials
            }
            return Configuration(
                apiKey: apiKey,
                apiSecret: apiSecret,
                zone: value("EXOSCALE_ZONE").map(Zone.init(rawValue:)) ?? .chGva2,
                userAgent: value("EXOSCALE_USER_AGENT") ?? defaultUserAgent
            )
        }
    }
}

extension Exoscale.Configuration: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    /// Describes the configuration without its secret, so it is safe to log.
    public var description: String {
        "Configuration(apiKey: \(apiKey), apiSecret: <redacted>, zone: \(zone), userAgent: \(userAgent))"
    }

    /// The same as ``description``.
    public var debugDescription: String {
        description
    }

    /// Keeps the secret out of `dump` output and debugger summaries.
    public var customMirror: Mirror {
        Mirror(self, children: [
            "apiKey": apiKey,
            "apiSecret": "<redacted>",
            "zone": zone,
            "userAgent": userAgent
        ])
    }
}
