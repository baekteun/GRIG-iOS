import RxSwift

public struct FetchUserTotalContributionUseCase {
    public init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }
    
    private let githubRepository: GithubRepository
    
    public func execute(login: String) -> Single<Int?> {
        githubRepository.fetchUserTotalContribution(login: login)
    }
}
