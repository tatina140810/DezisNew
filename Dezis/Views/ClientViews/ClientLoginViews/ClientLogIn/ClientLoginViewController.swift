import UIKit
import Moya

struct UserLoginInfo{
    
    var email: String
    var password: String
}

protocol IClientLoginViewController {
    func loginFailed(error: Error)
}

class ClientLoginViewController: UIViewController, UITextFieldDelegate, IClientLoginViewController {
    
    func loginFailed(error: Error) {
        let errorMessage = error.localizedDescription
        print("Ошибка входа: \(errorMessage)")
    }
    
    var presenter: IClientLoginPresenter?
    
    let network = UserNetworkService()
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Вход"
        view.font = UIFont(name: "SFProText-Bold", size: 24)
        view.textAlignment = .center
        view.textColor = .white
        
        return view
    }()
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "Электронная почта*", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var passwordTextField = TextFieldSettings().textFieldMaker(placeholder: "Пароль*", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var emailErrorMasageLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .red
        view.isHidden = true
        return view
    }()
    private var passwordErrorMasageLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .red
        view.isHidden = true
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 14)
        button.titleLabel?.numberOfLines = 0
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Продолжить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#0A84FF")
        view.layer.cornerRadius = 8
        view.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        view.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return view
    }()
    private lazy var passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    private var privacyLabel: UILabel = {
        let view = UILabel()
        view.text = "Выбирая «Зарегистрироваться», вы подтверждаете свое согласие с Условием продажи и принимаете условия"
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    private var confidentialityLabel: UILabel = {
        let view = UILabel()
        view.text = "Положения о конфиденциальности."
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        createAttributedText()
        createPrivaciAttributedText()
        keyBoardSetUp()
        presenter = ClientLoginPresenter(view: self)
        dismissKeyboardGesture()
        navigationItem.backButtonTitle = "Назад"
    }
    
    func keyBoardSetUp(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardSize.cgRectValue.height
            self.view.frame.origin.y = -keyboardHeight / 2
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc private func handleForgotPassword() {
        let vc = ClientEmailConfirmView()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupUI() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(258)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        view.addSubview(emailErrorMasageLabel)
        emailErrorMasageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailErrorMasageLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        view.addSubview(passwordToggleButton)
        passwordToggleButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-16)
            make.width.height.equalTo(24)
        }
        
        view.addSubview(passwordErrorMasageLabel)
        passwordErrorMasageLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordErrorMasageLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        view.addSubview(confidentialityLabel)
        confidentialityLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(privacyLabel)
        privacyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(confidentialityLabel.snp.top).offset(-3)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    private func createAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: privacyLabel,
            fullText: "Выбирая «Зарегистрироваться», вы подтверждаете свое согласие с Условием продажи и принимаете условия",
            tappableText: "Условием продажи",
            tapTarget: self,
            action: #selector(attributedTextTapped)
        )
    }
    private func createPrivaciAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: confidentialityLabel,
            fullText: "Положения о конфиденциальности",
            tappableText: "Положения о конфиденциальности",
            tapTarget: self,
            action: #selector(attributedPrivaciTextTapped)
        )
    }
    
    @objc func loginButtonTapped() {
        
        emailErrorMasageLabel.isHidden = true
        passwordErrorMasageLabel.isHidden = true
        emailTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0

        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                  
            if emailTextField.text?.isEmpty == true {
                emailErrorMasageLabel.text = "Введите корректные данные"
                emailErrorMasageLabel.isHidden = false
                emailTextField.layer.borderColor = UIColor.red.cgColor
                emailTextField.layer.borderWidth = 1.0
            }
          
            if passwordTextField.text?.isEmpty == true {
                passwordErrorMasageLabel.text = "Введите корректные данные"
                passwordErrorMasageLabel.isHidden = false
                passwordTextField.layer.borderColor = UIColor.red.cgColor
                passwordTextField.layer.borderWidth = 1.0
            }
            
            return
        }
        
     
        if !isValidEmail(email) {
            emailErrorMasageLabel.text = "Введите корректные данные"
            emailErrorMasageLabel.isHidden = false
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailTextField.text = ""
            return
        }
        
     
        emailTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
        
        presenter?.loginUser(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print("Login successful: \(message)")
                    self?.loginSuccess()
                    
                case .failure(let error):
                    print("Login failed: \(error)")
                     
                    self?.emailErrorMasageLabel.text = "Введите корректные данные"
                    self?.passwordErrorMasageLabel.text = "Введите корректные данные"
                    self?.emailErrorMasageLabel.isHidden = false
                    self?.passwordErrorMasageLabel.isHidden = false
                    self?.emailTextField.layer.borderColor = UIColor.red.cgColor
                    self?.emailTextField.layer.borderWidth = 1.0
                    self?.passwordTextField.layer.borderColor = UIColor.red.cgColor
                    self?.passwordTextField.layer.borderWidth = 1.0
                }
            }
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func loginSuccess() {
        let vc = ClientTabBarController()
        navigationController?.pushViewController(vc, animated: true)
        print("Успешный вход")
      
    }
    
    func loginFailed(error: String) {
        
        print("Ошибка входа: \(error)")
        
    }
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    
    @objc func attributedTextTapped() {
        let vc = ConfidantionalyPage()
        navigationController?.pushViewController(vc, animated: true)
        print("Support contact tapped!")
    }
    @objc func attributedPrivaciTextTapped() {
        let vc = PrivacyPage()
        navigationController?.pushViewController(vc, animated: true)
        print("Support contact tapped!")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
