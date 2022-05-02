import Foundation
import CDMarkdownKit
import Then

public enum About: String, CaseIterable {
    case purpose = "목적"
    case funtion = "기능"
    case issue = "이슈 제보"
    case license = "라이센스"
    case privacy = "개인 정보"
    
    private static let parser: CDMarkdownParser = {
        let parser = CDMarkdownParser(font: .systemFont(ofSize: 18, weight: .regular))
        
        return parser
    }()
}

public extension About {
    var description: NSAttributedString {
        switch self {
        case .purpose:
            return About.parser.parse("GRIG는 광주소프트웨어마이스터고등학교 학생들의 Github 활동을 활성화하기 위해서 만들어졌습니다.")
        case .funtion:
            return About.parser.parse("""
 GRIG-iOS는 Apollo-iOS를 이용하여 GraphQL API를 처리합니다.
 서버의 데이터 `revalidate` 주기는 24시간입니다. 데이터가 바로 반영되지 않아도 기다려주시기 바랍니다.
 랭킹은 기본적으로 Contributions, 전체 기수를 기준으로 정렬되어 있습니다. 정렬 버튼을 통해 기준, 기수를 정해 정렬할 수 있습니다. 유저를 클릭하면 해당 유저의 Github 프로필을 브라우저에서 볼 수 있습니다.
 라이트모드와 다크모드를 모두 지원합니다.
""")
        case .issue:
            return About.parser.parse("""
 UI나 UX 문제 또는 클라이언트 기능 작동 오류가 발생한 경우에는 [Github Issue](https://github.com)에 이슈를 제보해주시면 감사드리겠습니다.
 서버 이슈라고 생각하신다면 [Github Issue](https://github.com/GRI-G/GRIG-API/issues)에 이슈를 제보해주시면 감사드리겠습니다.
""")
        case .license:
            return About.parser.parse("""
 GRIG-iOS는 [GRIG OpenAPI](https://github.com/GRI-G/GRIG-API)를 사용하였습니다.
 GRIG OpenAPI는 MIT License를 가지고 있습니다. 이에 본 프로젝트 또한 오픈소스로 진행하고 있지만 프로젝트 코드 원본 자체를 베껴 사용하지 말아주시기 바랍니다.
 게시물 플랫폼에 본 프로젝트 URL 삽입을 원할 경우, 본 프로젝트의 Github URL 을 같이 삽입하여주시기 바랍니다.
""")
        case .privacy:
            return About.parser.parse("GRIG OpenAPI 에 본인을 등록하실 경우, Github Profile 사진 활용 및 기타 유저 리스트에 필요한 사용자 정보 활용에 동의한 것으로 간주됩니다.")
        }
    }
}
