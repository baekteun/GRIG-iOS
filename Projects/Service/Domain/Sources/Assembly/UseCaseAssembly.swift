import Swinject

public struct UseCaseAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(FetchRankingListUseCase.self) { r in
            FetchRankingListUseCase(
                grigRepository: r.resolve(GRIGRepository.self)!
            )
        }
    }
    public init(){}
}
