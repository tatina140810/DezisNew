import UIKit

class ClientLoginViewController: UIViewController, UITextFieldDelegate {
    
    private var validationTimer: Timer?
    
    // MARK: - Create UI Elements
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image8)
        return image
    }()
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "С возвращением!"
        view.font = UIFont.systemFont(ofSize: 28)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nameTextField = TextFieldSettings().textFieldMaker(placeholder: "Имя")
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "Email")
   
    private var errorMasageLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 12)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = .red
        view.isHidden = true
        return view
    }()
    
    private var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle("Регистрация", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Войти", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#BABBBD")
        view.layer.cornerRadius = 8
        view.isEnabled = false
        view.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var supportContactLabel: UILabel = {
        let view = UILabel()
        view.text = "Не удалось войти? Связаться"
        view.font = UIFont(name: "Roboto", size: 19)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createAttributedText()
        
       
        nameTextField.delegate = self
        emailTextField.delegate = self
        
    
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Setup UI Elements
    private func setupUI() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(83)
            make.centerX.equalToSuperview()
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
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(errorMasageLabel)
        errorMasageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(errorMasageLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.height.equalTo(48)
        }
        
        view.addSubview(supportContactLabel)
        supportContactLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(20)
        }
    }
    
    private func createAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: supportContactLabel,
            fullText: "Не удалось войти? Связаться",
            tappableText: "Связаться",
            tapTarget: self,
            action: #selector(attributedTextTapped)
        )
    }
    
    // MARK: - Validate TextFields on Change
    @objc private func textFieldDidChange() {

        errorMasageLabel.isHidden = true
        resetValidationTimer()
    }
    
    // MARK: - Reset Validation Timer
    private func resetValidationTimer() {
       
        validationTimer?.invalidate()
        validationTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(validateAccountAndPassword), userInfo: nil, repeats: false)
    }
    
    // MARK: - TextField Validation
    @objc private func validateAccountAndPassword() {
        guard let account = nameTextField.text, !account.isEmpty,
              let password = emailTextField.text, !password.isEmpty else {
            errorMasageLabel.text = "Пожалуйста, заполните все поля."
            errorMasageLabel.isHidden = false
            return
        }
        
        do {
            let savedPassword = try KeychainManager.retrievePassword(for: account)
            if savedPassword == password {
                loginButton.isEnabled = true
                loginButton.backgroundColor = UIColor(hex: "#0688C1")
            } else {
                nameTextField.layer.borderColor = UIColor.red.cgColor
                nameTextField.layer.borderWidth = 1.0
                emailTextField.layer.borderColor = UIColor.red.cgColor
                emailTextField.layer.borderWidth = 1.0
                
                loginButton.isEnabled = false
                errorMasageLabel.text = "Извините, введен неверный логин или email. Пожалуйста, проверьте правильность введенных данных и попробуйте снова."
                errorMasageLabel.isHidden = false
            }
        } catch let error as KeychainError {
            switch error {
            case .itemNotFound:
                nameTextField.layer.borderColor = UIColor.red.cgColor
                nameTextField.layer.borderWidth = 1.0
                emailTextField.layer.borderColor = UIColor.red.cgColor
                emailTextField.layer.borderWidth = 1.0
                
                loginButton.isEnabled = false
                errorMasageLabel.text = "Извините, введен неверный логин или email. Пожалуйста, проверьте правильность введенных данных и попробуйте снова."
                errorMasageLabel.isHidden = false
            case .duplicateItem:
                print("Duplicate item found in Keychain.")
            case .unknown(let status):
                print("Unknown error with status: \(status)")
            }
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func signUpButtonTapped() {
        let vc = NewUserRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func loginButtonTapped() {
        print("Login successful!")
        let vc = ClientTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func attributedTextTapped() {
        print("Support contact tapped!")
    }
}
