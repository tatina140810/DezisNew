import UIKit

class ClientLoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Create UI Elements
    
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
        backButtonSetup()
    }
    
    private func backButtonSetup(){
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = backButton
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
        print("Login successful!")
        let vc = EntryAllowedViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func attributedTextTapped() {
        print("Support contact tapped!")
    }
    @objc func attributedPrivaciTextTapped() {
        print("Support contact tapped!")
    }
    @objc private func backButtonTapped() {
      //  let vc = UINavigationController(rootViewController: ClientChoiceViewController())
       // navigationController?.pushViewController(vc, animated: true)
        navigationController?.popViewController(animated: true)
    }
}
