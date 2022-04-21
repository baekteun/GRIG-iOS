import UIKit
import RxSwift
import Reusable

open class BaseCollectionViewCell<T>: UICollectionViewCell, Reusable {
    public let bound = UIScreen.main.bounds
    public override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureCell()
    }
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func addView(){}
    public func setLayout(){}
    public func configureCell(){}
    public var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    public func bind(_ model: T){}
}
