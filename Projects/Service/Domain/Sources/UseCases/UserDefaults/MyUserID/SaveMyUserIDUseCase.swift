
public struct SaveMyUserIDUseCase {
    public init(userIDRepository: UserIDRepository) {
        self.userIDRepository = userIDRepository
    }
    
    private let userIDRepository: UserIDRepository
    
    public func execute(value: String) {
        userIDRepository.saveMyUserID(value: value)
    }
}
