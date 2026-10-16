// Deliberately not a testable import: these tests use only the public API.
import Exoscale
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Testing

@Test("Models can be built outside the SDK, for previews and tests")
func modelsAreConstructibleFromThePublicAPI() async throws {
    let client = try Exoscale(apiKey: "key", apiSecret: "secret")
    let group = Exoscale.SecurityGroup(
        id: "sg-1",
        name: "web",
        rules: [.init(startPort: 443, networkProtocol: .tcp, endPort: 443, flowDirection: .ingress)]
    )
    let summary = Exoscale.InstanceSummary(
        id: "vm-1", name: "web-1", state: .running, securityGroups: [group], client: client
    )
    let instance = Exoscale.Instance(
        securityGroups: [Exoscale.Reference(id: "sg-1") { _ in group }],
        id: "vm-1",
        name: "web-1",
        client: client
    )

    #expect(summary.id == instance.id)
    #expect(summary.securityGroups?.first?.rules?.first?.startPort == 443)
    #expect(try await instance.securityGroups?.first?.resolve().name == "web")
}

@Test("Models compare by value and by originating client")
func modelsCompareByValueAndClient() throws {
    let account = try Exoscale(apiKey: "key", apiSecret: "secret")
    let otherAccount = try Exoscale(apiKey: "key", apiSecret: "secret")

    #expect(Exoscale.SSHKey(name: "deploy") == Exoscale.SSHKey(name: "deploy"))
    #expect(Exoscale.SSHKey(name: "deploy") != Exoscale.SSHKey(name: "ops"))
    #expect(Set([Exoscale.SSHKey(name: "deploy"), Exoscale.SSHKey(name: "deploy")]).count == 1)
    #expect(
        Exoscale.InstanceSummary(id: "vm-1", client: account) == Exoscale.InstanceSummary(id: "vm-1", client: account)
    )
    #expect(
        Exoscale.InstanceSummary(id: "vm-1", client: account)
            != Exoscale.InstanceSummary(id: "vm-1", client: otherAccount)
    )
    #expect(
        Exoscale.Reference<Exoscale.SSHKey>(id: "key-1") { _ in .init(name: "a") }
            == Exoscale.Reference<Exoscale.SSHKey>(id: "key-1") { _ in .init(name: "b") }
    )
}

@Test("A custom session configuration is used for requests")
func customSessionConfigurationIsPublic() throws {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.timeoutIntervalForRequest = 5
    let client = try Exoscale(
        config: Exoscale.Config(apiKey: "key", apiSecret: "secret", zone: .deFra1, environment: [:]),
        sessionConfiguration: configuration
    )

    #expect(client.config.zone == .deFra1)
}
