import RxSwift
import Domain
import Utility

struct GRIGRepositoryImpl: GRIGRepository {
    private let grigRemote = GRIGRemote.shared
    
    init() {}
    
    func fetchRankingList(
        criteria: Criteria,
        count: Int,
        page: Int,
        generation: Int
    ) -> Single<[GRIGAPI.GrigEntityQuery.Data.Ranking?]> {
        grigRemote.fetchRankingList(criteria: criteria, count: count, page: page, generation: generation)
    }
    
    func fetchGenerationList() -> Single<[GRIGAPI.GrigGenerationQuery.Data.Generation?]> {
        grigRemote.fetchGenerationList()
    }
}
