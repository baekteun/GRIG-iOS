import Foundation
import Domain

struct UserIDRepositoryImpl: UserIDRepository {
    private enum ForKey {
        static let userID = "userid"
    }
    private let userDefaults: UserDefaults
    
    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }
    
    func fetchUserID() -> String? {
        userDefaults.string(forKey: ForKey.userID)
    }
    func saveUserID(value: String) {
        userDefaults.setValue(value, forKey: ForKey.userID)
    }
    func deleteUserID() {
        userDefaults.removeObject(forKey: ForKey.userID)
    }
}
