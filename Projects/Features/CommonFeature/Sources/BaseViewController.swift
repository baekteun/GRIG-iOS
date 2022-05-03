import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    public let bounds = UIScreen.main.bounds
    open var disposeBag = DisposeBag()
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindListener()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
        addView()
        setLayout()
        configureVC()
        configureNavigation()
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        addView()
        setLayout()
        configureVC()
        configureNavigation()
    }
    
    open func setUp() {}
    open func addView() {}
    open func setLayout() {}
    open func configureVC() {}
    open func configureNavigation() {}
    
    open func bindListener() {}
}
