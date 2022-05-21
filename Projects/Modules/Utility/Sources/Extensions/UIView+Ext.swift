import UIKit
import RIBs
import RxSwift
import RxCocoa

public extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach(self.addSubview(_:))
    }
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
