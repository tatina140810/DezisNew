import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        determineInitialScreen()
    }
    private func determineInitialScreen() {
        let userConfirmed = UserDefaults.standard.value(forKey: "confirmed")
           let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
           let hasAccessToken = !KeychainService.shared.accessToken.isEmpty
           
           if hasAccessToken {
               AuthManager.shared.validateToken { [weak self] isAuthorized in
                   DispatchQueue.main.async {
                       if isAuthorized {
                           print("Токен действителен. Переходим на главный экран.")
                           self?.showMainScreen(userConfirmed: (userConfirmed != nil))
                       } else {
                           print("Токен истек. Переходим на экран входа.")
                           self?.showLoginScreen()
                       }
                   }
               }
           } else if !hasCompletedOnboarding {
               print("Нет токена. Показываем онбординг.")
               showOnboarding()
           } else {
               print("Нет токена и онбординг завершен. Показываем экран входа.")
               showLoginScreen()
           }
       }
 
    private func showMainScreen(userConfirmed: Bool) {
        var vc = UIViewController()
           if userConfirmed {
             vc = ClientTabBarController()
           } else {
              vc = EntryAllowedViewController()
           }

           window?.rootViewController = vc
           window?.makeKeyAndVisible()
           
           setupWebSocketAndSignalR()
       }

       private func showOnboarding() {
           let onboardingVC = UINavigationController(rootViewController: FirstOnboardingViewController())
           window?.rootViewController = onboardingVC
           window?.makeKeyAndVisible()
       }

       private func showLoginScreen() {
           let loginVC = UINavigationController(rootViewController: ChoiceViewController())
           window?.rootViewController = loginVC
           window?.makeKeyAndVisible()
       }
       
    private func setupWebSocketAndSignalR() {
            let roomId = 1
            let token = KeychainService.shared.accessToken
            
            let chatWebSocket = ChatWebSocket(roomId: roomId, token: token)
            chatWebSocket.connect()
            chatWebSocket.sendText(text: "Hello")
         
            let signalRService = SignalRService(roomId: roomId, token: token)
            signalRService.connectionStart()
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
    
}
