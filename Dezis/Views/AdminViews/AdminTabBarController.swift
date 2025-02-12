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
        
        navigationItem.hidesBackButton = true
        setupTabBarController()
        addTabBarBorder()
        tabBar.backgroundColor = UIColor(hex: "#1B2228")
        tabBar.tintColor = UIColor(hex: "#0A84FF")
        tabBar.unselectedItemTintColor = .white
        tabBar.barTintColor = UIColor(hex: "#1B2228")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let newTabBarHeight: CGFloat = 82
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = newTabBarHeight
        tabBarFrame.origin.y = view.frame.height - newTabBarHeight
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
        
        let historyView = UINavigationController(rootViewController: AdminHistoryView())
        historyView.navigationBar.isHidden = true
        historyView.tabBarItem = UITabBarItem(title: "История", image: UIImage(named: "clock1"), selectedImage: UIImage(named: "clock1.fill"))
        
        let chatView = UINavigationController(rootViewController: AdminChatViewController())
        chatView.navigationBar.isHidden = true
        chatView.tabBarItem = UITabBarItem(title: "Чаты", image: UIImage(named: "message"), selectedImage: UIImage(named: "message.fill"))
        
        let requestView = UINavigationController(rootViewController: AdminRequestsView())
        requestView.navigationBar.isHidden = true
        requestView.tabBarItem = UITabBarItem(title: "Запросы", image: UIImage(named: "notification"), selectedImage: UIImage(named: "notification.fill"))
        
        setViewControllers([historyView, chatView, requestView], animated: true)
    }
}
