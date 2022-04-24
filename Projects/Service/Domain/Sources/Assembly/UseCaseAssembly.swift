import Swinject

final class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FetchRankingListUseCase.self) { r in
            FetchRankingListUseCase(
                grigRepository: r.resolve(GRIGRepository.self)!
            )
        }
    }
}
