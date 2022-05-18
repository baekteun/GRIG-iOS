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
        DIContainer.register(FetchUserIDUseCase.self) { r in
            FetchUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
        DIContainer.register(SaveUserIDUseCase.self) { r in
            SaveUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
        DIContainer.register(DeleteUserIDUseCase.self) { r in
            DeleteUserIDUseCase(
                userIDRepository: r.resolve(UserIDRepository.self)!
            )
        }
    }
}
