import Swinject
import Domain
import ThirdPartyLib

public extension DIContainer {
    func registerRepository() {
        DIContainer.register(GRIGRepository.self) { _ in
            GRIGRepositoryImpl()
        }
        DIContainer.register(GithubRepository.self) { _ in
            GithubRepositoryImpl()
        }
        DIContainer.register(UserIDRepository.self) { _ in
            UserIDRepositoryImpl(userDefaults: .standard)
        }
        DIContainer.register(OnboardingRepository.self) { _ in
            OnboardingRepositoryImpl(userDefault: .standard)
        }
    }
}
