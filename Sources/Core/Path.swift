import Foundation

/// An API path whose interpolated values each stay within a single, percent-encoded segment.
///
/// A `/`, `?` or `#` inside an identifier or name therefore can't change which endpoint is called,
/// and an empty value, `.` or `..` is rejected before any request is sent.
struct Path: ExpressibleByStringInterpolation, Sendable {
    /// The percent-encoded path, relative to the API base URL.
    let encoded: String
    /// The first interpolated value that can't be used as a path segment.
    let invalidComponent: String?

    init(stringLiteral value: String) {
        encoded = value
        invalidComponent = nil
    }

    init(stringInterpolation: Interpolation) {
        encoded = stringInterpolation.encoded
        invalidComponent = stringInterpolation.invalidComponent
    }

    struct Interpolation: StringInterpolationProtocol {
        /// Characters left unescaped within a segment: `/` separates segments and `;` can start
        /// segment parameters, so both are escaped.
        private static let allowed: CharacterSet = {
            var characters = CharacterSet.urlPathAllowed
            characters.remove(charactersIn: "/;")
            return characters
        }()

        private(set) var encoded = ""
        private(set) var invalidComponent: String?

        init(literalCapacity: Int, interpolationCount _: Int) {
            encoded.reserveCapacity(literalCapacity)
        }

        mutating func appendLiteral(_ literal: String) {
            encoded += literal
        }

        mutating func appendInterpolation(_ value: String) {
            if invalidComponent == nil, ["", ".", ".."].contains(value) {
                invalidComponent = value
            }
            // Swift strings are valid Unicode, so percent-encoding can't fail.
            encoded += value.addingPercentEncoding(withAllowedCharacters: Self.allowed)!
        }

        mutating func appendInterpolation(_ value: some RawRepresentable<String>) {
            appendInterpolation(value.rawValue)
        }
    }
}
