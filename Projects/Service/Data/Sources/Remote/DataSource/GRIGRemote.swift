import Apollo
import Utility
import Foundation
import Domain
import RxSwift

struct GRIGRemote {
    private let client = ApolloClient(url: URL(string: "https://d6ui2fy5uj.execute-api.ap-northeast-2.amazonaws.com/api/graphql")!)
    
    func request(
        criteria: Criteria,
        count: Int,
        page: Int,
        generation: Int
    ) -> Single<[GRIGAPI.GrigEntityQuery.Data.Ranking?]> {
        .create { single in
            client.fetch(query: GRIGAPI.GrigEntityQuery(
                criteria: criteria.rawValue, count: count, page: page, generation: generation)
            ) { res in
                switch res {
                case let .success(data):
                    single(.success(data.data?.ranking ?? []))
                    break
                case let .failure(err):
                    single(.failure(err))
                }
            }
            return Disposables.create()
        }
    }
}
