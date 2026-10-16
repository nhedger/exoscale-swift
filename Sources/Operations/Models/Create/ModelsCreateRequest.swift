import Foundation

extension ModelsOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let huggingfaceToken: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateModelBody(name: name, huggingfaceToken: huggingfaceToken)
            )

            return Http.Request(
                method: .post,
                path: "/ai/model",
                body: body
            )
        }
    }
}
