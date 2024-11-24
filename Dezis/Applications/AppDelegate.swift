//
//  AppDelegate.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 18/9/24.
//

import UIKit

@available(iOS 13.0, *)
func customNavBarAppearance() -> UINavigationBarAppearance {
    let customNavBarAppearance = UINavigationBarAppearance()
    
    // Apply a red background.
    customNavBarAppearance.configureWithOpaqueBackground()
    customNavBarAppearance.backgroundColor = UIColor(hex: "#1B2228")
    
    // Apply white colored normal and large titles.
    customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]


    // Apply white color to all the nav bar buttons.
  //  let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
  //  barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
 //   barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
 //   barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
  //  barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
  //  customNavBarAppearance.buttonAppearance = barButtonItemAppearance
  //  customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
  //  customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
    
    return customNavBarAppearance
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let newNavBarAppearance = customNavBarAppearance()
               
           let appearance = UINavigationBar.appearance()
           appearance.scrollEdgeAppearance = newNavBarAppearance
           appearance.compactAppearance = newNavBarAppearance
           appearance.standardAppearance = newNavBarAppearance
           if #available(iOS 15.0, *) {
               appearance.compactScrollEdgeAppearance = newNavBarAppearance
           }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      
    }


}

