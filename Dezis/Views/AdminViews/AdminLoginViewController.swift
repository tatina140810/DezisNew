import UIKit

class AdminLoginViewController: UIViewController {
    // Mark: - Create UI Elements
    
    private var loginLabel = LabelSettings().labelMaker(text: "Логин", font: UIFont.systemFont(ofSize: 19))
    
    private var loginTextField = TextFieldSettings().textFieldMaker(placeholder: "от 5 до 20 символов")
    
    private var loginComentLabel = LabelSettings().labelMaker(text: "Допускаются буквы, цифры и символы подчеркивания.", font: UIFont.boldSystemFont(ofSize: 12), textColor: UIColor(hex: "#B5B5B5"))
    
    private var passwordLabel = LabelSettings().labelMaker(text: "Пароль", font: UIFont.systemFont(ofSize: 19))
      
    private var passwordTextField = TextFieldSettings().textFieldMaker(placeholder: "от 8 до 20 символов")
    
    private var passwordComentLabel = LabelSettings().labelMaker(text: "Требуется наличие букв, цифр и специальных символов.", font: UIFont.systemFont(ofSize: 12), textColor: UIColor(hex: "#B5B5B5"))
        
    private var loginButton = ButtonSettings().buttonMaker(title: "Войти", target: self, action: #selector(loginButtonTapped), for: .touchUpInside)
    
    private var supportContactLabel = LabelSettings().labelMaker(text: "Не удалось войти? Связаться", font: UIFont.systemFont(ofSize: 19))
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createAttributedText()
    }
    
    // Mark: - Setup UI Elements
    private func setupUI() {
        view.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 252),
        ])
        view.addSubview(loginTextField)
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 5),
            loginTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        view.addSubview(loginComentLabel)
        NSLayoutConstraint.activate([
            loginComentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginComentLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 5),
        ])
        view.addSubview(passwordLabel)
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordLabel.topAnchor.constraint(equalTo: loginComentLabel.bottomAnchor, constant: 20),
        ])
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        view.addSubview(passwordComentLabel)
        NSLayoutConstraint.activate([
            passwordComentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordComentLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
        ])
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.topAnchor.constraint(equalTo: passwordComentLabel.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        view.addSubview(supportContactLabel)
        NSLayoutConstraint.activate([
            supportContactLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            supportContactLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
        ])
    }
    
    private func createAttributedText() {
        let fullText = "Не удалось войти? Связаться"
        
        let attributedString = NSMutableAttributedString(string: fullText)

        let range = (fullText as NSString).range(of: "Связаться")
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
        supportContactLabel.attributedText = attributedString

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(attributedTextTapped))
        supportContactLabel.isUserInteractionEnabled = true
        supportContactLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func loginButtonTapped() {
        let vc = SuccessViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func attributedTextTapped() {
       
        print("Support contact tapped!")
    }
}

