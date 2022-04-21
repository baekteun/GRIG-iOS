import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    public let bounds = UIScreen.main.bounds
    public var disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindOutput()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
        addView()
        setLayout()
        configureVC()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        addView()
        setLayout()
        configureVC()
    }
    
    public func setUp() {}
    public func addView() {}
    public func setLayout() {}
    public func configureVC() {}
    
    public func bindOutput() {}
}
