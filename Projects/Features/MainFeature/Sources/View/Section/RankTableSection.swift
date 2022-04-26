import RxDataSources
import Domain
import Utility

struct RankTableSection: SectionModelType {
    var items: [(Criteria, GRIGAPI.GrigEntityQuery.Data.Ranking)]
}

extension RankTableSection {
    typealias Item = (Criteria, GRIGAPI.GrigEntityQuery.Data.Ranking)
    
    init(original: RankTableSection, items: [(Criteria, GRIGAPI.GrigEntityQuery.Data.Ranking)]) {
        self = original
        self.items = items
    }
}
