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
        addTabBarBorder()
        tabBar.backgroundColor = UIColor(hex: "#1B2228")
        tabBar.tintColor = UIColor(hex: "#0A84FF")
        tabBar.unselectedItemTintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 82
        tabBarFrame.origin.y = view.frame.size.height - 82
        tabBar.frame = tabBarFrame
    }
    
    private func addTabBarBorder() {
        
        let borderView = UIView()
        borderView.backgroundColor = UIColor.white
        tabBar.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.top.equalTo(tabBar)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupTabBarController() {
        let homeView = UINavigationController(rootViewController: ClientHomeViewController())
        homeView.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "house"), selectedImage: UIImage(named: "house.fill"))
        
        let historyView = UINavigationController(rootViewController: AdminHistoryViewController())
        historyView.tabBarItem = UITabBarItem(title: "История", image: UIImage(named: "clock1"), selectedImage: UIImage(named: "clock1.fill"))
        
        let chatView = UINavigationController(rootViewController: AdminChatViewController())
        chatView.tabBarItem = UITabBarItem(title: "Чаты", image: UIImage(named: "message"), selectedImage: UIImage(named: "message.fill"))
        
        let requestView = UINavigationController(rootViewController: AdminRequestsViewController())
        requestView.tabBarItem = UITabBarItem(title: "Запросы", image: UIImage(named: "notification"), selectedImage: UIImage(named: "notification.fill"))
        
        setViewControllers([homeView, historyView, chatView, requestView], animated: true)
    }
}
