import RxSwift
import Foundation

public protocol UserIDRepository {
    init(userDefaults: UserDefaults)
    
    func fetchMyUserID() -> String?
    func saveMyUserID(value: String)
    func deleteMyUserID()
    
    func fetchCompeteUserID() -> String?
    func saveCompeteUserID(value: String)
    func deleteCompeteUserID()
}
