import Apollo
import Foundation
import RxSwift
import Domain

struct GithubRemote {
    private let client: ApolloClient = {
        let url = URL(string: "https://api.github.com/graphql")!
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let netProvider = NetworkInterceptorProvider(store: store, client: URLSessionClient())
        let transport = RequestChainNetworkTransport(interceptorProvider: netProvider, endpointURL: url)
        return ApolloClient(networkTransport: transport, store: store)
    }()
    private init() {}
    
    static let shared = GithubRemote()
    
    func fetchUserInfo(
        login: String,
        from: String,
        to: String
    ) -> Single<GRIGAPI.GithubUserQuery.Data.User> {
        .create { single in
            client.fetch(
                query: GRIGAPI.GithubUserQuery(
                    login: login,
                    from: from,
                    to: to
                )
            ) { res in
                switch res {
                case let .success(data):
                    if let user = data.data?.user {
                        single(.success(user))
                    } else {
                        single(.failure(GraphQLError.init(.init())))
                    }
                case let .failure(err):
                    single(.failure(err))
                }
            }
            return Disposables.create()
        }
    }
}
