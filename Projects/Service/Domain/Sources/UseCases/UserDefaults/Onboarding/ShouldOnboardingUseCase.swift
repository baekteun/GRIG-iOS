import Foundation

public struct ShouldOnboardingUseCase {
    public init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    private let onboardingRepository: OnboardingRepository
    
    public func execute() -> Bool {
        onboardingRepository.shouldOnboarding()
    }
}
