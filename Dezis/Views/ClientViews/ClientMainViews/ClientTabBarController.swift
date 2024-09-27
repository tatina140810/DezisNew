import UIKit

class ClientTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        tabBar.backgroundColor = UIColor(hex: "#5191BA")
        tabBar.tintColor = .white
    }

    func setupTabBarController() {
        let homeView = UINavigationController(rootViewController: ClientHomeViewController())
        homeView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        let servicesView = UINavigationController(rootViewController: ServicesViewController())
        servicesView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "doc.plaintext"), selectedImage: UIImage(systemName: "doc.plaintext.fill"))

        let personalAccount = UINavigationController(rootViewController: PersonalAccountViewController())
        personalAccount.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        setViewControllers([homeView, servicesView, personalAccount], animated: true)
    }
}

