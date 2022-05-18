
public struct DeleteMyUserIDUseCase {
    public init(userIDRepository: UserIDRepository) {
        self.userIDRepository = userIDRepository
    }
    
    private let userIDRepository: UserIDRepository
    
    public func execute() {
        userIDRepository.deleteMyUserID()
    }
}
