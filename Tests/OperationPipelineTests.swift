@testable import Exoscale
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Testing

private struct PipelineReply: Sendable {
    var body: String
    var status: Int = 200
    var contentType: String = "application/json"
}

private final class PipelineScenario: @unchecked Sendable {
    let respond: @Sendable (URLRequest, Int) throws -> PipelineReply?
    let events = AsyncStream<String>.makeStream()
    private let lock = NSLock()
    private var recorded: [URLRequest] = []

    init(respond: @escaping @Sendable (URLRequest, Int) throws -> PipelineReply?) {
        self.respond = respond
    }

    var requests: [URLRequest] {
        lock.withLock { recorded }
    }

    func record(_ request: URLRequest) -> Int {
        lock.withLock {
            recorded.append(request)
            return recorded.count
        }
    }
}

private final class PipelineRegistry: @unchecked Sendable {
    private let lock = NSLock()
    private var scenarios: [String: PipelineScenario] = [:]

    subscript(id: String) -> PipelineScenario? {
        get { lock.withLock { scenarios[id] } }
        set { lock.withLock { scenarios[id] = newValue } }
    }
}

private final class PipelineProtocol: URLProtocol {
    static let registry = PipelineRegistry()

    override static func canInit(with _: URLRequest) -> Bool {
        true
    }

    override static func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        do {
            let id = try #require(request.value(forHTTPHeaderField: "User-Agent"))
            let scenario = try #require(Self.registry[id])
            let count = scenario.record(request)
            scenario.events.continuation.yield("started")
            guard let reply = try scenario.respond(request, count) else { return }
            let url = try #require(request.url)
            let response = try #require(HTTPURLResponse(
                url: url,
                statusCode: reply.status,
                httpVersion: nil,
                headerFields: ["Content-Type": reply.contentType]
            ))
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: Data(reply.body.utf8))
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
        guard let id = request.value(forHTTPHeaderField: "User-Agent") else { return }
        Self.registry[id]?.events.continuation.yield("stopped")
    }
}

private final class PipelineFixture: Sendable {
    let id = UUID().uuidString
    let exoscale: Exoscale
    let scenario: PipelineScenario

    var http: Http.Client {
        exoscale.http
    }

    init(
        zone: Exoscale.ZoneName = .deFra1,
        respond: @escaping @Sendable (URLRequest, Int) throws -> PipelineReply?
    ) throws {
        scenario = PipelineScenario(respond: respond)
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [PipelineProtocol.self]
        exoscale = try Exoscale(
            config: Exoscale.Config(apiKey: id, apiSecret: "secret", zone: zone, userAgent: id),
            sessionConfiguration: configuration
        )
        PipelineProtocol.registry[id] = scenario
    }

    deinit {
        PipelineProtocol.registry[id] = nil
        scenario.events.continuation.finish()
    }
}

private func pipelineBody(_ request: URLRequest) throws -> [String: Any] {
    let data: Data
    if let body = request.httpBody {
        data = body
    } else {
        let stream = try #require(request.httpBodyStream)
        stream.open()
        defer { stream.close() }
        var result = Data()
        var buffer = [UInt8](repeating: 0, count: 1024)
        while true {
            let count = stream.read(&buffer, maxLength: buffer.count)
            if count == 0 {
                break
            }
            guard count > 0 else { throw stream.streamError ?? URLError(.cannotDecodeRawData) }
            result.append(contentsOf: buffer.prefix(count))
        }
        data = result
    }
    return try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
}

