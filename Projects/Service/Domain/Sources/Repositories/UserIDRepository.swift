import RxSwift
import Foundation

public protocol UserIDRepository {
    init(userDefaults: UserDefaults)
    func fetchUserID() -> String?
    func saveUserID(value: String)
    func deleteUserID()
}
