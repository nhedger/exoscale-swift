import Foundation

public extension Exoscale {
    /// Creates a decoder for Exoscale JSON, including ISO 8601 response timestamps.
    /// Accepts timestamps with or without fractional seconds and with UTC or numeric offsets.
    static func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            if let date = (try? DateFormats.fractionalSeconds.parse(value))
                ?? (try? DateFormats.wholeSeconds.parse(value)) {
                return date
            }
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected an ISO 8601 timestamp, received \(value)"
            )
        }
        return decoder
    }

    /// Creates an encoder that writes dates as UTC ISO 8601 timestamps with fractional seconds.
    static func jsonEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(date.formatted(DateFormats.fractionalSeconds))
        }
        return encoder
    }
}

/// Timestamp formats shared by every decoder and encoder instead of being created per value.
private enum DateFormats {
    static let fractionalSeconds = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
    static let wholeSeconds = Date.ISO8601FormatStyle()
}
