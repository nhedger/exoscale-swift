@testable import Exoscale
import Foundation
import Testing

private let secret = Data("secret".utf8)
private let context = Data("ctx".utf8)

@Test("KMS key calls send the expected requests", arguments: [
    Call("list", "GET /kms-key", response: "{}") { _ = try await $0.kmsKeys.list() },
    Call("get", "GET /kms-key/k-1", response: #"{"id":"k-1"}"#) { _ = try await $0.kmsKeys.get(id: "k-1") },
    Call(
        "create",
        "POST /kms-key",
        body: #"{"key-spec":"ECC_NIST_P256","multi-zone":true,"name":"signer","usage":"sign-verify"}"#,
        response: #"{"id":"k-1"}"#
    ) {
        _ = try await $0.kmsKeys.create(name: "signer", usage: .signVerify, keySpec: .eccNISTP256, multiZone: true)
    },
    Call(
        "create external",
        "POST /kms-key",
        body: #"{"name":"ext","source":"external-key-store","xks":{"external-key-id":"x-1","xks-id":"ks-1"}}"#,
        response: #"{"id":"k-1"}"#
    ) {
        _ = try await $0.kmsKeys.create(
            name: "ext",
            source: .externalKeyStore,
            externalKey: .init(externalKeyID: "x-1", xksID: "ks-1")
        )
    },
    Call("enable", "POST /kms-key/k-1/enable") { try await $0.kmsKeys.enable(id: "k-1") },
    Call("disable", "POST /kms-key/k-1/disable") { try await $0.kmsKeys.disable(id: "k-1") },
    Call("replicate", "POST /kms-key/k-1/replicate", body: #"{"zone":"de-fra-1"}"#) {
        try await $0.kmsKeys.replicate(id: "k-1", to: .deFra1)
    },
    Call("rotate", "POST /kms-key/k-1/rotate", response: #"{"rotation":{"manual-count":1}}"#) {
        _ = try await $0.kmsKeys.rotate(id: "k-1")
    },
    Call(
        "enable rotation",
        "POST /kms-key/k-1/enable-key-rotation",
        body: #"{"rotation-period":90}"#,
        response: #"{"rotation":{"automatic":true}}"#
    ) {
        _ = try await $0.kmsKeys.enableRotation(id: "k-1", period: 90)
    },
    Call("disable rotation", "POST /kms-key/k-1/disable-key-rotation", response: #"{"rotation":{}}"#) {
        _ = try await $0.kmsKeys.disableRotation(id: "k-1")
    },
    Call("rotations", "GET /kms-key/k-1/list-key-rotations", response: "{}") {
        _ = try await $0.kmsKeys.rotations(id: "k-1")
    },
    Call("schedule deletion", "POST /kms-key/k-1/schedule-deletion", body: #"{"delay-days":7}"#) {
        _ = try await $0.kmsKeys.scheduleDeletion(id: "k-1", delayDays: 7)
    },
    Call("cancel deletion", "POST /kms-key/k-1/cancel-deletion") { try await $0.kmsKeys.cancelDeletion(id: "k-1") }
])
func kmsKeyCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Crypto calls send the expected requests", arguments: [
    Call(
        "encrypt",
        "POST /kms-key/k-1/encrypt",
        body: #"{"encryption-context":"Y3R4","plaintext":"c2VjcmV0"}"#,
        response: #"{"ciphertext":"AAEC","encryption-algorithm":"AES_256"}"#
    ) {
        _ = try await $0.crypto.encrypt(secret, with: "k-1", context: context)
    },
    Call(
        "decrypt",
        "POST /kms-key/k-1/decrypt",
        body: #"{"ciphertext":"AAEC","encryption-algorithm":"RSAES_OAEP_SHA_256"}"#,
        response: #"{"plaintext":"c2VjcmV0","encryption-algorithm":"RSAES_OAEP_SHA_256"}"#
    ) {
        _ = try await $0.crypto.decrypt(Data([0, 1, 2]), with: "k-1", algorithm: .rsaesOAEPSHA256)
    },
    Call(
        "re-encrypt",
        "POST /kms-key/k-1/re-encrypt",
        body: #"{"destination":{"encryption-context":"Y3R4","key":"k-2"},"source":{"ciphertext":"AAEC","key":"k-1"}}"#,
        response: #"{"ciphertext":"AwQF"}"#
    ) {
        _ = try await $0.crypto.reEncrypt(Data([0, 1, 2]), from: "k-1", to: "k-2", destinationContext: context)
    },
    Call(
        "generate data key",
        "POST /kms-key/k-1/generate-data-key",
        body: #"{"key-spec":"AES-256"}"#,
        response: #"{"plaintext":"c2VjcmV0","ciphertext":"AAEC"}"#
    ) {
        _ = try await $0.crypto.generateDataKey(with: "k-1", spec: .aes256)
    },
    Call(
        "sign",
        "POST /kms-key/k-1/sign",
        body: #"{"message":"c2VjcmV0","message-type":"raw","signing-algorithm":"ECDSA_SHA_256"}"#,
        response: #"{"signature":"AAEC"}"#
    ) {
        _ = try await $0.crypto.sign(secret, with: "k-1", algorithm: .ecdsaSHA256, messageType: .raw)
    },
    Call(
        "verify",
        "POST /kms-key/k-1/verify",
        body: #"{"message":"c2VjcmV0","signature":"AAEC","signing-algorithm":"EDDSA_ED25519"}"#,
        response: #"{"signature-valid":true}"#
    ) {
        _ = try await $0.crypto.verify(Data([0, 1, 2]), of: secret, with: "k-1", algorithm: .eddsaEd25519)
    },
    Call("public key", "GET /kms-key/k-1/get-public-key", response: "{}") {
        _ = try await $0.crypto.publicKey(of: "k-1")
    }
])
func cryptoCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Key store calls send the expected requests", arguments: [
    Call("list", "GET /key-store", response: "{}") { _ = try await $0.keyStores.list() },
    Call("get", "GET /key-store/ks-1", response: #"{"id":"ks-1"}"#) { _ = try await $0.keyStores.get(id: "ks-1") },
    Call(
        "create",
        "POST /key-store",
        body: #"{"name":"hsm","proxy":{"auth":{"key":"ak","secret":"sk"},"endpoint":"https://xks.example.com"},"#
            + #""type":"external-key-store"}"#,
        response: #"{"id":"ks-1"}"#
    ) {
        _ = try await $0.keyStores.create(
            name: "hsm",
            endpoint: "https://xks.example.com",
            credentials: .init(key: "ak", secret: "sk")
        )
    },
    Call("update", "POST /key-store/ks-1/update", body: #"{"description":"main"}"#, response: #"{"id":"ks-1"}"#) {
        _ = try await $0.keyStores.update(id: "ks-1", description: "main")
    },
    Call(
        "update proxy",
        "POST /key-store/ks-1/update",
        body: #"{"proxy":{"endpoint":"https://xks2.example.com"}}"#,
        response: #"{"id":"ks-1"}"#
    ) {
        _ = try await $0.keyStores.update(id: "ks-1", endpoint: "https://xks2.example.com")
    },
    Call("delete", "DELETE /key-store/ks-1") { try await $0.keyStores.delete(id: "ks-1") },
    Call("connect", "POST /key-store/ks-1/connect") { try await $0.keyStores.connect(id: "ks-1") },
    Call("disconnect", "POST /key-store/ks-1/disconnect") { try await $0.keyStores.disconnect(id: "ks-1") }
])
func keyStoreCalls(_ call: Call) async throws {
    try await check(call)
}

