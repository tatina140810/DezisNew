import UIKit
protocol EntryAllowedView: AnyObject {
    
    func showError(_ error: String)
    func updateUserProfile(_ userProfile: UserProfile)
    func showEntryDeniedScreen()
}

class EntryAllowedViewController: UIViewController, EntryAllowedView {
    var userId: Int?
    var statusCheckTimer: Timer?
    
    
    var presenter: IEntryAllowedPresenter?
    
    private var entryAllowedImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "entryAllowed")
        return view
    }()
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Пожалуйста, подождите. Aдминистратор даст Вам разрешение на вход в приложение в течение 24 часов!"
        view.font = UIFont(name: "SFProText-Regular", size: 16)
        view.textAlignment = .center
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        navigationController?.navigationBar.isHidden = true
        presenter = EntryAllowedPresenter(view: self, userService: UserNetworkService())
        startCheckingUserStatus()
        
    }
    
    func showError(_ error: String) {
        guard navigationController?.topViewController === self else { return }
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(entryAllowedImage)
        entryAllowedImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(152)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(276)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(entryAllowedImage.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(45)
        }
    }
    func startCheckingUserStatus() {
        statusCheckTimer = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(checkUserStatus), userInfo: nil, repeats: true)
    }
    
    func stopCheckingUserStatus() {
        statusCheckTimer?.invalidate()
        statusCheckTimer = nil
    }
    func updateUserProfile(_ userProfile: UserProfile) {
        stopCheckingUserStatus()
        UserDefaults.standard.set(true, forKey: "confirmed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.loadNextViewController()
            
        }
    }
    
    private func loadNextViewController() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            print("Не удалось получить доступ к SceneDelegate")
            return
        }

        let clientTabBarVC = ClientTabBarController()
        window.rootViewController = clientTabBarVC
        window.makeKeyAndVisible()
    }
    
    @objc func checkUserStatus() {
        presenter?.fetchUserData()
    }
    deinit {
        stopCheckingUserStatus()
    }
    func showEntryDeniedScreen() {
        let deniedVC = EntryDeniedViewController()
        deniedVC.modalPresentationStyle = .fullScreen
        present(deniedVC, animated: true, completion: nil)
    }
    
    
}

