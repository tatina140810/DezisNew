import UIKit

class ClientTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        setTabBarAppearence()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .white
    }

    func setupTabBarController() {
        let homeView = UINavigationController(rootViewController: ClientHomeViewController())
        homeView.tabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .home), selectedImage: UIImage(resource: .homeFill))

        let servicesView = UINavigationController(rootViewController: ServicesViewController())
        servicesView.tabBarItem = UITabBarItem(title: nil, image: UIImage(resource: .service), selectedImage: UIImage(resource: .serviceFill))

        let personalAccount = UINavigationController(rootViewController: PersonalAccountViewController())
        personalAccount.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))

        setViewControllers([homeView, servicesView, personalAccount], animated: true)
    }
    func setTabBarAppearence (){
        let positionOnX: CGFloat = 13
        let positionOnY: CGFloat = 6
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY-positionOnY, width: width, height: height),
            cornerRadius: 12)
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        roundLayer.fillColor =  UIColor(hex: "#0688C1").cgColor
        tabBar.unselectedItemTintColor = .white
        
    }
}

