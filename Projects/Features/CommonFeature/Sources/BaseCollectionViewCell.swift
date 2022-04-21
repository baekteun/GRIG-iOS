import UIKit
import RxSwift
import Reusable

open class BaseCollectionViewCell<T>: UICollectionViewCell, Reusable {
    public let bound = UIScreen.main.bounds
    public lazy var disposeBag: DisposeBag = .init()
    public override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
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
