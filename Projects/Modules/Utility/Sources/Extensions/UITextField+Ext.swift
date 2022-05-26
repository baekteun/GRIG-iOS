import UIKit
import ThirdPartyLib
import SnapKit

public extension UITextField {
    func setUnderLine(color: UIColor) {
        let separator = UIView()
        separator.backgroundColor = color
        
        self.addSubviews(separator)
        separator.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(0.5)
        }
    }
    func leftSpace(_ space: CGFloat) {
        let spacer = UIView(frame: .init(x: 0, y: 0, width: space, height: self.frame.height))
        leftView = spacer
        leftViewMode = .always
    }
    func rightSpace(_ space: CGFloat) {
        let spacer = UIView(frame: .init(x: 0, y: 0, width: space, height: self.frame.height))
        rightView = spacer
        rightViewMode = .always
    }
    func horizontalSpace(_ space: CGFloat) {
        let left = UIView(frame: .init(x: 0, y: 0, width: space, height: self.frame.height))
        let right = UIView(frame: .init(x: 0, y: 0, width: space, height: self.frame.height))
        leftView = left
        leftViewMode = .always
        rightView = right
        rightViewMode = .always
    }
}
