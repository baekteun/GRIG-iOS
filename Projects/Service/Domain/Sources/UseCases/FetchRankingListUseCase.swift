import Utility
import RxSwift

public struct FetchRankingListUseCase {
    public init(grigRepository: GRIGRepository) {
        self.grigRepository = grigRepository
    }
    
    private let grigRepository: GRIGRepository
    
    public func execute(
        criteria: Criteria,
        count: Int,
        page: Int,
        generation: Int
    ) -> Single<[GRIGAPI.GrigEntityQuery.Data.Ranking?]> {
        grigRepository.fetchRankingList(criteria: criteria, count: count, page: page, generation: generation)
    }
}
