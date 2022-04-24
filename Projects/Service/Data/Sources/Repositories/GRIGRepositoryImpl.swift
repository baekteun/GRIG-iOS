import RxSwift
import Domain
import Utility

struct GRIGRepositoryImpl: GRIGRepository {
    private let grigRemote = GRIGRemote.shared
    
    func fetchRankingList(
        criteria: Criteria,
        count: Int,
        page: Int,
        generation: Int
    ) -> Single<[GRIGAPI.GrigEntityQuery.Data.Ranking?]> {
        grigRemote.request(criteria: criteria, count: count, page: page, generation: generation)
    }
}
