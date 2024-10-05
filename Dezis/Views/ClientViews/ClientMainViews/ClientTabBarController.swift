import UIKit

class ClientTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        tabBar.backgroundColor = UIColor(hex: "#1B2228")
        tabBar.tintColor = UIColor(hex: "#0A84FF")
        tabBar.unselectedItemTintColor = .white
        addTabBarBorder()
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

        let calendarView = UINavigationController(rootViewController: CalendarViewController())
        calendarView.tabBarItem = UITabBarItem(title: "Календарь", image: UIImage(resource: .clock), selectedImage: UIImage(resource: .clock))
        
        let chatView = UINavigationController(rootViewController: ClientChatViewController())
        chatView.tabBarItem = UITabBarItem(title: "Чат", image: UIImage(resource: .message), selectedImage: UIImage(resource: .message))

        let personalAccount = UINavigationController(rootViewController: PersonalAccountViewController())
        personalAccount.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(resource: .profile), selectedImage: UIImage(resource: .profile))

        setViewControllers([homeView, calendarView, chatView, personalAccount], animated: true)
    }
//    func setTabBarAppearence (){
//        let positionOnX: CGFloat = 13
//        let positionOnY: CGFloat = 6
//        let width = tabBar.bounds.width - positionOnX * 2
//        let height = tabBar.bounds.height + positionOnY
//        let roundLayer = CAShapeLayer()
//        
//        let bezierPath = UIBezierPath(
//            roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY-positionOnY, width: width, height: height),
//            cornerRadius: 12)
//        roundLayer.path = bezierPath.cgPath
//        tabBar.layer.insertSublayer(roundLayer, at: 0)
//        tabBar.itemWidth = width / 5
//        tabBar.itemPositioning = .centered
//        roundLayer.fillColor =  UIColor(hex: "#0688C1").cgColor
//        tabBar.unselectedItemTintColor = .white
//        
//    }
}

