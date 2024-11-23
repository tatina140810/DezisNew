import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow? 
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        
        if hasCompletedOnboarding {
          //  let choiceVC = UINavigationController(rootViewController: ClientTabBarController())
           // let choiceVC = ClientTabBarController()
            let choiceVC = UINavigationController(rootViewController:ChoiceViewController())
            window?.rootViewController = choiceVC
        } else {
            let root = UINavigationController(rootViewController: FirstOnboardingViewController())
          //  window?.overrideUserInterfaceStyle = .dark
            window?.rootViewController = root
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToMain), name: NSNotification.Name("GoToMain"), object: nil)
        
        window?.makeKeyAndVisible()
    }
    
    @objc private func goToMain() {
        window?.rootViewController = ClientTabBarController()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
