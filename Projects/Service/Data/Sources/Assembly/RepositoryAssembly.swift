import Swinject
import Domain

public struct RepositoryAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(GRIGRepository.self) { _ in GRIGRepositoryImpl() }
    }
    public init() {}
}
