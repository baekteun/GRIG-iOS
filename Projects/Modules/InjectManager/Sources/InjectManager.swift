import Core
import Swinject
import Data
import Domain

public struct InjectManager {
    public static func inject(container: Container) -> Assembler {
        return Assembler([
            RepositoryAssembly(),
            UseCaseAssembly()
        ], container: container)
    }
}
