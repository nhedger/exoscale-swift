public extension Exoscale {
    /// A string-backed API enumeration that keeps values added to the API after this SDK version.
    ///
    /// An unrecognized value decodes as `unknown(_:)` and encodes back unchanged, so a response
    /// never fails on a new value and a model sent back to the API doesn't lose it. `allCases`
    /// lists the cases this SDK version knows.
    protocol ExtensibleEnum: RawRepresentable, CaseIterable, Codable, Hashable, Sendable
        where RawValue == String, AllCases == [Self] {
        /// Wraps a value this SDK version doesn't know.
        static func unknown(_ rawValue: String) -> Self

        /// Creates the matching known case, or `unknown(_:)` for any other value.
        init(rawValue: String)
    }
}

public extension Exoscale.ExtensibleEnum {
    /// Creates the matching known case, or `unknown(_:)` for any other value.
    init(rawValue: String) {
        self = Self.allCases.first { $0.rawValue == rawValue } ?? .unknown(rawValue)
    }

    /// Decodes the raw string value, wrapping values this SDK version doesn't know.
    init(from decoder: any Decoder) throws {
        try self.init(rawValue: decoder.singleValueContainer().decode(String.self))
    }

    /// Encodes the raw string value, including values this SDK version doesn't know.
    func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    /// Values are equal when their raw values match, including `unknown(_:)` wrapping a known value.
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    /// Hashes the raw value, consistent with `==`.
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
