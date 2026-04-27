public extension Exoscale {
    /// JSON value for API responses whose shape is not fixed by the schema.
    indirect enum JSONValue: Codable, Equatable, Sendable {
        case string(String)
        case integer(Int)
        case double(Double)
        case bool(Bool)
        case object([String: JSONValue])
        case array([JSONValue])
        case null

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
            } else if let value = try? container.decode([String: JSONValue].self) {
                self = .object(value)
            } else {
                self = .array(try container.decode([JSONValue].self))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()

            switch self {
            case let .string(value):
                try container.encode(value)
            case let .integer(value):
                try container.encode(value)
            case let .double(value):
                try container.encode(value)
            case let .bool(value):
                try container.encode(value)
            case let .object(value):
                try container.encode(value)
            case let .array(value):
                try container.encode(value)
            case .null:
                try container.encodeNil()
            }
        }
    }
}
