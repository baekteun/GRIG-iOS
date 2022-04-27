import Swinject
import Domain
import ThirdPartyLib

public extension DIContainer {
    func registerRepository() {
        DIContainer.register(GRIGRepository.self) { _ in
            GRIGRepositoryImpl()
        }
    }
}
