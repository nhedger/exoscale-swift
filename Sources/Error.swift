import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public extension Exoscale {
    enum ApiError: Swift.Error, Equatable, LocalizedError {
        case unauthorized(message: String?)
        case forbidden(message: String?)
        case forbiddenByPolicy(message: String?)
        /// HTTP 429: the API is limiting how often requests can be sent. The request was not
        /// processed and can be sent again after `retryAfter`, when the API gave a wait.
        case rateLimited(message: String?, retryAfter: Duration?)
        /// HTTP 503: the API is temporarily unavailable. The request can be sent again after
        /// `retryAfter`, when the API gave a wait.
        case serviceUnavailable(message: String?, retryAfter: Duration?)
        /// An unsuccessful HTTP response. The body is retained for API-specific details.
        case httpError(statusCode: Int, body: Data)
        /// The transport returned a response that is not HTTP.
        case invalidResponse
        /// A successful response explicitly advertised a non-JSON content type.
        case unexpectedContentType(String)
        /// An identifier or name was empty, `.` or `..`, so no request was sent.
        case invalidPathValue(String)

        /// The explanation returned by the API, when the response included one.
        public var message: String? {
            switch self {
            case let .unauthorized(message), let .forbidden(message), let .forbiddenByPolicy(message),
                 let .rateLimited(message, _), let .serviceUnavailable(message, _):
                message
            case let .httpError(_, body):
                Self.message(in: body)
            case .invalidResponse, .unexpectedContentType, .invalidPathValue:
                nil
            }
        }

        /// How long the API asked to wait before sending the request again, if it said.
        public var retryAfter: Duration? {
            switch self {
            case let .rateLimited(_, retryAfter), let .serviceUnavailable(_, retryAfter):
                retryAfter
            default:
                nil
            }
        }

        public var errorDescription: String? {
            let summary = switch self {
            case .unauthorized:
                "The request is missing valid authorization credentials."
            case .forbidden:
                "The request is forbidden for the provided credentials."
            case .forbiddenByPolicy:
                "The request is forbidden by role policy."
            case let .rateLimited(_, retryAfter):
                "Too many requests were sent to the API." + Self.retryHint(retryAfter)
            case let .serviceUnavailable(_, retryAfter):
                "The API is temporarily unavailable." + Self.retryHint(retryAfter)
            case let .httpError(statusCode, _):
                "The API returned HTTP \(statusCode) (\(HTTPURLResponse.localizedString(forStatusCode: statusCode)))."
            case .invalidResponse:
                "The API returned a non-HTTP response."
            case let .unexpectedContentType(contentType):
                "Expected a JSON response, received \(contentType)."
            case let .invalidPathValue(value):
                "“\(value)” can't be used as an identifier or name."
            }
            return message.map { "\(summary) \($0)" } ?? summary
        }

        private static func retryHint(_ retryAfter: Duration?) -> String {
            guard let retryAfter else {
                return ""
            }
            let (seconds, attoseconds) = retryAfter.components
            let wholeSeconds = seconds + (attoseconds > 0 ? 1 : 0)
            return wholeSeconds == 1 ? " Try again in 1 second." : " Try again in \(wholeSeconds) seconds."
        }

        /// The wait from a `Retry-After` header, given in seconds or as an HTTP date, or else from
        /// the `retry_after` field (in seconds) of a rate-limit error body.
        static func retryAfter(header: String?, body: Data?, now: Date = Date()) -> Duration? {
            if let header = header?.trimmingCharacters(in: .whitespaces) {
                if let seconds = Double(header) {
                    return duration(seconds: seconds)
                }
                if let date = try? Date(header, strategy: httpDate) {
                    return duration(seconds: max(0, date.timeIntervalSince(now)))
                }
            }
            guard let body, let seconds = try? JSONDecoder().decode(RateLimitedBody.self, from: body).retryAfter else {
                return nil
            }
            return duration(seconds: seconds)
        }

        /// The HTTP date format, as in `Sun, 06 Nov 1994 08:49:37 GMT`. Foundation's own `.http` style
        /// needs iOS and macOS 26.
        private static let httpDate = Date.ParseStrategy(
            format: """
            \(weekday: .abbreviated), \(day: .twoDigits) \(month: .abbreviated) \(year: .defaultDigits) \
            \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\
            \(minute: .twoDigits):\(second: .twoDigits) GMT
            """,
            locale: Locale(identifier: "en_US_POSIX"),
            timeZone: TimeZone(secondsFromGMT: 0)!
        )

        private static func duration(seconds: Double) -> Duration? {
            seconds.isFinite && seconds >= 0 ? .seconds(seconds) : nil
        }

        /// Extracts the explanation from a JSON error body, or a short plain-text body.
        static func message(in body: Data?) -> String? {
            guard let body, !body.isEmpty else {
                return nil
            }
            if let error = try? JSONDecoder().decode(APIErrorBody.self, from: body) {
                return [error.message, error.detail, error.error].lazy.compactMap { $0.flatMap(nonEmpty) }.first
            }
            guard let text = String(data: body, encoding: .utf8).flatMap(nonEmpty),
                  !["{", "[", "<"].contains(where: text.hasPrefix)
            else {
                return nil
            }
            return text
        }

        private static func nonEmpty(_ text: String) -> String? {
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty ? nil : trimmed
        }
    }
}

/// The JSON shapes of Exoscale API error responses. Most use `message`, environmental impact
/// endpoints use `detail`, and rate-limited endpoints use `error`.
private struct APIErrorBody: Decodable {
    let message: String?
    let detail: String?
    let error: String?

    enum CodingKeys: String, CodingKey {
        case message, detail, error
    }

    /// Fields of another type are ignored rather than hiding the ones that are strings.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decodeIfPresent(String.self, forKey: .message)
        detail = try? container.decodeIfPresent(String.self, forKey: .detail)
        error = try? container.decodeIfPresent(String.self, forKey: .error)
    }
}

/// The JSON body of a 429 response from endpoints that document their rate limit.
private struct RateLimitedBody: Decodable {
    let retryAfter: Double?

    enum CodingKeys: String, CodingKey {
        case retryAfter = "retry_after"
    }
}
