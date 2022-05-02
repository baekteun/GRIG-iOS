import Apollo
import Utility
import Foundation
import Domain
import RxSwift

struct GRIGRemote {
    private let client = ApolloClient(url: URL(string: "https://d6ui2fy5uj.execute-api.ap-northeast-2.amazonaws.com/api/graphql")!)
    private init() {}
    
    static let shared = GRIGRemote()
    
    func fetchRankingList(
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
                case let .failure(err):
                    single(.failure(err))
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchGenerationList() -> Single<[GRIGAPI.GrigGenerationQuery.Data.Generation?]> {
        .create { single in
            client.fetch(query: GRIGAPI.GrigGenerationQuery()) { res in
                switch res {
                case let .success(data):
                    single(.success(data.data?.generation ?? []))
                case let .failure(err):
                    single(.failure(err))
                }
            }
            return Disposables.create()
        }
    }
}
