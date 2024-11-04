import UIKit
protocol EntryAllowedView: AnyObject {
    func showError(_ error: String)
}

class EntryAllowedViewController: UIViewController, EntryAllowedView {
    var presenter: IEntryAllowedPresenter?

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
        presenter = EntryAllowedPresenter(view: self, userService: UserNetworkService())
        presenter?.fetchUserData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.loadNextViewController()
            
        }
    }
        
        func showError(_ error: String) {
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
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

    private func loadNextViewController() {
        
        let vc = ClientTabBarController()
        navigationController?.pushViewController(vc, animated: true)
    }

   
}

