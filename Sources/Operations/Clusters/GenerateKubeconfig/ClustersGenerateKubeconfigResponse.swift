import Foundation

extension ClustersOperations.GenerateKubeconfig {
    struct Response: HttpResponse {
        let data: GenerateSKSClusterKubeconfigData

        func transform(client _: Http.Client) -> String {
            data.kubeconfig
        }
    }
}
