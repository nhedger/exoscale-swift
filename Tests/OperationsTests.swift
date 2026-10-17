@testable import Exoscale
import Foundation
import Testing

@Test("Operations decode, including states added after this SDK version")
func operationDecoding() async throws {
    let stub = try Stub(json: """
    {"id":"op-1","state":"paused","reason":"busy","message":"Try later",
     "reference":{"id":"i-1","link":"/v2/instance/i-1","command":"create-instance"}}
    """)
    let operation = try await stub.exoscale.operations.get(id: "op-1")
    #expect(operation == Exoscale.Operation(
        id: "op-1",
        state: .init(rawValue: "paused"),
        reason: .busy,
        message: "Try later",
        reference: .init(id: "i-1", link: "/v2/instance/i-1", command: "create-instance")
    ))
    #expect(try stub.request.endpoint == "GET /operation/op-1")
}

@Test("Waiting polls until the operation succeeds")
func waitSucceeds() async throws {
    let stub = try Stub(
        StubResponse(body: #"{"id":"op-1","state":"pending"}"#),
        StubResponse(body: #"{"id":"op-1","state":"success","reference":{"id":"i-1"}}"#)
    )
    let operation = try await stub.exoscale.operations.wait(
        for: .init(id: "op-1", state: .pending),
        interval: .milliseconds(1)
    )
    #expect(operation.reference?.id == "i-1")
    #expect(stub.requests.count == 2)
}

@Test("Waiting throws when the operation fails")
func waitFails() async throws {
    let failed = #"{"id":"op-1","state":"failure","reason":"conflict","message":"In use"}"#
    let stub = try Stub(json: failed)
    await #expect(throws: Exoscale.OperationError.failed(.init(
        id: "op-1",
        state: .failure,
        reason: .conflict,
        message: "In use"
    ))) {
        try await stub.exoscale.operations.wait(for: .init(id: "op-1"), interval: .milliseconds(1))
    }
}

@Test("Waiting stops at its deadline")
func waitTimesOut() async throws {
    let stub = try Stub(json: #"{"id":"op-1","state":"pending"}"#)
    await #expect(throws: Exoscale.OperationError.timedOut("op-1")) {
        try await stub.exoscale.operations.wait(
            for: .init(id: "op-1"),
            timeout: .milliseconds(50),
            interval: .milliseconds(5)
        )
    }
}

@Test("Finished operations return or throw without a request")
func waitForFinishedOperations() async throws {
    let stub = try Stub(json: "{}")
    let done = Exoscale.Operation(id: "op-1", state: .success)
    #expect(try await stub.exoscale.operations.wait(for: done) == done)
    await #expect(throws: Exoscale.OperationError.failed(.init(id: "op-2", state: .timeout))) {
        try await stub.exoscale.operations.wait(for: .init(id: "op-2", state: .timeout))
    }
    await #expect(throws: Exoscale.OperationError.missingID) {
        try await stub.exoscale.operations.wait(for: .init(state: .pending))
    }
    #expect(stub.requests.isEmpty)
}

@Test("Operations returned by the API wait for themselves")
func operationWaitsForItself() async throws {
    let stub = try Stub(
        StubResponse(body: #"{"id":"op-1","state":"pending"}"#),
        StubResponse(body: #"{"id":"op-1","state":"pending"}"#),
        StubResponse(body: #"{"id":"op-1","state":"success","reference":{"id":"i-1"}}"#)
    )
    let operation = try await stub.exoscale.instances.start(id: "i-1")
    let done = try await operation.wait(interval: .milliseconds(1))
    #expect(done.reference?.id == "i-1")
    #expect(stub.requests.map(\.endpoint) == [
        "PUT /instance/i-1:start",
        "GET /operation/op-1",
        "GET /operation/op-1"
    ])
}

@Test("Operations created in code can't wait for themselves")
func detachedOperationCantWait() async throws {
    await #expect(throws: Exoscale.OperationError.detached) {
        try await Exoscale.Operation(id: "op-1", state: .pending).wait()
    }
}

@Test("Operations compare equal whichever client returned them")
func operationEqualityIgnoresClient() async throws {
    let stub = try Stub(json: #"{"id":"op-1","state":"pending"}"#)
    let returned = try await stub.exoscale.operations.get(id: "op-1")
    let created = Exoscale.Operation(id: "op-1", state: .pending)
    #expect(returned == created)
    #expect(Set([returned, created]).count == 1)
}
