import Crypto
@testable import Exoscale
import Foundation
import Testing
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@Test("Signs requests as AWS's Signature Version 4 example does")
func signsLikeAWSExample() throws {
    // The GET Object example of the Signature Version 4 documentation for S3.
    let signer = S3Signer(
        accessKey: "AKIAIOSFODNN7EXAMPLE",
        secretKey: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        region: "us-east-1"
    )
    var request = try URLRequest(url: #require(URL(string: "https://examplebucket.s3.amazonaws.com/test.txt")))
    request.httpMethod = "GET"
    request.setValue("bytes=0-9", forHTTPHeaderField: "Range")

    let signed = signer.sign(request, now: Date(timeIntervalSince1970: 1_369_353_600))

    #expect(signed.value(forHTTPHeaderField: "x-amz-date") == "20130524T000000Z")
    #expect(signed.value(forHTTPHeaderField: "Authorization") == """
    AWS4-HMAC-SHA256 Credential=AKIAIOSFODNN7EXAMPLE/20130524/us-east-1/s3/aws4_request, \
    SignedHeaders=host;range;x-amz-content-sha256;x-amz-date, \
    Signature=f0e8bdb87c964420e857bd35b5d6ed310bd44f0170aba48dd91039c6036bdb41
    """)
}

@Test("Creates and deletes buckets through the zone's S3 endpoint")
func createsAndDeletesBuckets() async throws {
    let stub = try Stub(StubResponse(body: ""), StubResponse(statusCode: 204, body: ""))

    try await stub.exoscale.objectStorage.createBucket("assets")
    try await stub.exoscale.objectStorage.deleteBucket("assets")

    let requests = stub.requests
    #expect(requests.map(\.httpMethod) == ["PUT", "DELETE"])
    #expect(requests.map(\.url?.absoluteString) == [
        "https://sos-ch-gva-2.exo.io/assets",
        "https://sos-ch-gva-2.exo.io/assets"
    ])
    let authorization = try #require(requests.first?.value(forHTTPHeaderField: "Authorization"))
    #expect(authorization.hasPrefix("AWS4-HMAC-SHA256 Credential=EXOkey/"))
    #expect(authorization.contains("/ch-gva-2/s3/aws4_request"))
}

@Test("Reads S3 errors")
func readsS3Errors() async throws {
    let stub = try Stub(StubResponse(statusCode: 409, headers: ["Content-Type": "application/xml"], body: """
    <?xml version="1.0" encoding="UTF-8"?>
    <Error><Code>BucketNotEmpty</Code><Message>The bucket you tried to delete is not empty</Message><BucketName>assets</BucketName></Error>
    """))

    let error = await #expect(throws: Exoscale.S3Error.self) {
        try await stub.exoscale.objectStorage.deleteBucket("assets")
    }
    #expect(error?.statusCode == 409)
    #expect(error?.code == "BucketNotEmpty")
    #expect(error?.localizedDescription == "The bucket you tried to delete is not empty")
}

@Test("Refuses bucket names that aren't a single path segment")
func refusesInvalidBucketNames() async throws {
    let stub = try Stub()
    await #expect(throws: Exoscale.ClientError.invalidPathComponent("..")) {
        try await stub.exoscale.objectStorage.createBucket("..")
    }
    #expect(stub.requests.isEmpty)
}

@Test("Empties a bucket of every object version and delete marker, page by page")
func emptiesBuckets() async throws {
    let xml = ["Content-Type": "application/xml"]
    let stub = try Stub(
        StubResponse(headers: xml, body: """
        <ListVersionsResult><Name>assets</Name><IsTruncated>true</IsTruncated>
        <Version><Key>a &amp; b.txt</Key><VersionId>v1</VersionId></Version>
        <Version><Key>logo.png</Key><VersionId>null</VersionId></Version>
        </ListVersionsResult>
        """),
        StubResponse(headers: xml, body: "<DeleteResult></DeleteResult>"),
        StubResponse(headers: xml, body: """
        <ListVersionsResult><IsTruncated>false</IsTruncated>
        <DeleteMarker><Key>old.txt</Key><VersionId>m1</VersionId></DeleteMarker>
        </ListVersionsResult>
        """),
        StubResponse(headers: xml, body: "<DeleteResult></DeleteResult>")
    )

    let deleted = try await stub.exoscale.objectStorage.emptyBucket("assets")

    #expect(deleted == 3)
    let requests = stub.requests
    #expect(requests.map(\.httpMethod) == ["GET", "POST", "GET", "POST"])
    #expect(requests[0].url?.query == "max-keys=1000&versions=")
    #expect(requests[1].url?.query == "delete=")
    let body = try #require(requests[1].httpBody.map { String(decoding: $0, as: UTF8.self) })
    #expect(body == """
    <Delete><Quiet>true</Quiet><Object><Key>a &amp; b.txt</Key><VersionId>v1</VersionId></Object>\
    <Object><Key>logo.png</Key></Object></Delete>
    """)
    let md5 = Data(Insecure.MD5.hash(data: Data(body.utf8))).base64EncodedString()
    #expect(requests[1].value(forHTTPHeaderField: "Content-MD5") == md5)
    #expect(requests[1].value(forHTTPHeaderField: "Authorization")?.contains("content-md5") == true)
}

@Test("Reports objects that couldn't be deleted")
func reportsUndeletedObjects() async throws {
    let xml = ["Content-Type": "application/xml"]
    let stub = try Stub(
        StubResponse(headers: xml, body: """
        <ListVersionsResult><IsTruncated>false</IsTruncated><Version><Key>locked.txt</Key></Version></ListVersionsResult>
        """),
        StubResponse(headers: xml, body: """
        <DeleteResult><Error><Key>locked.txt</Key><Code>AccessDenied</Code><Message>Access Denied</Message></Error></DeleteResult>
        """)
    )

    let error = await #expect(throws: Exoscale.S3Error.self) {
        try await stub.exoscale.objectStorage.emptyBucket("assets")
    }
    #expect(error?.code == "AccessDenied")
}
