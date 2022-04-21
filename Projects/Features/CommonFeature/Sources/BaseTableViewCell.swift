import UIKit
import Reusable
import RxSwift

open class BaseTableViewCell<T>: UITableViewCell, Reusable {
    public let bound = UIScreen.main.bounds
    public lazy var disposeBag = DisposeBag()
    public var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setLayout()
        configureCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        setLayout()
        configureCell()
    }
    
    public func addView() {}
    public func setLayout() {}
    public func configureCell() {}
    public func bind(_ modle: T) {}
}
