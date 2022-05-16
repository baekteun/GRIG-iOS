import Apollo
import Foundation

final class HeaderInterceptor: ApolloInterceptor {
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
        request.addHeader(
            name: "Authorization",
            value: ProcessInfo.processInfo.environment["GITHUB"]!
        )
        chain.proceedAsync(
            request: request,
            response: response,
            completion: completion
        )
    }
}
