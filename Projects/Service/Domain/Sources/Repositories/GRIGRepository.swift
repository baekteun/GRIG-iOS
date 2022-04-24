import RxSwift
import Utility

public protocol GRIGRepository {
    func fetchRankingList(
        criteria: Criteria,
        count: Int,
        page: Int,
        generation: Int
    ) -> Single<[GRIGAPI.GrigEntityQuery.Data.Ranking]>
}
