import Utility
import RxSwift

public struct FetchUserInfoUseCase {
    public init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }
    
    private let githubRepository: GithubRepository
    
    public func execute(
        login: String,
        from: String,
        to: String
    ) -> Single<GRIGAPI.GithubUserQuery.Data.User?> {
        githubRepository.fetchUserInfo(login: login, from: from, to: to)
    }
}
