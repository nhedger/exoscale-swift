import Foundation

public extension Exoscale {
    /// An Exoscale zone identifier such as `ch-gva-2`, including zones added after this SDK version.
    ///
    /// The static members name the zones in `KnownZone`; write any other zone as a string literal.
    struct ZoneName: RawRepresentable, Hashable, Codable, Sendable, ExpressibleByStringLiteral,
        CustomStringConvertible {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }

        /// Creates the identifier of a zone this SDK version knows.
        public init(_ zone: KnownZone) {
            rawValue = zone.rawValue
        }

        /// The matching known zone, or `nil` for a zone this SDK version doesn't know.
        public var knownZone: KnownZone? {
            KnownZone(rawValue: rawValue)
        }

        public var description: String {
            rawValue
        }

        /// The API and SOS endpoints, or `nil` unless the identifier is lowercase letters and
        /// digits separated by hyphens.
        var endpoints: (api: URL, sos: URL)? {
            guard rawValue.wholeMatch(of: /[a-z0-9]+(-[a-z0-9]+)*/) != nil,
                  let api = URL(string: "https://api-\(rawValue).exoscale.com/v2"),
                  let sos = URL(string: "https://sos-\(rawValue).exo.io")
            else {
                return nil
            }
            return (api, sos)
        }
    }
}

public extension Exoscale.ZoneName {
    /// Vienna (`at-vie-1`).
    static let atVie1 = Self(.atVie1)
    /// Vienna (`at-vie-2`).
    static let atVie2 = Self(.atVie2)
    /// Sofia (`bg-sof-1`).
    static let bgSof1 = Self(.bgSof1)
    /// Zurich (`ch-dk-2`).
    static let chDk2 = Self(.chDk2)
    /// Geneva (`ch-gva-2`).
    static let chGva2 = Self(.chGva2)
    /// Frankfurt (`de-fra-1`).
    static let deFra1 = Self(.deFra1)
    /// Munich (`de-muc-1`).
    static let deMuc1 = Self(.deMuc1)
    /// Zagreb (`hr-zag-1`).
    static let hrZag1 = Self(.hrZag1)
}
