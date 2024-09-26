//
//  AdminTabBarController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class AdminTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        tabBar.backgroundColor = UIColor(hex: "#5191BA")
        tabBar.tintColor = .white
    }

    private func setupTabBarController() {
        let homeView = UINavigationController(rootViewController: AdminHomeViewController())
        homeView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        let ordersView = UINavigationController(rootViewController: AdminOrdersViewController())
        ordersView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bag"), selectedImage: UIImage(systemName: "bag.fill"))

        let personalAccount = UINavigationController(rootViewController: AdminPersonalAccountViewController())
        personalAccount.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        setViewControllers([homeView, ordersView, personalAccount], animated: true)
    }
}
