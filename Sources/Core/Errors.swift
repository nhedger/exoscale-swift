import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public extension Exoscale {
    /// An unsuccessful response from the API.
    struct APIError: Error, Hashable, Sendable, LocalizedError {
        /// The HTTP status code, such as 404.
        public let statusCode: Int
        /// The explanation returned by the API, when there is one.
        public let message: String?
        /// How long the API asked to wait before sending the request again, for rate limiting
        /// (429) and temporary unavailability (503). Requests are never retried automatically.
        public let retryAfter: Duration?
        /// The raw response body.
        public let body: Data

        /// Creates an error, for example for previews and tests.
        public init(statusCode: Int, message: String? = nil, retryAfter: Duration? = nil, body: Data = Data()) {
            self.statusCode = statusCode
            self.message = message
            self.retryAfter = retryAfter
            self.body = body
        }

        /// A summary of the status, followed by the API's explanation.
        public var errorDescription: String? {
            let reason = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            let status = "The API returned HTTP \(statusCode) (\(reason))."
            return message.map { "\(status) \($0)" } ?? status
        }
    }

    /// A problem detected by the client rather than reported by the API.
    enum ClientError: Error, Hashable, Sendable, LocalizedError {
        /// The API key or secret is missing.
        case missingCredentials
        /// The zone can't be part of a hostname.
        case invalidZone(String)
        /// An identifier or name is empty, `.` or `..`, so no request was sent.
        case invalidPathComponent(String)
        /// The response isn't an HTTP response, or lacks something the SDK needs.
        case invalidResponse
        /// A successful response isn't JSON.
        case unexpectedContentType(String)

        /// A description of the problem.
        public var errorDescription: String? {
            switch self {
            case .missingCredentials:
                "An Exoscale API key and secret are required."
            case let .invalidZone(zone):
                "“\(zone)” isn't a valid Exoscale zone."
            case let .invalidPathComponent(value):
                "“\(value)” can't be used as an identifier or name."
            case .invalidResponse:
                "The API returned an invalid response."
            case let .unexpectedContentType(contentType):
                "Expected a JSON response, received \(contentType)."
            }
        }
    }
}

extension Exoscale.APIError {
    init(statusCode: Int, body: Data, retryAfterHeader: String?, now: Date = Date()) {
        self.init(
            statusCode: statusCode,
            message: Self.message(in: body),
            retryAfter: Self.retryAfter(header: retryAfterHeader, body: body, now: now),
            body: body
        )
    }

    /// The `message`, `detail` or `error` field of a JSON body, or a short plain-text body.
    static func message(in body: Data) -> String? {
        if let fields = try? JSONDecoder().decode(ErrorBody.self, from: body) {
            return [fields.message, fields.detail, fields.error].lazy.compactMap { $0.flatMap(nonEmpty) }.first
        }
        guard let text = String(data: body, encoding: .utf8).flatMap(nonEmpty),
              !["{", "[", "<"].contains(where: text.hasPrefix)
        else {
            return nil
        }
        return text
    }

    /// The wait from a `Retry-After` header, in seconds or as an HTTP date, or else from the
    /// `retry_after` field of a rate-limit body.
    static func retryAfter(header: String?, body: Data, now: Date) -> Duration? {
        if let header = header?.trimmingCharacters(in: .whitespaces) {
            if let seconds = Double(header) {
                return duration(seconds: seconds)
            }
            if let date = try? Date(header, strategy: httpDate) {
                return duration(seconds: max(0, date.timeIntervalSince(now)))
            }
        }
        return (try? JSONDecoder().decode(ErrorBody.self, from: body).retryAfter).flatMap(duration(seconds:))
    }

    private static func duration(seconds: Double?) -> Duration? {
        guard let seconds, seconds.isFinite, seconds >= 0 else {
            return nil
        }
        return .seconds(seconds)
    }

    private static func nonEmpty(_ text: String) -> String? {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    /// The HTTP date format, as in `Sun, 06 Nov 1994 08:49:37 GMT`.
    private static let httpDate = Date.ParseStrategy(
        format: """
        \(weekday: .abbreviated), \(day: .twoDigits) \(month: .abbreviated) \(year: .defaultDigits) \
        \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\
        \(minute: .twoDigits):\(second: .twoDigits) GMT
        """,
        locale: Locale(identifier: "en_US_POSIX"),
        timeZone: TimeZone(secondsFromGMT: 0)!
    )
}

/// The fields Exoscale uses to explain errors. Fields of another type are ignored.
private struct ErrorBody: Decodable {
    let message: String?
    let detail: String?
    let error: String?
    let retryAfter: Double?

    enum CodingKeys: String, CodingKey {
        case message, detail, error
        case retryAfter = "retry_after"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decodeIfPresent(String.self, forKey: .message)
        detail = try? container.decodeIfPresent(String.self, forKey: .detail)
        error = try? container.decodeIfPresent(String.self, forKey: .error)
        retryAfter = try? container.decodeIfPresent(Double.self, forKey: .retryAfter)
    }
}