private func makeInstanceModelFixture() throws -> PipelineFixture {
    try PipelineFixture { request, _ in
        #expect(request.value(forHTTPHeaderField: "Authorization")?.hasPrefix("EXO2-HMAC-SHA256 ") == true)
        switch request.url?.path {
        case "/v2/instance":
            let url = try #require(request.url)
            let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
            let query = Dictionary(uniqueKeysWithValues: (components.queryItems ?? []).map { ($0.name, $0.value) })
            #expect(query["manager-id"] == "pool-1")
            #expect(query["manager-type"] == "instance-pool")
            #expect(query["ip-address"] == "203.0.113.1")
            #expect(query["labels"] == "env:prod,tier:web")
            return PipelineReply(
                body: #"""
                {"instances":[{"id":"vm-1","name":"summary","state":"running",
                 "created-at":"2026-09-19T12:00:00Z","instance-type":{"id":"type-1","cpus":2},
                 "security-groups":[{"id":"sg-1","name":"web"}]}]}
                """#
            )
        case "/v2/instance/vm-1":
            return PipelineReply(
                body: #"""
                {"id":"vm-1","name":"detail","state":"running","disk-size":50,"user-data":"aGVsbG8=",
                 "application-consistent-snapshot-enabled":true,"secureboot-enabled":true,"tpm-enabled":true,
                 "instance-type":{"id":"type-1"},"security-groups":[{"id":"sg-1"}],
                 "anti-affinity-groups":[{"id":"ag-1"}],"elastic-ips":[{"id":"ip-1"}],
                 "deploy-target":{"id":"target-1"},"snapshots":[{"id":"snapshot-1"}]}
                """#
            )
        case "/v2/security-group/sg-1":
            return PipelineReply(body: #"{"id":"sg-1","name":"resolved"}"#)
        case "/v2/instance-type/type-1":
            return PipelineReply(body: #"{"id":"type-1","family":"standard","size":"medium","cpus":2,"memory":4096}"#)
        case "/v2/anti-affinity-group/ag-1", "/v2/elastic-ip/ip-1", "/v2/deploy-target/target-1",
             "/v2/snapshot/snapshot-1":
            return PipelineReply(body: "{}")
        default:
            Issue.record("Unexpected path: \(request.url?.path ?? "nil")")
            return PipelineReply(body: "{}", status: 404)
        }
    }
}

@Test("Instance summaries resolve into full, client-bound models without eager reference requests")
func instanceModelPipeline() async throws {
    let fixture = try makeInstanceModelFixture()
    let summaries: [Exoscale.InstanceSummary] = try await fixture.exoscale.instances.list(
        managerId: "pool-1", managerType: "instance-pool", ipAddress: "203.0.113.1", labels: [
            "tier": "web",
            "env": "prod"
        ]
    )
    let summary = try #require(summaries.first)
    #expect(summary.name == "summary")
    #expect(summary.createdAt == Date(timeIntervalSince1970: 1_789_819_200))
    #expect(summary.instanceType?.cpus == 2)
    #expect(summary.securityGroups?.first?.name == "web")
    #expect(fixture.scenario.requests.count == 1)

    let instance = try await summary.resolve()
    #expect(instance.name == "detail")
    #expect(instance.diskSize == 50)
    #expect(instance.userData == "aGVsbG8=")
    #expect(instance.applicationConsistentSnapshotEnabled == true)
    #expect(instance.secureBootEnabled == true)
    #expect(instance.tpmEnabled == true)
    #expect(instance.instanceType?.id == "type-1")
    #expect(instance.securityGroups?.first?.id == "sg-1")
    #expect(fixture.scenario.requests.count == 2)

    let reference = try #require(instance.securityGroups?.first)
    let group = try await reference.resolve()
    #expect(group.name == "resolved")
    _ = try await reference.resolve()
    #expect(fixture.scenario.requests.count == 4)
    let instanceType = try await instance.instanceType?.resolve()
    #expect(instanceType?.family == .standard)
    _ = try await instance.antiAffinityGroups?.first?.resolve()
    _ = try await instance.elasticIPs?.first?.resolve()
    _ = try await instance.deployTarget?.resolve()
    _ = try await instance.snapshots?.first?.resolve()
    #expect(fixture.scenario.requests.count == 9)
    #expect(fixture.scenario.requests.allSatisfy { $0.url?.host == "api-de-fra-1.exoscale.com" })
    #expect(summary.name == "summary")
}

@Test("Instance actions and operation polling retain the originating account and zone")
func instanceActionsRetainClient() async throws {
    for zone in [Exoscale.ZoneName.chGva2, .deFra1] {
        let fixture = try PipelineFixture(zone: zone) { request, count in
            switch request.url?.path {
            case "/v2/instance/vm-1":
                return PipelineReply(body: "{\"id\":\"vm-1\",\"name\":\"snapshot-\(count)\"}")
            case "/v2/instance/vm-1:stop":
                #expect(request.httpMethod == "PUT")
                return PipelineReply(body: #"{"id":"op-1","state":"pending"}"#)
            case "/v2/operation/op-1":
                #expect(request.httpMethod == "GET")
                return PipelineReply(body: #"{"id":"op-1","state":"success"}"#)
            default:
                Issue.record("Unexpected action path")
                return PipelineReply(body: "{}", status: 404)
            }
        }
        let instance = try await fixture.exoscale.instances.get(id: "vm-1")
        let refreshed = try await instance.refresh()
        #expect(instance.name == "snapshot-1")
        #expect(refreshed.name == "snapshot-2")
        let pending = try await instance.stop()
        let completed = try await pending.wait(fetchInterval: .zero)
        #expect(pending.state == .pending)
        #expect(completed.state == .success)
        _ = try await completed.wait()
        #expect(fixture.scenario.requests.count == 5)
        for request in fixture.scenario.requests {
            #expect(request.url?.host == fixture.http.baseURL.host)
            #expect(request.value(forHTTPHeaderField: "Authorization")?.contains(fixture.id) == true)
        }
    }
}

@Test("Create operations encode request bodies and return pollable models")
func createInstancePipeline() async throws {
    let fixture = try PipelineFixture { request, _ in
        if request.url?.path == "/v2/instance" {
            #expect(request.httpMethod == "POST")
            #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
            let body = try pipelineBody(request)
            #expect(body["disk-size"] as? Int == 50)
            #expect((body["instance-type"] as? [String: String])?["id"] == "type-1")
            #expect((body["template"] as? [String: String])?["id"] == "template-1")
            #expect((body["security-groups"] as? [[String: String]])?.first?["id"] == "sg-1")
            #expect(body["auto-start"] as? Bool == false)
            #expect(body["user-data"] == nil)
            return PipelineReply(body: #"{"id":"create-1","state":"pending"}"#)
        }
        #expect(request.url?.path == "/v2/operation/create-1")
        return PipelineReply(body: #"{"id":"create-1","state":"success"}"#)
    }
    let operation = try await fixture.exoscale.instances.create(
        diskSize: 50, instanceTypeID: "type-1", templateID: "template-1", autoStart: false, securityGroupIDs: ["sg-1"]
    )
    #expect(try await operation.wait().state == .success)
    #expect(fixture.scenario.requests.count == 2)
}

@Test("Full instances tolerate omitted references and an instance type without an identifier")
func omittedInstanceReferences() async throws {
    let fixture = try PipelineFixture { _, _ in
        PipelineReply(body: #"{"id":"vm-1","name":"sparse","instance-type":{"size":"future-size"}}"#)
    }
    let instance = try await fixture.exoscale.instances.get(id: "vm-1")
    #expect(instance.instanceType == nil)
    #expect(instance.securityGroups == nil)
    #expect(instance.deployTarget == nil)
    #expect(fixture.scenario.requests.count == 1)
}

@Test("Operation execution propagates transport and payload decoding failures")
func operationPipelineErrors() async throws {
    let unauthorized = try PipelineFixture { _, _ in PipelineReply(body: "{}", status: 401) }
    await #expect(throws: Exoscale.ApiError.unauthorized(message: nil)) {
        try await unauthorized.exoscale.instances.list()
    }
    let invalid = try PipelineFixture { _, _ in PipelineReply(body: #"{"instances":[{"name":"missing-id"}]}"#) }
    await #expect(throws: DecodingError.self) {
        try await invalid.exoscale.instances.list()
    }
}

@Test("Operation models propagate API failure and API timeout states", arguments: ["failure", "timeout"])
func operationModelFailure(state: String) async throws {
    let fixture = try PipelineFixture { _, _ in
        PipelineReply(body: "{\"id\":\"op-1\",\"state\":\"\(state)\",\"reason\":\"busy\",\"message\":\"retry later\"}")
    }
    let operation = try await fixture.exoscale.operations.get(id: "op-1")
    do {
        _ = try await operation.wait()
        Issue.record("Expected an operation failure")
    } catch let error as OperationsResource.WaitError {
        guard case let .operationFailed(failed) = error else {
            Issue.record("Unexpected wait error: \(error)")
            return
        }
        #expect(failed.state?.rawValue == state)
        #expect(failed.reason == .busy)
        #expect(failed.message == "retry later")
    }
    #expect(fixture.scenario.requests.count == 2)
}

@Test(
    "Operation polling stops at its local deadline when a request never answers",
    .timeLimit(.minutes(1)),
    // A tiny deadline usually passes before URLSession hands the request to the stub, and a longer
    // one after it: either way, polling must time out without leaving the request running.
    arguments: [Duration.nanoseconds(1), .milliseconds(200)]
)
func operationPollingDeadline(timeout: Duration) async throws {
    let fixture = try PipelineFixture { _, _ in nil }
    do {
        _ = try await fixture.exoscale.operations.wait(id: "op-1", timeout: timeout)
        Issue.record("Expected local timeout")
    } catch let error as OperationsResource.WaitError {
        guard case let .timedOut(id) = error else {
            Issue.record("Unexpected wait error: \(error)")
            return
        }
        #expect(id == "op-1")
    }
    // Whether the request reached the stub before the deadline depends on scheduling. If it did,
    // the deadline must have stopped it, otherwise this waits until the time limit.
    let requests = fixture.scenario.requests.count
    #expect(requests <= 1)
    if requests == 1 {
        var events = fixture.scenario.events.stream.makeAsyncIterator()
        #expect(await events.next() == "started")
        #expect(await events.next() == "stopped")
    }
}

@Test("Cancelling operation polling cancels its active request", .timeLimit(.minutes(1)))
func operationPollingCancellation() async throws {
    let fixture = try PipelineFixture { _, _ in nil }
    let task = Task { try await fixture.exoscale.operations.wait(id: "op-1") }
    var events = fixture.scenario.events.stream.makeAsyncIterator()
    #expect(await events.next() == "started")
    task.cancel()
    do {
        _ = try await task.value
        Issue.record("Expected cancellation")
    } catch let error as URLError {
        #expect(error.code == .cancelled)
    } catch is CancellationError {
        // Either URLSession or the structured polling task may observe cancellation first.
    }
    #expect(await events.next() == "stopped")
}

@Test("Pre-cancelled model reference resolution never starts a request")
func referencePreCancellation() async throws {
    let fixture = try PipelineFixture { _, _ in
        PipelineReply(body: #"{"id":"vm-1","name":"detail","security-groups":[{"id":"sg-1"}]}"#)
    }
    let instance = try await fixture.exoscale.instances.get(id: "vm-1")
    let reference = try #require(instance.securityGroups?.first)
    let gate = AsyncStream<Void>.makeStream()
    let task = Task {
        for await _ in gate.stream {
            break
        }
        return try await reference.resolve()
    }
    task.cancel()
    gate.continuation.finish()
    await #expect(throws: CancellationError.self) { try await task.value }
    #expect(fixture.scenario.requests.count == 1)
}
