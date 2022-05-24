import RxDataSources
import UIKit

struct OnboardingSection: SectionModelType {
    var items: [UIImage]
}

extension OnboardingSection {
    typealias Item = UIImage
    
    init(original: OnboardingSection, items: [UIImage]) {
        self = original
        self.items = items
    }
}
