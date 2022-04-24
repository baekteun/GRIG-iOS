import RxDataSources
import Domain

struct RankTableSection: SectionModelType {
    var items: [GRIGEntity]
}

extension RankTableSection {
    typealias Item = GRIGEntity
    
    init(original: RankTableSection, items: [GRIGEntity]) {
        self = original
        self.items = items
    }
}