@Test("Crypto responses decode from base64")
func cryptoResponses() async throws {
    let ciphertext = try await Stub(json: #"{"ciphertext":"AAEC"}"#).exoscale.crypto.encrypt(secret, with: "k-1")
    #expect(ciphertext == Data([0, 1, 2]))

    let plaintext = try await Stub(json: #"{"plaintext":"c2VjcmV0"}"#).exoscale.crypto.decrypt(ciphertext, with: "k-1")
    #expect(plaintext == secret)

    let verification = try Stub(json: #"{"signature-valid":false,"key-id":"k-1"}"#)
    let valid = try await verification.exoscale.crypto.verify(Data(), of: secret, with: "k-1", algorithm: .ecdsaSHA256)
    #expect(!valid)
}

@Test("Data keys and key store credentials keep secrets out of descriptions")
func redactedKMSSecrets() {
    let dataKey = Exoscale.Crypto.DataKey(plaintext: secret, ciphertext: Data([0, 1, 2]))
    #expect(!"\(dataKey)".contains("secret"))
    #expect(!String(reflecting: dataKey).contains(secret.description))

    let credentials = Exoscale.KeyStore.Credentials(key: "ak", secret: "top-secret")
    var dumped = ""
    dump(credentials, to: &dumped)
    #expect(!"\(credentials)".contains("top-secret"))
    #expect(!dumped.contains("top-secret"))
}

@Test("KMS keys and key stores decode")
func decodeKMS() async throws {
    let key = try await decode(
        #"{"id":"k-1","name":"main","usage":"encrypt-decrypt","key-spec":"AES_256","source":"exoscale-kms","#
            + #""status":"pending-deletion","multi-zone":true,"origin-zone":"ch-gva-2","replicas":["de-fra-1"],"#
            + #""replicas-status":[{"zone":"de-fra-1","last-applied-watermark":3,"#
            + #""last-failure":{"attempted-watermark":4,"error":"timeout"}}],"#
            + #""rotation":{"manual-count":2,"automatic":true,"rotation-period":365},"#
            + #""material":{"version":3,"automatic":false},"revision":{"seq":7},"#
            + #""delete-at":"2026-01-02T03:04:05Z"}"#,
        from: "/kms-key/k-1"
    ) { try await $0.kmsKeys.get(id: "k-1") }
    #expect(key == .init(
        id: "k-1",
        name: "main",
        usage: .encryptDecrypt,
        keySpec: .aes256,
        source: .exoscaleKMS,
        status: .pendingDeletion,
        multiZone: true,
        originZone: "ch-gva-2",
        replicas: ["de-fra-1"],
        replicasStatus: [.init(
            zone: "de-fra-1",
            lastAppliedWatermark: 3,
            lastFailure: .init(attemptedWatermark: 4, error: "timeout")
        )],
        rotation: .init(automatic: true, rotationPeriod: 365, manualCount: 2),
        material: .init(version: 3, automatic: false),
        revision: .init(seq: 7),
        deleteAt: Date(timeIntervalSince1970: 1_767_323_045)
    ))

    let deletion = try Stub(json: #"{"delete-at":"2026-01-02T03:04:05Z"}"#)
    let deleteAt = try await deletion.exoscale.kmsKeys.scheduleDeletion(id: "k-1")
    #expect(deleteAt == Date(timeIntervalSince1970: 1_767_323_045))

    let stores = try await decode(
        #"{"key-stores":[{"id":"ks-1","type":"external-key-store","status":"connected","#
            + #""proxy":{"endpoint":"https://xks.example.com","auth":{"key":"ak"}},"#
            + #""health":{"status":"unhealthy","error-detail":"TLS"}},{"id":"ks-2","proxy":{"auth":null}}]}"#,
        from: "/key-store"
    ) { try await $0.keyStores.list() }
    #expect(stores == [
        .init(
            id: "ks-1",
            type: .externalKeyStore,
            status: .connected,
            proxy: .init(endpoint: "https://xks.example.com", accessKey: "ak"),
            health: .init(status: .unhealthy, errorDetail: "TLS")
        ),
        .init(id: "ks-2", proxy: .init())
    ])
}
