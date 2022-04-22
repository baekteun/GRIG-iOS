import UIKit
import RIBs
import RxSwift
import RxCocoa

public extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach(self.addSubview(_:))
    }
}
