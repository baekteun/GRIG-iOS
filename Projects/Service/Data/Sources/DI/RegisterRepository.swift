import Swinject
import Domain
import ThirdPartyLib

public extension DIContainer {
    func registerRepository() {
        DIContainer.register(GRIGRepository.self) { _ in
            GRIGRepositoryImpl()
        }
        DIContainer.register(GithubRepository.self) { r in
            GithubRepositoryImpl()
        }
        DIContainer.register(UserIDRepository.self) { r in
            UserIDRepositoryImpl(userDefaults: .standard)
        }
    }
}
