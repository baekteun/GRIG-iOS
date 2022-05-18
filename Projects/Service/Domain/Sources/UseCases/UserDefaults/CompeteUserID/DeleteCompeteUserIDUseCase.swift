public struct DeleteCompeteUserIDUseCase {
    public init(userIDRepository: UserIDRepository) {
        self.userIDRepository = userIDRepository
    }
    
    private let userIDRepository: UserIDRepository
    
    public func execute() {
        userIDRepository.deleteCompeteUserID()
    }
}
