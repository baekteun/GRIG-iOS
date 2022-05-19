import Swinject
import ThirdPartyLib

public extension DIContainer {
    func registerUseCase() {
        DIContainer.register(FetchRankingListUseCase.self) { r in
            FetchRankingListUseCase(
                grigRepository: r.resolve(GRIGRepository.self)!
            )
        }
        DIContainer.register(FetchGenerationListUseCase.self) { r in
            FetchGenerationListUseCase(
                grigRepository: r.resolve(GRIGRepository.self)!
            )
        }
        DIContainer.register(FetchUserInfoUseCase.self) { r in
            FetchUserInfoUseCase(
                githubRepository: r.resolve(GithubRepository.self)!
            )
        }
        DIContainer.register(FetchMyUserIDUseCase.self) { r in
            FetchMyUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
        DIContainer.register(SaveMyUserIDUseCase.self) { r in
            SaveMyUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
        DIContainer.register(DeleteMyUserIDUseCase.self) { r in
            DeleteMyUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
        DIContainer.register(FetchCompeteUserIDUseCase.self) { r in
            FetchCompeteUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
        DIContainer.register(SaveCompeteUserIDUseCase.self) { r in
            SaveCompeteUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
        DIContainer.register(DeleteCompeteUserIDUseCase.self) { r in
            DeleteCompeteUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
        DIContainer.register(FetchUserTotalContributionUseCase.self) { r in
            FetchUserTotalContributionUseCase(
                githubRepository: r.resolve(GithubRepository.self)!
            )
        }
    }
}
