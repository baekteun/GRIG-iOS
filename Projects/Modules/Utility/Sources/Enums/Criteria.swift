import Foundation

public enum Criteria: String, CaseIterable {
    case contributions = "contributions"
    case stared = "stared"
    case following = "following"
    case follower = "follower"
    case forked = "forked"
    case issues = "issues"
    case pullRequests = "pullRequests"
}
