import Foundation
import Domain

struct UserIDRepositoryImpl: UserIDRepository {
    private enum ForKey {
        static let myUserID = "myuserid"
        static let competeUserID = "competeuserid"
    }
    private let userDefaults: UserDefaults
    
    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }
    
    func fetchMyUserID() -> String? {
        userDefaults.string(forKey: ForKey.myUserID)
    }
    
    func saveMyUserID(value: String) {
        userDefaults.setValue(value, forKey: ForKey.myUserID)
    }
    
    func deleteMyUserID() {
        userDefaults.removeObject(forKey: ForKey.myUserID)
    }
    
    func fetchCompeteUserID() -> String? {
        userDefaults.string(forKey: ForKey.competeUserID)
    }
    
    func saveCompeteUserID(value: String) {
        userDefaults.setValue(value, forKey: ForKey.competeUserID)
    }
    
    func deleteCompeteUserID() {
        userDefaults.removeObject(forKey: ForKey.competeUserID)
    }
}
