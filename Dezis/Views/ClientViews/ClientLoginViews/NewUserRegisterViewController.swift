import UIKit
import SnapKit

class NewUserRegisterViewController: UIViewController {
    
    // MARK: - Create UI Elements
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image8)
        return image
    }()
    
    private var titleLabel = LabelSettings().labelMaker(text: "Регистрация", font: UIFont.systemFont(ofSize: 28))
    
    private var nameTextField = TextFieldSettings().textFieldMaker(placeholder: "Имя*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var phoneNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер телефона*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "Email*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var status = ""
    private var errorLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .red
        view.textAlignment = .left
        return view
    }()
    
    private var loginLabel: UILabel = {
        let view = UILabel()
        view.text = "Уже есть аккаунт? Войти"
        view.font = UIFont(name: "Roboto", size: 8)
        view.textColor = UIColor(hex: "#B5B5B5")
        view.textAlignment = .center
  
        return view
    }()
    
    private var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle("Продолжить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#5191BA")
        view.layer.cornerRadius = 8
       
        return view
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createAttributedText()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Attributed Text Links
    
    private func createAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: loginLabel,
            fullText: "У вас уже есть аккаунт? Войти",
            tappableText: "Войти",
            tapTarget: self,
            action: #selector(attributedTextTapped)
        )
    }
    
    // MARK: - Setup UI Elements
    
    private func setupUI() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(83)
            make.height.width.equalTo(140)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(logoImage.snp.bottom).offset(30)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints{make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)}
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Target Functions
    
    @objc func attributedTextTapped() {
        let vc = ClientLoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func signUpButtonTapped() {
        // Safely fetch the password and account from text fields
        guard let password = emailTextField.text, !password.isEmpty,
              let account = nameTextField.text, !account.isEmpty else {
            nameTextField.layer.borderColor = UIColor.red.cgColor
            nameTextField.layer.borderWidth = 1.0
            phoneNumberTextField.layer.borderColor = UIColor.red.cgColor
            phoneNumberTextField.layer.borderWidth = 1.0
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            
            errorLabel.text = "*Все поля обязательны для заполнения"
            return
        }
        
        do {
           
            status = try KeychainManager.save(password: password.data(using: .utf8) ?? Data(), account: account)
            print("Status: \(status)")
        } catch {
            showAlert(message: "Error saving password: \(error)")
        }
        
        let vc = NewUserRegistratinSecondPageViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

