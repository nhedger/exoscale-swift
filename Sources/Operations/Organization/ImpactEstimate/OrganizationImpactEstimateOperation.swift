extension OrganizationOperations {
    /// Defines the impactEstimate API operation.
    struct ImpactEstimate: HttpOperation {
        let request: Request

        func createResponse(_ data: Response.Payload) -> Response {
            var response = Response(data: data)
            response.sku = request.sku
            return response
        }
    }
}
