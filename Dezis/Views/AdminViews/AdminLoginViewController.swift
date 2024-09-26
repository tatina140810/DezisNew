import UIKit

class AdminLoginViewController: UIViewController {
    
    private var loginLabel = LabelSettings().labelMaker(text: "Логин", font: UIFont.systemFont(ofSize: 16))
    
    private var loginTextField = TextFieldSettings().textFieldMaker(placeholder: "от 5 до 20 символов")
    
    private var loginComentLabel = LabelSettings().labelMaker(text: "Допускаются буквы, цифры и символы подчеркивания.", font: UIFont.boldSystemFont(ofSize: 12), textColor: UIColor(hex: "#B5B5B5"))
    
    private var passwordLabel = LabelSettings().labelMaker(text: "Пароль", font: UIFont.systemFont(ofSize: 16))
    
    private lazy var passwordTextField: UITextField = {
        var field = UITextField()
        field.backgroundColor = UIColor(hex: "#F6F6F7")
        field.placeholder = "от 8 до 20 символов"
        field.layer.cornerRadius = 8
        field.translatesAutoresizingMaskIntoConstraints = false
        
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
        rightPaddingView.addSubview(eyeButton)
        eyeButton.center = rightPaddingView.center
        
        field.rightView = rightPaddingView
        field.rightViewMode = .always
        
        return field
    }()
    
    private var passwordComentLabel = LabelSettings().labelMaker(text: "Требуется наличие букв, цифр и специальных символов.", font: UIFont.systemFont(ofSize: 12), textColor: UIColor(hex: "#B5B5B5"))
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hex: "#5191BA")
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var supportContactLabel = LabelSettings().labelMaker(text: "Не удалось войти? Связаться", font: UIFont.systemFont(ofSize: 16))
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createAttributedText()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: supportContactLabel.font.pointSize), range: range)
        
        supportContactLabel.attributedText = attributedString

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(attributedTextTapped))
        supportContactLabel.isUserInteractionEnabled = true
        supportContactLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func loginButtonTapped() {
        let vc = AdminTabBarController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }

    @objc func attributedTextTapped() {
       
        print("Support contact tapped!")
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        
        if let eyeButton = passwordTextField.rightView?.subviews.first as? UIButton {
            let imageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
            eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
