import UIKit

public extension UIStackView {
    func addArrangeSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
