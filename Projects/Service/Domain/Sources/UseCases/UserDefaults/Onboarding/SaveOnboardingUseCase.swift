import Foundation

public struct SaveOnboardingUseCase {
    public init(onboardingRepository: OnboardingRepository) {
        self.onboardingRepository = onboardingRepository
    }
    
    private let onboardingRepository: OnboardingRepository
    
    public func execute(onboarding: Bool) {
        onboardingRepository.saveOnboarding(onboarding: onboarding)
    }
}
