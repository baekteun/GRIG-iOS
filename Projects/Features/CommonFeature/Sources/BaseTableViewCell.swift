import UIKit
import Reusable
import RxSwift

open class BaseTableViewCell<T>: UITableViewCell, Reusable {
    public let bound = UIScreen.main.bounds
    public var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setLayout()
        configureCell()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        setLayout()
        configureCell()
    }
    
    open func addView() {}
    open func setLayout() {}
    open func configureCell() {}
    open func bind(_ model: T) {}
}
