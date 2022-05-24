import UIKit
import RxSwift
import Reusable

open class BaseCollectionViewCell<T>: UICollectionViewCell, Reusable {
    public let bound = UIScreen.main.bounds
    public override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureCell()
    }
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func addView(){}
    open func setLayout(){}
    open func configureCell(){}
    open var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    open func bind(_ model: T){}
}
