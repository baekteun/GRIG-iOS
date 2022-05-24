import RxSwift

public protocol OnboardingRepository {
    func shouldOnboarding() -> Bool
    func saveOnboarding(onboarding: Bool)
}
