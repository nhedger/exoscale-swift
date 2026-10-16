import Foundation

extension Http {
    /// An API path whose interpolated values are percent-encoded as part of a single path segment.
    ///
    /// A `/`, `?` or `#` inside an identifier or name therefore can't change which endpoint is
    /// called, and an empty value, `.` or `..` is rejected before any request is sent.
    struct Path: ExpressibleByStringInterpolation, Sendable {
        /// The percent-encoded path appended to the API base URL.
        let percentEncoded: String
        /// The first interpolated value that can't be used in a path segment.
        let invalidValue: String?

        init(stringLiteral value: String) {
            percentEncoded = value
            invalidValue = nil
        }

        init(stringInterpolation: StringInterpolation) {
            percentEncoded = stringInterpolation.path
            invalidValue = stringInterpolation.invalidValue
        }

        /// Path characters allowed unescaped within a segment: `/` separates segments and `;` can
        /// introduce segment parameters.
        static let segmentCharacters: CharacterSet = {
            var characters = CharacterSet.urlPathAllowed
            characters.remove(charactersIn: "/;")
            return characters
        }()
    }
}

extension Http.Path {
    typealias StringInterpolation = HttpPathInterpolation
}

/// Builds an `Http.Path`, encoding each interpolated value as part of one path segment.
struct HttpPathInterpolation: StringInterpolationProtocol {
    private(set) var path = ""
    private(set) var invalidValue: String?

    init(literalCapacity: Int, interpolationCount _: Int) {
        path.reserveCapacity(literalCapacity)
    }

    mutating func appendLiteral(_ literal: String) {
        path += literal
    }

    mutating func appendInterpolation(_ value: String) {
        if invalidValue == nil, ["", ".", ".."].contains(value) {
            invalidValue = value
        }
        // Swift strings are always valid Unicode, so percent encoding cannot fail.
        path += value.addingPercentEncoding(withAllowedCharacters: Http.Path.segmentCharacters)!
    }

    mutating func appendInterpolation(_ value: some BinaryInteger) {
        path += String(value)
    }

    mutating func appendInterpolation<Value: RawRepresentable>(_ value: Value) where Value.RawValue == String {
        appendInterpolation(value.rawValue)
    }
}
