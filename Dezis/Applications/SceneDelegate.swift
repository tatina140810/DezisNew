import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    //    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    //
    //        let socket = ChatWebSocket()
    //        socket.connect()
    //        socket.sendText(text: "Hello")
    //        socket.sendMessage(text: "Hello")
    //        //Проверяем валидность access token:
    //        print("isAccessTokenValid", isAccessTokenExpired())
    //        print(KeychainService.shared.accessToken, "access token")
    //
    //     //   let tokenChat: UserTokenResponseModel
    //        //Test SignalR
    //        let signalR = SignalRService(url: URL(string: "wss://dezis.pp.ua/ws/chat/\(285)")!)
    //        signalR.connectionStart()
    //
    //        //Test Chat post request
    //
    //        ChatService.shared.sendMessage(message: ChatModel(text: "test")) { result in
    //            switch result {
    //            case .success(let success):
    //                ()
    //            case .failure(let failure):
    //                ()
    //            }
    //        }
    //
    //        ChatService.shared.fetchChatList {  result in
    //            switch result {
    //            case .success(let success):
    //                ()
    //            case .failure(let failure):
    //                ()
    //            }
    //        }
    //        guard let windowScene = (scene as? UIWindowScene) else { return }
    //
    //        window = UIWindow(windowScene: windowScene)
    //        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    //
    //        //TODO: - "Надо в зависимости от сохраненных токенов запускать либо логин, либо домашний экран"
    //        if hasCompletedOnboarding {
    //            if KeychainService.shared.hasToken {
    //                let clientTabBarVC = ClientTabBarController()
    //                window?.rootViewController = clientTabBarVC
    //            } else {
    //                let choiceVC = UINavigationController(rootViewController: ChoiceViewController())
    //                window?.rootViewController = choiceVC
    //            }
    //
    //        } else {
    //            let root = UINavigationController(rootViewController: FirstOnboardingViewController())
    //            window?.rootViewController = root
    //        }
    //
    //        window?.makeKeyAndVisible()
    //        if #available(iOS 15, *) {
    //            let navigationBarAppearance = UINavigationBarAppearance()
    //            navigationBarAppearance.configureWithOpaqueBackground()
    //            navigationBarAppearance.titleTextAttributes = [
    //                NSAttributedString.Key.foregroundColor: UIColor.white
    //            ]
    //            navigationBarAppearance.backgroundColor = UIColor(hex: "#1B2228")
    //
    //            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    //            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
    //            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    //        } else {
    //            UINavigationBar.appearance().barTintColor = UIColor(hex: "#1B2228")
    //            UINavigationBar.appearance().titleTextAttributes = [
    //                NSAttributedString.Key.foregroundColor: UIColor.white
    //            ]
    //            UINavigationBar.appearance().isTranslucent = false
    //        }
    //    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //        let roomId = 1
        //        let token = KeychainService.shared.accessToken
        //
        //        let chatWebSocket = ChatWebSocket(roomId: roomId, token: token)
        //        chatWebSocket.connect()
        //        chatWebSocket.sendText(text: "Hello")
        //
        //        let signalRService = SignalRService(roomId: roomId, token: token)
        //        signalRService.connectionStart()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        determineInitialScreen()
    }
    private func determineInitialScreen() {
           let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
           let hasAccessToken = !KeychainService.shared.accessToken.isEmpty
           
           if hasAccessToken {
               AuthManager.shared.validateToken { [weak self] isAuthorized in
                   DispatchQueue.main.async {
                       if isAuthorized {
                           print("Токен действителен. Переходим на главный экран.")
                           self?.showMainScreen()
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
       
       /// Переход на главный экран
       private func showMainScreen() {
           let clientTabBarVC = ClientTabBarController()
           window?.rootViewController = clientTabBarVC
           window?.makeKeyAndVisible()
           
           setupWebSocketAndSignalR()
       }
       
       /// Показ онбординга
       private func showOnboarding() {
           let onboardingVC = UINavigationController(rootViewController: FirstOnboardingViewController())
           window?.rootViewController = onboardingVC
           window?.makeKeyAndVisible()
       }
       
       /// Показ экрана входа
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
