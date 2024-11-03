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
        displayError(errorMessage)
    }
    
    var presenter: IClientLoginPresenter?
    
    let network = UserNetworkService()
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Вход"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        view.textAlignment = .center
        view.textColor = .white
        
        return view
    }()
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "example@gmail.com", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var passwordTextField = TextFieldSettings().textFieldMaker(placeholder: "Пароль", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var errorMasageLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = .red
        view.isHidden = true
        return view
    }()
    private var forgotPasswordLabel: UILabel = {
        let view = UILabel()
        view.text = "Забыли пароль?"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Продолжить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#0A84FF")
        view.layer.cornerRadius = 8
        view.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        view.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return view
    }()
    private var privacyLabel: UILabel = {
        let view = UILabel()
        view.text = "Выбирая «Зарегистрироваться», вы подтверждаете свое согласие с Условием продажи и принимаете условия"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    private var confidentialityLabel: UILabel = {
        let view = UILabel()
        view.text = "Положения о конфиденциальности."
        view.font = UIFont(name: "SFProDisplay-Regular", size: 12)
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
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

    private func setupUI() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(258)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(errorMasageLabel)
        errorMasageLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
        }
        view.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(errorMasageLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(25)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
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
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            
            let redPlaceholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
            
            if emailTextField.text?.isEmpty == true {
                emailTextField.attributedPlaceholder = NSAttributedString(
                    string: "Введите еще раз",
                    attributes: redPlaceholderAttributes
                )
            }
            
            if passwordTextField.text?.isEmpty == true {
                passwordTextField.attributedPlaceholder = NSAttributedString(
                    string: "Введите еще раз",
                    attributes: redPlaceholderAttributes
                )
            }
            
            emailTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            passwordTextField.layer.borderWidth = 1.0
            
            return
        }
        
        if !isValidEmail(email) {
            emailTextField.attributedPlaceholder = NSAttributedString(
                string: "Неверный формат email",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
            )
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            return
        }
        
        emailTextField.text = email
        passwordTextField.text = password
       
        presenter?.loginUser(email: email, password: password) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let message):
                        print("Login successful: \(message)")
                        self?.loginSuccess()
                        
                    case .failure(let error):
                        print("Login failed: \(error)")
                        self?.loginFailed(error: error)
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
        
        displayError(error)
    }
    
    private func displayError(_ message: String) {
        errorMasageLabel.text = message
        errorMasageLabel.isHidden = false
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
    @objc private func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
