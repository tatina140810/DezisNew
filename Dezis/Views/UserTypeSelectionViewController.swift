import UIKit

class UserTypeSelectionViewController: UIViewController {

// Mark: - Create UI Elements
    
    private var titleLabel = LabelSettings().labelMaker(text: "Добро пожаловать!", font: UIFont.boldSystemFont(ofSize: 28))
        
    private var userTypeLabel = LabelSettings().labelMaker(text: "Выберети тип пользователя", font: UIFont.systemFont(ofSize: 19))
    
    private var adminButton = ButtonSettings().buttonMaker(title: "Администратор", target: self, action: #selector(adminButtonTapped), for: .touchUpInside)
       
    private var clientButton = ButtonSettings().buttonMaker(title: "Клиент", target: self, action: #selector(clientButtonTapped), for: .touchUpInside)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }
    
    // Mark: - Setup UI Elements
    private func setupUI(){
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
        ])
        view.addSubview(userTypeLabel)
        NSLayoutConstraint.activate([
            userTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            userTypeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 279),
        ])
        view.addSubview(adminButton)
        NSLayoutConstraint.activate([
            adminButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            adminButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            adminButton.heightAnchor.constraint(equalToConstant: 48),
            adminButton.topAnchor.constraint(equalTo: userTypeLabel.bottomAnchor, constant: 30),
        ])
        view.addSubview(clientButton)
        NSLayoutConstraint.activate([
            clientButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clientButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clientButton.heightAnchor.constraint(equalToConstant: 48),
            clientButton.topAnchor.constraint(equalTo: adminButton.bottomAnchor, constant: 24),
        ])
    }
// Mark: - Navigation
    
    @objc func adminButtonTapped(){
        let vc = AdminLoginViewController()
        navigationController?.pushViewController(vc, animated: true)

        
    }
    @objc func clientButtonTapped(){
        let vc = ClientLoginViewController()
        navigationController?.pushViewController(vc, animated: true)

        
    }
}

