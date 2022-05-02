import RxSwift

public struct FetchGenerationListUseCase {
    public init(grigRepository: GRIGRepository) {
        self.grigRepository = grigRepository
    }
    
    private let grigRepository: GRIGRepository
    
    public func execute() -> Single<[GRIGAPI.GrigGenerationQuery.Data.Generation?]> {
        grigRepository.fetchGenerationList()
    }
}
