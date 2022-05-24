
public enum Onboard: CaseIterable {
    case rank
    case analysis
    case info
    case sort
}

public extension Onboard {
    var titleDisplay: String {
        switch self {
        case .rank: return "랭크"
        case .analysis: return "분석"
        case .info: return "정보"
        case .sort: return "정렬"
        }
    }
    var descriptionDisplay: String {
        switch self {
        case .rank: return """
GSM 학생들의 깃허브 랭킹을
볼 수 있습니다!
"""
        case .analysis: return """
친구와 깃허브 활동을 분석하고 비교해
볼 수 있습니다!
"""
        case .info: return """
유저마다 상세한 정보를
볼 수 있습니다!
"""
        case .sort: return """
활동 종류, 기수를 기준으로
정렬할 수 있습니다.
"""
        }
    }
}
