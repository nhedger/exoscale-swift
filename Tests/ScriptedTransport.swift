@testable import Exoscale
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// A response a `ScriptedTransport` sends back.
struct ScriptedResponse: Sendable {
    var statusCode = 200
    var headers = ["Content-Type": "application/json"]
    var body = Data("{}".utf8)
}

/// Answers a client's requests with scripted responses, in order, and records what was sent.
///
/// Each transport has its own User-Agent, so tests running in parallel never share responses.
final class ScriptedTransport: @unchecked Sendable {
    let id = UUID().uuidString
    private let lock = NSLock()
    private var responses: [ScriptedResponse]
    private var recorded: [URLRequest] = []

    init(_ responses: [ScriptedResponse]) {
        self.responses = responses
        Self.registry.withLock { $0[id] = self }
    }

    /// The requests received so far, with their bodies.
    var requests: [URLRequest] {
        lock.withLock { recorded }
    }

    private func config() throws -> Exoscale.Config {
        try Exoscale.Config(apiKey: "key", apiSecret: "secret", zone: .chGva2, userAgent: id)
    }

    private var sessionConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ScriptedURLProtocol.self]
        return configuration
    }

    /// A public client whose requests this transport answers.
    func exoscale() throws -> Exoscale {
        try Exoscale(config: config(), sessionConfiguration: sessionConfiguration)
    }

    fileprivate func respond(to request: URLRequest) -> ScriptedResponse? {
        lock.withLock {
            recorded.append(request)
            return responses.isEmpty ? nil : responses.removeFirst()
        }
    }

    fileprivate static let registry = Locked<[String: ScriptedTransport]>([:])
}

/// A value guarded by a lock.
final class Locked<Value>: @unchecked Sendable {
    private let lock = NSLock()
    private var value: Value

    init(_ value: Value) {
        self.value = value
    }

    func withLock<Result>(_ body: (inout Value) throws -> Result) rethrows -> Result {
        try lock.withLock { try body(&value) }
    }
}

private final class ScriptedURLProtocol: URLProtocol {
    override static func canInit(with _: URLRequest) -> Bool {
        true
    }

    override static func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let url = request.url,
              let id = request.value(forHTTPHeaderField: "User-Agent"),
              let transport = ScriptedTransport.registry.withLock({ $0[id] }),
              let scripted = transport.respond(to: requestWithBody()),
              let response = HTTPURLResponse(
                  url: url,
                  statusCode: scripted.statusCode,
                  httpVersion: nil,
                  headerFields: scripted.headers
              )
        else {
            client?.urlProtocol(self, didFailWithError: URLError(.unsupportedURL))
            return
        }
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: scripted.body)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}

    /// URLSession hands bodies to protocols as streams, so they are read back for inspection.
    private func requestWithBody() -> URLRequest {
        guard request.httpBody == nil, let stream = request.httpBodyStream else {
            return request
        }
        var body = Data()
        var buffer = [UInt8](repeating: 0, count: 4096)
        stream.open()
        defer { stream.close() }
        while case let count = stream.read(&buffer, maxLength: buffer.count), count > 0 {
            body.append(buffer, count: count)
        }
        var copy = request
        copy.httpBody = body
        return copy
    }
}
