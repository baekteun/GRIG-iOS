import UIKit
import RootFeature
import Swinject
import RIBs
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launch(from: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        NetworkMonitor.shared.stopMonitoring()
    }
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {
        startMonitoring()
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        NetworkMonitor.shared.stopMonitoring()
    }
    
}

private extension SceneDelegate {
    func startMonitoring() {
        NetworkMonitor.shared.startMonitoring { [weak self] path in
            switch path.status {
            case .satisfied:
                break
            case .unsatisfied:
                self?.launchRouter?.viewControllable.showLoaf("네트워크 연결을 확인해주세요!", state: .error, location: .top)
            case .requiresConnection:
                self?.launchRouter?.viewControllable.showLoaf("네트워크 연결이 불안정합니다", state: .warning, location: .top)
            @unknown default:
                break
            }
        }
    }
}
