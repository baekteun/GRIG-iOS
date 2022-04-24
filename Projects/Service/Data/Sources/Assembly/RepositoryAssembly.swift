import Swinject
import Domain

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GRIGRepository.self) { _ in
            GRIGRepositoryImpl()
        }
    }
}
