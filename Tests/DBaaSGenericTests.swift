@testable import Exoscale
import Foundation
import Testing

@Test("DBaaS generic request bodies encode (endpointData)")
func dbaasGenericRequestBodiesEncodeEndpointData() throws {
    let endpointData = try JSONEncoder().encode(
        DBaaSExternalEndpointSettingsBody(
            settings: [
                "url": .string("https://logs.example.com"),
                "index-prefix": .string("app")
            ]
        )
    )
    let endpointObject = try #require(JSONSerialization.jsonObject(with: endpointData) as? [String: Any])
    let endpointSettings = try #require(endpointObject["settings"] as? [String: Any])

    #expect(endpointSettings["url"] as? String == "https://logs.example.com")
    #expect(endpointSettings["index-prefix"] as? String == "app")
}

@Test("DBaaS generic request bodies encode (attachData)")
func dbaasGenericRequestBodiesEncodeAttachData() throws {
    let attachData = try JSONEncoder().encode(
        AttachDBaaSExternalEndpointBody(
            destinationEndpointID: "11111111-1111-1111-1111-111111111111",
            type: .datadog
        )
    )
    let attachObject = try #require(JSONSerialization.jsonObject(with: attachData) as? [String: Any])
    #expect(attachObject["dest-endpoint-id"] as? String == "11111111-1111-1111-1111-111111111111")
    #expect(attachObject["type"] as? String == "datadog")
}

@Test("DBaaS generic request bodies encode (datadogSettingsData)")
func dbaasGenericRequestBodiesEncodeDatadogSettingsData() throws {
    let datadogSettingsData = try JSONEncoder().encode(
        UpdateDBaaSDatadogSettingsBody(
            settings: .init(datadogDBMEnabled: true, datadogPGBouncerEnabled: false)
        )
    )
    let datadogSettingsObject = try #require(JSONSerialization.jsonObject(with: datadogSettingsData) as? [String: Any])
    let datadogSettings = try #require(datadogSettingsObject["settings"] as? [String: Any])
    #expect(datadogSettings["datadog-dbm-enabled"] as? Bool == true)
    #expect(datadogSettings["datadog-pgbouncer-enabled"] as? Bool == false)
}

@Test("DBaaS generic request bodies encode (integrationData)")
func dbaasGenericRequestBodiesEncodeIntegrationData() throws {
    let integrationData = try JSONEncoder().encode(
        CreateDBaaSIntegrationBody(
            integrationType: .metrics,
            sourceService: "source",
            destinationService: "dest",
            settings: ["dashboard": .string("main")]
        )
    )
    let integrationObject = try #require(JSONSerialization.jsonObject(with: integrationData) as? [String: Any])
    #expect(integrationObject["integration-type"] as? String == "metrics")
    #expect(integrationObject["source-service"] as? String == "source")
    #expect(integrationObject["dest-service"] as? String == "dest")
}

@Test("DBaaS generic request bodies encode (logsData)")
func dbaasGenericRequestBodiesEncodeLogsData() throws {
    let logsData = try JSONEncoder().encode(
        GetDBaaSServiceLogsBody(limit: 100, sortOrder: .descending, offset: "abc")
    )
    let logsObject = try #require(JSONSerialization.jsonObject(with: logsData) as? [String: Any])
    #expect(logsObject["limit"] as? Int == 100)
    #expect(logsObject["sort-order"] as? String == "desc")
}

@Test("DBaaS generic request bodies encode (metricsData)")
func dbaasGenericRequestBodiesEncodeMetricsData() throws {
    let metricsData = try JSONEncoder().encode(GetDBaaSServiceMetricsBody(period: .day))
    let metricsObject = try #require(JSONSerialization.jsonObject(with: metricsData) as? [String: String])
    #expect(metricsObject["period"] == "day")
}

@Test("DBaaS generic request bodies encode (migrationData)")
func dbaasGenericRequestBodiesEncodeMigrationData() throws {
    let migrationData = try JSONEncoder().encode(
        CheckDBaaSMigrationBody(
            sourceServiceURI: "mysql://user:pass@host/db",
            method: "dump",
            ignoredDatabases: "mysql"
        )
    )
    let migrationObject = try #require(JSONSerialization.jsonObject(with: migrationData) as? [String: Any])
    #expect(migrationObject["source-service-uri"] as? String == "mysql://user:pass@host/db")
    #expect(migrationObject["ignore-dbs"] as? String == "mysql")
}

