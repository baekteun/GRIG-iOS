import Domain
import RxSwift

struct GithubRepositoryImpl: GithubRepository {
    private let githubRemote = GithubRemote.shared
    
    func fetchUserInfo(
        login: String,
        from: String,
        to: String
    ) -> Single<GRIGAPI.GithubUserQuery.Data.User> {
        githubRemote.fetchUserInfo(login: login, from: from, to: to)
    }
}
