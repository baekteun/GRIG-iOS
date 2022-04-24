import RxSwift
import Utility

public protocol GRIGRepository {
    func fetchRankingList(criteria: Criteria) -> Single<[GRIGAPI.GrigEntityQuery.Data.Ranking]>
}
