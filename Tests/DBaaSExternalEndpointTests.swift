@testable import Exoscale
import Foundation
import Testing

@Test("External endpoint calls send the expected requests", arguments: [
    Call("list", "GET /dbaas-external-endpoints", response: "{}") { _ = try await $0.dbaas.externalEndpoints.list() },
    Call("types", "GET /dbaas-external-endpoint-types", response: "{}") {
        _ = try await $0.dbaas.externalEndpoints.types()
    },
    Call("get", "GET /dbaas-external-endpoint-datadog/e-1", response: #"{"id":"e-1"}"#) {
        _ = try await $0.dbaas.externalEndpoints.get(id: "e-1", type: .datadog)
    },
    Call(
        "create",
        "POST /dbaas-external-endpoint-datadog/dd",
        body: #"{"settings":{"datadog-api-key":"key","datadog-tags":[{"tag":"env:prod"}],"site":"datadoghq.eu"}}"#
    ) {
        _ = try await $0.dbaas.externalEndpoints.create(
            name: "dd",
            type: .datadog,
            settings: .datadog(apiKey: "key", site: "datadoghq.eu", tags: [.init(tag: "env:prod")])
        )
    },
    Call(
        "update",
        "PUT /dbaas-external-endpoint-rsyslog/e-2",
        body: #"{"settings":{"format":"rfc5424","port":514,"server":"logs.example.com","tls":true}}"#
    ) {
        _ = try await $0.dbaas.externalEndpoints.update(
            id: "e-2",
            type: .rsyslog,
            settings: .rsyslog(server: "logs.example.com", port: 514, tls: true, format: "rfc5424")
        )
    },
    Call("delete", "DELETE /dbaas-external-endpoint-prometheus/e-3") {
        _ = try await $0.dbaas.externalEndpoints.delete(id: "e-3", type: .prometheus)
    },
    Call(
        "attach",
        "PUT /dbaas-external-endpoint/db-1/attach",
        body: #"{"dest-endpoint-id":"e-1","type":"datadog"}"#
    ) {
        _ = try await $0.dbaas.externalEndpoints.attach(service: "db-1", toEndpoint: "e-1", type: .datadog)
    },
    Call("detach", "PUT /dbaas-external-endpoint/db-1/detach", body: #"{"integration-id":"i-1"}"#) {
        _ = try await $0.dbaas.externalEndpoints.detach(service: "db-1", integrationID: "i-1")
    },
    Call("integrations", "GET /dbaas-external-integrations/db-1", response: "{}") {
        _ = try await $0.dbaas.externalEndpoints.integrations(of: "db-1")
    },
    Call("integration", "GET /dbaas-external-integration/i-1", response: "{}") {
        _ = try await $0.dbaas.externalEndpoints.integration(id: "i-1")
    },
    Call("Datadog settings", "GET /dbaas-external-integration-settings-datadog/i-1", response: "{}") {
        _ = try await $0.dbaas.externalEndpoints.datadogSettings(integrationID: "i-1")
    },
    Call(
        "set Datadog settings",
        "POST /dbaas-external-integration-settings-datadog/i-1",
        body: #"{"settings":{"datadog-dbm-enabled":true}}"#
    ) {
        _ = try await $0.dbaas.externalEndpoints.setDatadogSettings(
            .init(databaseMonitoringEnabled: true),
            integrationID: "i-1"
        )
    }
])
func externalEndpointCalls(_ call: Call) async throws {
    try await check(call)
}
