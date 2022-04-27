import Swinject
import ThirdPartyLib

public extension DIContainer {
    func registerUseCase() {
        DIContainer.register(FetchRankingListUseCase.self) { r in
            FetchRankingListUseCase(
                grigRepository: r.resolve(GRIGRepository.self)!
            )
        }
    }
}