@Test("DBaaS CA certificate responses decode")
func dbaasGenericResponsesDecodeCertificate() throws {
    let certificate = try JSONDecoder().decode(
        GetDBaaSCACertificateData.self, from: Data(#"{"certificate":"PEM"}"#.utf8)
    )

    #expect(certificate.certificate == "PEM")
}

@Test("DBaaS generic responses decode (services)")
func dbaasGenericResponsesDecodeServices() throws {
    let services = try Exoscale.jsonDecoder().decode(
        ListDBaaSServicesData.self,
        from: DBaaSGenericFixtures.services
    )
    #expect(services.dbaasServices.first?.name == "pg")
    #expect(services.dbaasServices.first?.terminationProtection == true)
}

@Test("DBaaS generic responses decode (serviceTypes)")
func dbaasGenericResponsesDecodeServiceTypes() throws {
    let serviceTypes = try JSONDecoder().decode(
        ListDBaaSServiceTypesData.self,
        from: DBaaSGenericFixtures.serviceTypes
    )
    #expect(serviceTypes.dbaasServiceTypes.first?.plans?.first?.zones == ["ch-gva-2"])
}

@Test("DBaaS generic responses decode (logs)")
func dbaasGenericResponsesDecodeLogs() throws {
    let logs = try JSONDecoder().decode(
        Exoscale.DBaaS.ServiceLogs.Payload.self,
        from: DBaaSGenericFixtures.logs
    )
    #expect(logs.logs?.first?.message == "ready")
}

@Test("DBaaS generic responses decode (metrics)")
func dbaasGenericResponsesDecodeMetrics() throws {
    let metrics = try JSONDecoder().decode(
        GetDBaaSServiceMetricsData.self,
        from: Data(#"{"metrics":{"cpu":{"usage":0.5}}}"#.utf8)
    )

    let integrationTypes = try JSONDecoder().decode(
        ListDBaaSIntegrationTypesData.self,
        from: DBaaSGenericFixtures.integrationTypes
    )
    #expect(metrics.metrics["cpu"] == .object(["usage": .double(0.5)]))
    #expect(integrationTypes.dbaasIntegrationTypes.first?.type == .metrics)
}

@Test("DBaaS generic responses decode (migration)")
func dbaasGenericResponsesDecodeMigration() throws {
    let migration = try JSONDecoder().decode(
        Exoscale.DBaaS.MigrationStatus.Payload.self,
        from: Data(#"{"method":"dump","status":"running","details":[{"dbname":"app","status":"syncing"}]}"#.utf8)
    )
    #expect(migration.details?.first?.databaseName == "app")
}

@Test("DBaaS generic responses decode (endpoints)")
func dbaasGenericResponsesDecodeEndpoints() throws {
    let endpoints = try JSONDecoder().decode(
        ListDBaaSExternalEndpointsData.self,
        from: DBaaSGenericFixtures.endpoints
    )
    #expect(endpoints.dbaasEndpoints.first?.type == .opensearch)
}

@Test("DBaaS generic responses decode (endpointTypes)")
func dbaasGenericResponsesDecodeEndpointTypes() throws {
    let endpointTypes = try JSONDecoder().decode(
        ListDBaaSExternalEndpointTypesData.self,
        from: Data(#"{"endpoint-types":[{"type":"datadog","service-types":["pg"],"title":"Datadog"}]}"#.utf8)
    )
    #expect(endpointTypes.endpointTypes.first?.type == .datadog)
}

@Test("DBaaS generic responses decode (externalIntegrations)")
func dbaasGenericResponsesDecodeExternalIntegrations() throws {
    let externalIntegrations = try JSONDecoder().decode(
        ListDBaaSExternalIntegrationsData.self,
        from: DBaaSGenericFixtures.externalIntegrations
    )
    #expect(externalIntegrations.externalIntegrations.first?.destinationEndpointName == "dd")
}

@Test("DBaaS generic responses decode (integrationSettings)")
func dbaasGenericResponsesDecodeIntegrationSettings() throws {
    let integrationSettings = try JSONDecoder().decode(
        GetDBaaSIntegrationSettingsData.self,
        from: Data(#"{"settings":{"type":"object","properties":{"foo":{"type":"string"}}}}"#.utf8)
    )
    #expect(integrationSettings.settings["type"] == .string("object"))
}

@Test("Client builds remaining DBaaS paths")
func clientBuildsRemainingDBaaSPaths() throws {
    let client = try Exoscale(apiKey: "key", apiSecret: "secret", zone: .chGva2)

    let certificate = try client.http.makeRequest("GET", path: "/dbaas-ca-certificate")
    let externalEndpoint = try client.http.makeRequest("PUT", path: "/dbaas-external-endpoint-datadog/endpoint-id")
    let attach = try client.http.makeRequest("PUT", path: "/dbaas-external-endpoint/source/attach")
    let detach = try client.http.makeRequest("PUT", path: "/dbaas-external-endpoint/source/detach")
    let externalIntegrations = try client.http.makeRequest("GET", path: "/dbaas-external-integrations/service")
    let datadogSettings = try client.http.makeRequest(
        "POST",
        path: "/dbaas-external-integration-settings-datadog/integration-id"
    )
    let integrationSettings = try client.http.makeRequest("GET", path: "/dbaas-integration-settings/metrics/pg/grafana")
    let integration = try client.http.makeRequest("DELETE", path: "/dbaas-integration/integration-id")
    let migrationStatus = try client.http.makeRequest("GET", path: "/dbaas-migration-status/service")
    let logs = try client.http.makeRequest("POST", path: "/dbaas-service-logs/service")
    let metrics = try client.http.makeRequest("POST", path: "/dbaas-service-metrics/service")
    let serviceType = try client.http.makeRequest("GET", path: "/dbaas-service-type/pg")
    let taskCheck = try client.http.makeRequest("POST", path: "/dbaas-task-migration-check/service")
    let task = try client.http.makeRequest("GET", path: "/dbaas-task/service/task-id")

    #expect(certificate.url?.path == "/v2/dbaas-ca-certificate")
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
