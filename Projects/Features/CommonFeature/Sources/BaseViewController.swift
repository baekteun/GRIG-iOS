import UIKit
import RxSwift
import Core
import NVActivityIndicatorView
import ThirdPartyLib
import SnapKit

open class BaseViewController: UIViewController {
    private let activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .pacman,
        color: CoreAsset.Colors.grigPrimaryTextColor.color
    )
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
        configureIndicator()
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
        configureIndicator()
    }
    
    open func setUp() {}
    open func addView() {}
    open func setLayout() {}
    open func configureVC() {}
    open func configureNavigation() {}
    private func configureIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
        }
    }
    
    open func bindListener() {}
    open func startIndicator() {
        activityIndicator.startAnimating()
    }
    open func stopIndicator() {
        activityIndicator.stopAnimating()
    }
}
