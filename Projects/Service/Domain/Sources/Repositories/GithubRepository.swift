import RxSwift
import Utility

public protocol GithubRepository {
    func fetchUserInfo(
        login: String,
        from: String,
        to: String
    ) -> Single<GRIGAPI.GithubUserQuery.Data.User?>
    
    func fetchUserTotalContribution(login: String) -> Single<Int?>
}
