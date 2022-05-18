
public struct FetchMyUserIDUseCase {
    public init(userIDRepository: UserIDRepository) {
        self.userIDRepository = userIDRepository
    }
    
    private let userIDRepository: UserIDRepository
    
    public func execute() -> String? {
        userIDRepository.fetchMyUserID()
    }
}
