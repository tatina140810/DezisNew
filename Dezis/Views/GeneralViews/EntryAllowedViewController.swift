import UIKit

class EntryAllowedViewController: UIViewController{

    private let userService: UserNetworkService
    var email: String?
    
    
    init(userService: UserNetworkService, email: String) {
            self.userService = userService
            self.email = email
            super.init(nibName: nil, bundle: nil)
        }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }


    // Добавляем необходимые UI элементы
    private var entryAllowedImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "entryAllowed")
        return view
    }()
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Пожалуйста, подождите пока администратор даст вам разрешение на вход в приложение!"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
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

       
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.loadNextViewController()
        }

        if let email = email {
            fetchUserData(email: email)
        }
    }

    func fetchUserData(email: String) {
        guard !email.isEmpty else {
            print("Error: Email is empty")
            return
        }
        
        userService.getUserProfile(email: email) { result in
            switch result {
            case .success(let response):
                print("Registration successful with response: \(response)")
                
            case .failure(let error):
                print (error)
                
            }
        }
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

    private func loadNextViewController() {
        let vc = ClientTabBarController()
        navigationController?.pushViewController(vc, animated: true)
    }

   
}
extension EntryAllowedViewController: RegistrationDelegate {
    func didRegisterUser(email: String) {
        self.email = email
        fetchUserData(email: email)
    }
}

