import UIKit
import Reachability

class ChoiceViewController: UIViewController {
    let reachability = try! Reachability()
    
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .logo)
        return image
    }()
    
    private lazy var userButton = ButtonSettings().buttonMaker(title: "Пользователь", target: self, action: #selector(userButtonTapped))
    
    private lazy var userButtonDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Для оформления заказов"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        return label
    }()
    
    private lazy var adminButton = ButtonSettings().buttonMaker(title:"Администратор", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(adminButtonTapped))
   
    private lazy var adminButtonDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Для управления системой"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        setupReachability()
        navigationController?.navigationBar.isHidden = true
        
    }

    func setupReachability(){
        reachability.whenUnreachable = { [weak self] _ in
               DispatchQueue.main.async {
                   self?.handleNoInternetConnection()
               }
           }
           
           reachability.whenReachable = { [weak self] _ in
               DispatchQueue.main.async {
                   self?.handleInternetConnectionRestored()
               }
           }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier!")
        }
    }
    var originalNavigationBarAppearance: UINavigationBarAppearance?
    var originalTabBarAppearance: UITabBarAppearance?
    
    func showNoInternetAlert(message: String, secondMessage: String) {
        if originalNavigationBarAppearance == nil, originalTabBarAppearance == nil {
            originalNavigationBarAppearance = UINavigationBar.appearance().standardAppearance
            originalTabBarAppearance = UITabBar.appearance().standardAppearance
        }
    
        let temporaryNavigationBarAppearance = UINavigationBarAppearance()
        temporaryNavigationBarAppearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = temporaryNavigationBarAppearance
        UINavigationBar.appearance().compactAppearance = temporaryNavigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = temporaryNavigationBarAppearance
        
        let temporaryTabBarAppearance = UITabBarAppearance()
        temporaryTabBarAppearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = temporaryTabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = temporaryTabBarAppearance

        // Создание и показ алерта
        let alertView = UIView()
        alertView.backgroundColor = UIColor(hex: "#0A84FF")
       
        let titleLabel = UILabel()
        titleLabel.text = message
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "SFProDisplay-Bold", size: 16)
       
        let subTitleLabel = UILabel()
        subTitleLabel.text = secondMessage
        subTitleLabel.textColor = .white
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        
        alertView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(alertView).offset(56)
            make.centerX.equalTo(alertView)
        }
        alertView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalTo(alertView)
        }
        
        view.addSubview(alertView)
        alertView.frame = CGRect(x: 0, y: -107, width: view.frame.width, height: 107)
        
        UIView.animate(withDuration: 0.5, animations: {
            alertView.frame.origin.y = 0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 3, options: [], animations: {
                alertView.frame.origin.y = -107
            }) { _ in
                alertView.removeFromSuperview()
                
                if let originalNavigationBarAppearance = self.originalNavigationBarAppearance,
                   let originalTabBarAppearance = self.originalTabBarAppearance {
                    UINavigationBar.appearance().standardAppearance = originalNavigationBarAppearance
                    UINavigationBar.appearance().compactAppearance = originalNavigationBarAppearance
                    UINavigationBar.appearance().scrollEdgeAppearance = originalNavigationBarAppearance
                    
                    UITabBar.appearance().standardAppearance = originalTabBarAppearance
                    UITabBar.appearance().scrollEdgeAppearance = originalTabBarAppearance
                }
            }
        }
    }
    
    private func setupUI(){
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(234)
            make.centerX.equalToSuperview()
            make.height.equalTo(203)
            make.width.equalTo(190)
        }
        
        view.addSubview(userButton)
        userButton.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
            
        }
        view.addSubview(userButtonDescriptionLabel)
        userButtonDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(userButton.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            
        }
        
        view.addSubview(adminButton)
        adminButton.snp.makeConstraints { make in
            make.top.equalTo(userButtonDescriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
            
        }
        
        view.addSubview(adminButtonDescriptionLabel)
        adminButtonDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(adminButton.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            
        }
       
    }
    private func handleNoInternetConnection() {
        showNoInternetAlert(message: "Нет соединения с интернетом", secondMessage: "Проверьте подключение к интернету")
        userButton.isEnabled = false
        adminButton.isEnabled = false
    }


    private func handleInternetConnectionRestored() {
        userButton.isEnabled = true
        adminButton.isEnabled = true
    }
    @objc func userButtonTapped() {
        let vc = ClientChoiceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func adminButtonTapped() {
        let vc = AdminLoginView()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
}
