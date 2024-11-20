import UIKit

class ClientTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        tabBar.backgroundColor = UIColor(hex: "#1B2228")
        tabBar.tintColor = UIColor(hex: "#0A84FF")
        tabBar.barTintColor = UIColor(hex: "#1B2228")
        tabBar.unselectedItemTintColor = .white
        addTabBarBorder()
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#1B2228")
        NotificationCenter.default.addObserver(self, selector: #selector(switchToTab(_:)), name: NSNotification.Name("SwitchToTab"), object: nil)
    }
    
    @objc func switchToTab(_ notification: Notification) {
        if let userInfo = notification.userInfo, let tabIndex = userInfo["tabIndex"] as? Int {
            self.selectedIndex = tabIndex
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SwitchToTab"), object: nil)
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
    func setupTabBarController() {
        let homeView = UINavigationController(rootViewController: ClientHomeViewController())
        homeView.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(resource: .house), selectedImage: UIImage(resource: .house))
        
        let calendarView = CalendarViewController()
        calendarView.tabBarItem = UITabBarItem(title: "Календарь", image: UIImage(resource: .clock), selectedImage: UIImage(resource: .clock))
        
        let chatView = ClientChatViewController()
        chatView.tabBarItem = UITabBarItem(title: "Чаты", image: UIImage(resource: .message), selectedImage: UIImage(resource: .message))
        
        let personalAccount = PersonalAccountViewController()
        personalAccount.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(resource: .profile), selectedImage: UIImage(resource: .profile))
        
        setViewControllers([homeView, calendarView, chatView, personalAccount], animated: true)
    }
}

