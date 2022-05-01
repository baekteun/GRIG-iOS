import RIBs
import UIKit
import PanModal

public extension ViewControllable {
    func present(
        _ viewControllable: ViewControllable,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
    }
    func presentPanModal(
        _ viewController: ViewControllable
    ) {
        guard viewController.uiviewController is PanModalPresentable
        else {
            return
        }
        self.uiviewController.presentPanModal(viewController.uiviewController as! (PanModalPresentable & UIViewController))
    }
    func dismiss(animated : Bool, completion: (() -> Void)?) {
        self.uiviewController.dismiss(animated: animated, completion: completion)
    }
    func presentAlert(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction] = []
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach(alert.addAction(_:))
        self.uiviewController.navigationController?.visibleViewController?.present(alert, animated: true)
    }
    func presentFailureAlert(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction]? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if let actions = actions {
            actions.forEach(alert.addAction(_:))
        } else {
            alert.addAction(.init(title: "확인", style: .cancel, handler: nil))
        }
        self.uiviewController.navigationController?.visibleViewController?.present(alert, animated: true)
    }
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.pushViewController(viewControllable.uiviewController, animated: animated)
        } else {
            self.uiviewController.navigationController?.pushViewController(
                viewControllable.uiviewController,
                animated: animated
            )
        }
    }
    func popViewController(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popViewController(animated: animated)
        }
    }
    func popToRoot(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popToRootViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popToRootViewController(animated: animated)
        }
    }
    func setViewControllers(_ viewControllerables: [ViewControllable], animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: animated)
        } else {
            self.uiviewController.navigationController?.setViewControllers(
                viewControllerables.map(\.uiviewController),
                animated: animated
            )
        }
    }
    func setViewControllersInTabbar(_ viewControllers: [ViewControllable], animated: Bool) {
        guard let tab = self.uiviewController as? UITabBarController else { return }
        tab.setViewControllers(viewControllers.map(\.uiviewController), animated: animated)
    }
    var topViewControllable: ViewControllable {
        var top: ViewControllable = self
        while let presented = top.uiviewController.presentedViewController as? ViewControllable {
            top = presented
        }
        return top
    }
}
