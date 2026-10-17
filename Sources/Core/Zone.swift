import Foundation

public extension Exoscale {
    /// An Exoscale zone, such as `ch-gva-2`.
    ///
    /// Zones added after this version of the SDK can be written as string literals.
    struct Zone: RawRepresentable, Hashable, Codable, Sendable, ExpressibleByStringLiteral,
        CustomStringConvertible {
        /// The zone's identifier.
        public let rawValue: String

        /// Creates a zone from its identifier.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Creates a zone from its identifier.
        public init(stringLiteral value: String) {
            rawValue = value
        }

        /// The zone's identifier.
        public var description: String {
            rawValue
        }

        /// The API base URL, or `nil` when the identifier can't be part of a hostname.
        var apiEndpoint: URL? {
            guard rawValue.wholeMatch(of: /[a-z0-9]+(-[a-z0-9]+)*/) != nil else {
                return nil
            }
            return URL(string: "https://api-\(rawValue).exoscale.com/v2")
        }

        /// Vienna 1.
        public static let atVie1: Zone = "at-vie-1"
        /// Vienna 2.
        public static let atVie2: Zone = "at-vie-2"
        /// Sofia.
        public static let bgSof1: Zone = "bg-sof-1"
        /// Zurich.
        public static let chDk2: Zone = "ch-dk-2"
        /// Geneva.
        public static let chGva2: Zone = "ch-gva-2"
        /// Frankfurt.
        public static let deFra1: Zone = "de-fra-1"
        /// Munich.
        public static let deMuc1: Zone = "de-muc-1"
        /// Madrid.
        public static let esMad1: Zone = "es-mad-1"
        /// Zagreb.
        public static let hrZag1: Zone = "hr-zag-1"
    }
}
