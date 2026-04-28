import Foundation
import Testing

@testable import Exoscale

@Test("DBaaS generic request bodies encode")
func dbaasGenericRequestBodiesEncode() throws {
    let endpointData = try JSONEncoder().encode(
        DBaaSExternalEndpointSettingsRequest(
            settings: [
                "url": .string("https://logs.example.com"),
                "index-prefix": .string("app"),
            ]
        )
    )
    let endpointObject = try #require(JSONSerialization.jsonObject(with: endpointData) as? [String: Any])
    let endpointSettings = try #require(endpointObject["settings"] as? [String: Any])

    let attachData = try JSONEncoder().encode(
        AttachDBaaSExternalEndpointRequest(
            destinationEndpointID: "11111111-1111-1111-1111-111111111111",
            type: .datadog
        )
    )
    let attachObject = try #require(JSONSerialization.jsonObject(with: attachData) as? [String: Any])

    let datadogSettingsData = try JSONEncoder().encode(
        UpdateDBaaSDatadogExternalIntegrationSettingsRequest(
            settings: .init(datadogDBMEnabled: true, datadogPGBouncerEnabled: false)
        )
    )
    let datadogSettingsObject = try #require(JSONSerialization.jsonObject(with: datadogSettingsData) as? [String: Any])
    let datadogSettings = try #require(datadogSettingsObject["settings"] as? [String: Any])

    let integrationData = try JSONEncoder().encode(
        CreateDBaaSIntegrationRequest(
            integrationType: .metrics,
            sourceService: "source",
            destinationService: "dest",
            settings: ["dashboard": .string("main")]
        )
    )
    let integrationObject = try #require(JSONSerialization.jsonObject(with: integrationData) as? [String: Any])

    let logsData = try JSONEncoder().encode(
        GetDBaaSServiceLogsRequest(limit: 100, sortOrder: .descending, offset: "abc")
    )
    let logsObject = try #require(JSONSerialization.jsonObject(with: logsData) as? [String: Any])

    let metricsData = try JSONEncoder().encode(GetDBaaSServiceMetricsRequest(period: .day))
    let metricsObject = try #require(JSONSerialization.jsonObject(with: metricsData) as? [String: String])

    let migrationData = try JSONEncoder().encode(
        CheckDBaaSMigrationRequest(sourceServiceURI: "mysql://user:pass@host/db", method: "dump", ignoredDatabases: "mysql")
    )
    let migrationObject = try #require(JSONSerialization.jsonObject(with: migrationData) as? [String: Any])

    #expect(endpointSettings["url"] as? String == "https://logs.example.com")
    #expect(endpointSettings["index-prefix"] as? String == "app")
    #expect(attachObject["dest-endpoint-id"] as? String == "11111111-1111-1111-1111-111111111111")
    #expect(attachObject["type"] as? String == "datadog")
    #expect(datadogSettings["datadog-dbm-enabled"] as? Bool == true)
    #expect(datadogSettings["datadog-pgbouncer-enabled"] as? Bool == false)
    #expect(integrationObject["integration-type"] as? String == "metrics")
    #expect(integrationObject["source-service"] as? String == "source")
    #expect(integrationObject["dest-service"] as? String == "dest")
    #expect(logsObject["limit"] as? Int == 100)
    #expect(logsObject["sort-order"] as? String == "desc")
    #expect(metricsObject["period"] == "day")
    #expect(migrationObject["source-service-uri"] as? String == "mysql://user:pass@host/db")
    #expect(migrationObject["ignore-dbs"] as? String == "mysql")
}

