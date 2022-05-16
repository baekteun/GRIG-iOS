import Foundation
import Apollo

struct NetworkInterceptorProvider: InterceptorProvider {

  // These properties will remain the same throughout the life of the `InterceptorProvider`, even though they
  // will be handed to different interceptors.
  private let store: ApolloStore
  private let client: URLSessionClient

  init(store: ApolloStore,
        client: URLSessionClient) {
    self.store = store
    self.client = client
  }
    

  func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
    return [
      MaxRetryInterceptor(),
      CacheReadInterceptor(store: self.store),
      NetworkFetchInterceptor(client: self.client),
      HeaderInterceptor(),
      ResponseCodeInterceptor(),
      JSONResponseParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
      AutomaticPersistedQueryInterceptor(),
      CacheWriteInterceptor(store: self.store)
    ]
  }
}
