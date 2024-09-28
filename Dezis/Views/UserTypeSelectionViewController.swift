import UIKit

class UserTypeSelectionViewController: UIViewController {

// Mark: - Create UI Elements
    
    private var titleLabel = LabelSettings().labelMaker(text: "Добро пожаловать!", font: UIFont.boldSystemFont(ofSize: 28))
        
    private var userTypeLabel = LabelSettings().labelMaker(text: "Выберети тип пользователя", font: UIFont.systemFont(ofSize: 19))
    
    private var adminButton: UIButton = {
        let button = UIButton()
        button.setTitle("Администратор", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(hex: "#5191BA")
        button.addTarget(self, action: #selector(adminButtonTapped), for: .touchUpInside)
        return button
    }()
   
    private var clientButton = ButtonSettings().buttonMaker(title: "Клиент", target: self, action: #selector(clientButtonTapped), for: .touchUpInside)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }
    
    // Mark: - Setup UI Elements
    private func setupUI(){
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(135)
        }
            
        view.addSubview(userTypeLabel)
        
        userTypeLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(279)
        }
           
        view.addSubview(adminButton)
        adminButton.snp.makeConstraints{make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(userTypeLabel.snp.bottom).offset(30)
            make.height.equalTo(48)
        }
          
        view.addSubview(clientButton)
        clientButton.snp.makeConstraints {make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
            make.top.equalTo(adminButton.snp.bottom).offset(24)
        }
    }
// Mark: - Navigation
    
    @objc func adminButtonTapped() {
        let vc = AdminLoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @objc func clientButtonTapped(){
        let vc = NewUserRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
}