@Test("DBaaS generic responses decode")
func dbaasGenericResponsesDecode() throws {
    let ca = try JSONDecoder().decode(GetDBaaSCACertificateResponse.self, from: Data(#"{"certificate":"PEM"}"#.utf8))

    let services = try JSONDecoder().decode(
        ListDBaaSServicesResponse.self,
        from: Data(#"{"dbaas-services":[{"name":"pg","plan":"startup-4","type":"pg","state":"running","termination-protection":true}]}"#.utf8)
    )

    let serviceTypes = try JSONDecoder().decode(
        ListDBaaSServiceTypesResponse.self,
        from: Data(#"{"dbaas-service-types":[{"name":"pg","available-versions":["16"],"default-version":"16","plans":[{"name":"startup-4","node-count":2,"zones":["ch-gva-2"]}]}]}"#.utf8)
    )

    let logs = try JSONDecoder().decode(
        Exoscale.DBaaS.ServiceLogs.self,
        from: Data(#"{"offset":"2","first-log-offset":"1","logs":[{"unit":"pg","time":"2026-04-27T10:00:00Z","message":"ready","node":"pg-1"}]}"#.utf8)
    )

    let metrics = try JSONDecoder().decode(
        GetDBaaSServiceMetricsResponse.self,
        from: Data(#"{"metrics":{"cpu":{"usage":0.5}}}"#.utf8)
    )

    let migration = try JSONDecoder().decode(
        Exoscale.DBaaS.MigrationStatus.self,
        from: Data(#"{"method":"dump","status":"running","details":[{"dbname":"app","status":"syncing"}]}"#.utf8)
    )

    let endpoints = try JSONDecoder().decode(
        ListDBaaSExternalEndpointsResponse.self,
        from: Data(#"{"dbaas-endpoints":[{"name":"logs","type":"opensearch","id":"11111111-1111-1111-1111-111111111111"}]}"#.utf8)
    )

    let endpointTypes = try JSONDecoder().decode(
        ListDBaaSExternalEndpointTypesResponse.self,
        from: Data(#"{"endpoint-types":[{"type":"datadog","service-types":["pg"],"title":"Datadog"}]}"#.utf8)
    )

    let externalIntegrations = try JSONDecoder().decode(
        ListDBaaSExternalIntegrationsResponse.self,
        from: Data(#"{"external-integrations":[{"description":"metrics","dest-endpoint-name":"dd","dest-endpoint-id":"11111111-1111-1111-1111-111111111111","integration-id":"22222222-2222-2222-2222-222222222222","status":"active","source-service-name":"pg","source-service-type":"pg","type":"datadog"}]}"#.utf8)
    )

    let integrationTypes = try JSONDecoder().decode(
        ListDBaaSIntegrationTypesResponse.self,
        from: Data(#"{"dbaas-integration-types":[{"type":"metrics","source-service-types":["pg"],"dest-service-types":["grafana"],"settings":{"type":"object"}}]}"#.utf8)
    )

    let integrationSettings = try JSONDecoder().decode(
        GetDBaaSIntegrationSettingsResponse.self,
        from: Data(#"{"settings":{"type":"object","properties":{"foo":{"type":"string"}}}}"#.utf8)
    )

    #expect(ca.certificate == "PEM")
    #expect(services.dbaasServices.first?.name == "pg")
    #expect(services.dbaasServices.first?.terminationProtection == true)
    #expect(serviceTypes.dbaasServiceTypes.first?.plans?.first?.zones == ["ch-gva-2"])
    #expect(logs.logs?.first?.message == "ready")
    #expect(metrics.metrics["cpu"] == .object(["usage": .double(0.5)]))
    #expect(migration.details?.first?.databaseName == "app")
    #expect(endpoints.dbaasEndpoints.first?.type == .opensearch)
    #expect(endpointTypes.endpointTypes.first?.type == .datadog)
    #expect(externalIntegrations.externalIntegrations.first?.destinationEndpointName == "dd")
    #expect(integrationTypes.dbaasIntegrationTypes.first?.type == .metrics)
    #expect(integrationSettings.settings["type"] == .string("object"))
}

@Test("Client builds remaining DBaaS paths")
func clientBuildsRemainingDBaaSPaths() throws {
    let client = try Exoscale(apiKey: "key", apiSecret: "secret", zone: .chGva2)

    let ca = try client.http.makeRequest("GET", path: "/dbaas-ca-certificate")
    let externalEndpoint = try client.http.makeRequest("PUT", path: "/dbaas-external-endpoint-datadog/endpoint-id")
    let attach = try client.http.makeRequest("PUT", path: "/dbaas-external-endpoint/source/attach")
    let detach = try client.http.makeRequest("PUT", path: "/dbaas-external-endpoint/source/detach")
    let externalIntegrations = try client.http.makeRequest("GET", path: "/dbaas-external-integrations/service")
    let datadogSettings = try client.http.makeRequest("POST", path: "/dbaas-external-integration-settings-datadog/integration-id")
    let integrationSettings = try client.http.makeRequest("GET", path: "/dbaas-integration-settings/metrics/pg/grafana")
    let integration = try client.http.makeRequest("DELETE", path: "/dbaas-integration/integration-id")
    let migrationStatus = try client.http.makeRequest("GET", path: "/dbaas-migration-status/service")
    let logs = try client.http.makeRequest("POST", path: "/dbaas-service-logs/service")
    let metrics = try client.http.makeRequest("POST", path: "/dbaas-service-metrics/service")
    let serviceType = try client.http.makeRequest("GET", path: "/dbaas-service-type/pg")
    let taskCheck = try client.http.makeRequest("POST", path: "/dbaas-task-migration-check/service")
    let task = try client.http.makeRequest("GET", path: "/dbaas-task/service/task-id")

    #expect(ca.url?.path == "/v2/dbaas-ca-certificate")
    #expect(externalEndpoint.url?.path == "/v2/dbaas-external-endpoint-datadog/endpoint-id")
    #expect(attach.url?.path == "/v2/dbaas-external-endpoint/source/attach")
    #expect(detach.url?.path == "/v2/dbaas-external-endpoint/source/detach")
    #expect(externalIntegrations.url?.path == "/v2/dbaas-external-integrations/service")
    #expect(datadogSettings.url?.path == "/v2/dbaas-external-integration-settings-datadog/integration-id")
    #expect(integrationSettings.url?.path == "/v2/dbaas-integration-settings/metrics/pg/grafana")
    #expect(integration.url?.path == "/v2/dbaas-integration/integration-id")
    #expect(migrationStatus.url?.path == "/v2/dbaas-migration-status/service")
    #expect(logs.url?.path == "/v2/dbaas-service-logs/service")
    #expect(metrics.url?.path == "/v2/dbaas-service-metrics/service")
    #expect(serviceType.url?.path == "/v2/dbaas-service-type/pg")
    #expect(taskCheck.url?.path == "/v2/dbaas-task-migration-check/service")
    #expect(task.url?.path == "/v2/dbaas-task/service/task-id")
}
