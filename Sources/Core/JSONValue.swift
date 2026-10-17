public extension Exoscale {
    /// A JSON value, for fields whose shape the API doesn't fix, such as DBaaS settings.
    ///
    /// Literals create values directly: `["max_connections": 200, "ssl": true]`.
    indirect enum JSONValue: Hashable, Sendable {
        /// A string.
        case string(String)
        /// A whole number.
        case integer(Int)
        /// A number with a fractional part.
        case double(Double)
        /// `true` or `false`.
        case bool(Bool)
        /// An array.
        case array([JSONValue])
        /// An object.
        case object([String: JSONValue])
        /// `null`.
        case null
    }
}

extension Exoscale.JSONValue: Codable {
    /// Decodes any JSON value.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Int.self) {
            self = .integer(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([String: Exoscale.JSONValue].self) {
            self = .object(value)
        } else {
            self = try .array(container.decode([Exoscale.JSONValue].self))
        }
    }

    /// Encodes the value as JSON.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .string(value): try container.encode(value)
        case let .integer(value): try container.encode(value)
        case let .double(value): try container.encode(value)
        case let .bool(value): try container.encode(value)
        case let .array(value): try container.encode(value)
        case let .object(value): try container.encode(value)
        case .null: try container.encodeNil()
        }
    }
}

extension Exoscale.JSONValue: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral,
    ExpressibleByBooleanLiteral, ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral, ExpressibleByNilLiteral {
    /// Creates a string.
    public init(stringLiteral value: String) {
        self = .string(value)
    }

    /// Creates a whole number.
    public init(integerLiteral value: Int) {
        self = .integer(value)
    }

    /// Creates a number with a fractional part.
    public init(floatLiteral value: Double) {
        self = .double(value)
    }

    /// Creates `true` or `false`.
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }

    /// Creates an array.
    public init(arrayLiteral elements: Exoscale.JSONValue...) {
        self = .array(elements)
    }

    /// Creates an object.
    public init(dictionaryLiteral elements: (String, Exoscale.JSONValue)...) {
        self = .object(Dictionary(elements) { _, last in last })
    }

    /// Creates `null`.
    public init(nilLiteral _: ()) {
        self = .null
    }
}
