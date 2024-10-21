import UIKit
import SnapKit

protocol INewUserRegisterViewController {
   
}

class NewUserRegisterViewController: UIViewController, INewUserRegisterViewController {
    
//    let username = ""
//    let email = ""
//    let password = ""
    
  //  private var presenter: IUserRegisterPresenters?
   
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    private var nameTextField = TextFieldSettings().textFieldMaker(placeholder: "ФИО", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "example@gmail.com*", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var passwordTextField = TextFieldSettings().textFieldMaker(placeholder: "Пароль", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var errorLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        view.textColor = .red
        view.textAlignment = .left
        return view
    }()
    
    private var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("Продолжить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#0A84FF")
        view.layer.cornerRadius = 12
        view.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
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
        setupAddTarget()
    }
   
 
    
    // MARK: - Attributed Text Links
    private func setupAddTarget(){
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
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
    
    // MARK: - Setup UI Elements
    
    private func setupUI() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
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
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
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
    
    // MARK: - Target Functions
    
    @objc func attributedTextTapped() {
        print("Условием продажи")
    }
    @objc func attributedPrivaciTextTapped() {
        print("Положения о конфиденциальности")
    }
  
    @objc func nextButtonTapped() {
        guard let username = nameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            
            let redPlaceholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
                    
                    if nameTextField.text?.isEmpty == true {
                        nameTextField.attributedPlaceholder = NSAttributedString(
                            string: "Введите еще раз",
                            attributes: redPlaceholderAttributes
                        )
                    }
                    
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
                nameTextField.layer.borderColor = UIColor.red.cgColor
                    emailTextField.layer.borderColor = UIColor.red.cgColor
                    passwordTextField.layer.borderColor = UIColor.red.cgColor
                    nameTextField.layer.borderWidth = 1.0
                    emailTextField.layer.borderWidth = 1.0
                    passwordTextField.layer.borderWidth = 1.0
            return
        }
        
//        if presenter == nil {
//            presenter = UserRegisterPresenters(view: self, secondView: UserRegisterSecondPageViewController())
//        }
        
     //   presenter?.updateUserInfo(username: username, email: email, password: password)
        let userInfo = UserInfo(username: username, password: password, email: email, address: "", appartmentNumber: "")
        let vc = UserRegisterBuilder.build(userinfo: userInfo)
       // vc.modalPresentationStyle = .fullScreen
       // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }


    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    @objc func backButtonTapped(){
       // let vc = ClientChoiceViewController()
     //   vc.modalPresentationStyle = .fullScreen
      //  present(vc, animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
