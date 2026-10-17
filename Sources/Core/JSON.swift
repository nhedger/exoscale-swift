import Foundation

enum JSON {
    /// Decodes Exoscale JSON, whose timestamps are ISO 8601 with or without fractional seconds.
    static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            guard let date = (try? fractionalSeconds.parse(value)) ?? (try? wholeSeconds.parse(value)) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Expected an ISO 8601 timestamp, received \(value)"
                )
            }
            return date
        }
        return decoder
    }

    /// Encodes request bodies, writing dates as UTC ISO 8601 timestamps and keys in a stable order.
    static func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(date.formatted(fractionalSeconds))
        }
        return encoder
    }

    private static let fractionalSeconds = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
    private static let wholeSeconds = Date.ISO8601FormatStyle()
}

/// A request body written as a dictionary literal, whose `nil` values are left out.
///
/// ```swift
/// body: ["name": name, "labels": labels]
/// ```
struct JSONBody: Encodable, Sendable, ExpressibleByDictionaryLiteral {
    private let fields: [(key: String, value: any Encodable & Sendable)]

    init(dictionaryLiteral elements: (String, (any Encodable & Sendable)?)...) {
        fields = elements.compactMap { key, value in value.map { (key, $0) } }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AnyKey.self)
        for field in fields {
            try container.encode(field.value, forKey: AnyKey(field.key))
        }
    }
}

/// A coding key for keys known only at runtime.
struct AnyKey: CodingKey {
    let stringValue: String
    var intValue: Int? {
        nil
    }

    init(_ key: String) {
        stringValue = key
    }

    init(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue _: Int) {
        nil
    }
}

/// Decodes the value under one key of a JSON object, such as the list in `{"instances": [...]}`.
struct Unwrapped<Value: Decodable>: Decodable {
    static var keyInfo: CodingUserInfoKey {
        CodingUserInfoKey(rawValue: "exoscale.unwrapped-key")!
    }

    let value: Value?

    init(from decoder: Decoder) throws {
        guard let key = decoder.userInfo[Self.keyInfo] as? String else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Missing key to unwrap"))
        }
        value = try decoder.container(keyedBy: AnyKey.self).decodeIfPresent(Value.self, forKey: AnyKey(key))
    }
}
