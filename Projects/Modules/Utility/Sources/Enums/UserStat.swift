import UIKit

public enum UserStat: String {
    case follower
    case following
    case commit
}

public extension UserStat {
    var display: String {
        switch self {
        case .follower:
            return "팔로워"
        case .following:
            return "팔로우"
        case .commit:
            return "커밋"
        }
    }
}
