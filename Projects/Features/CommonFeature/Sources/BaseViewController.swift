import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    public let bounds = UIScreen.main.bounds
    open var disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
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
    
    open func setUp() {}
    open func addView() {}
    open func setLayout() {}
    open func configureVC() {}
    
    open func bindOutput() {}
}
