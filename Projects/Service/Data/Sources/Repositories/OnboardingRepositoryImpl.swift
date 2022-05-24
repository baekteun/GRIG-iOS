import Foundation
import Domain

public struct OnboardingRepositoryImpl: OnboardingRepository {
    private enum Forkey {
        static let onboarding = "onboarding"
    }
    private let userDefault: UserDefaults
    
    public init(
        userDefault: UserDefaults
    ) {
        self.userDefault = userDefault
    }
    
    public func shouldOnboarding() -> Bool {
        userDefault.bool(forKey: Forkey.onboarding)
    }
    public func saveOnboarding(onboarding: Bool) {
        userDefault.setValue(onboarding, forKey: Forkey.onboarding)
    }
}
