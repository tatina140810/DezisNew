import UIKit


class NewUserRegisterViewController: UIViewController {
    
    // Mark: - Create UI Elements
    
    private var titleLabel = LabelSettings().labelMaker(text: "Регистрация", font: UIFont.systemFont(ofSize: 28))
    
    private var nameTextField = TextFieldSettings().textFieldMaker(placeholder: "Имя*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var phoneNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер телефона*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "Email*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var orderNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер заказа", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var adressTextField = TextFieldSettings().textFieldMaker(placeholder: "Адрес*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var houseNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер дома*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var apartmentNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер квартиры*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var privacyCheckMarkButton = CheckboxButton()
    private var consentCheckMarkButton = CheckboxButton()
    
    private var privacyAgreementLabel: UILabel = {
        let view = UILabel()
        view.text = "Я принимаю политику конфиденциальности"
        view.font = UIFont(name: "Roboto", size: 8)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var consentDataLabel: UILabel = {
        let view = UILabel()
        view.text = "Согласие на обработку персональных данных"
        view.font = UIFont(name: "Roboto", size: 8)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var loginLabel: UILabel = {
        let view = UILabel()
        view.text = "У вас уже есть аккаунт? Войти"
        view.font = UIFont(name: "Roboto", size: 8)
        view.textColor = UIColor(hex: "#B5B5B5")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle( "Зарегистрироваться", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#5191BA")
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var supportContactLabel: UILabel = {
        let view = UILabel()
        view.text = "Не удалось зарегистрироваться? Связаться"
        view.font = UIFont(name: "Roboto", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createAttributedText()
        createSecondAttributedText()
        
    }
    // Mark: - Attributed Text Links
    
    private func createAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: loginLabel,
            fullText: "У вас уже есть аккаунт? Войти",
            tappableText: "Войти",
            tapTarget: self,
            action: #selector(attributedTextTapped))
    }
    
    private func createSecondAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: supportContactLabel,
            fullText: "Не удалось зарегистрироваться? Связаться",
            tappableText: "Связаться",
            tapTarget: self,
            action: #selector(attributedSecondTextTapped))
    }
    
    // Mark: - Setup UI Elements
    
    private func setupUI(){
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(65)
        }
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints{make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(orderNumberTextField)
        orderNumberTextField.snp.makeConstraints{make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(adressTextField)
        adressTextField.snp.makeConstraints{make in
            make.top.equalTo(orderNumberTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(houseNumberTextField)
        houseNumberTextField.snp.makeConstraints{make in
            make.top.equalTo(adressTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(apartmentNumberTextField)
        apartmentNumberTextField.snp.makeConstraints{make in
            make.top.equalTo(houseNumberTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(privacyCheckMarkButton)
        privacyCheckMarkButton.snp.makeConstraints{make in
            make.top.equalTo(apartmentNumberTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        view.addSubview(privacyAgreementLabel)
        privacyAgreementLabel.snp.makeConstraints { make in
            make.leading.equalTo(privacyCheckMarkButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(apartmentNumberTextField.snp.bottom).offset(10)
            
        }
        view.addSubview(consentCheckMarkButton)
        consentCheckMarkButton.snp.makeConstraints{make in
            make.top.equalTo(privacyCheckMarkButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        view.addSubview(consentDataLabel)
        consentDataLabel.snp.makeConstraints { make in
            make.leading.equalTo(consentCheckMarkButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(privacyAgreementLabel.snp.bottom).offset(8)
        }
        
        
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints{make in
            make.top.equalTo(consentDataLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints{make in
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(supportContactLabel)
        supportContactLabel.snp.makeConstraints{make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            
        }
    }
    // Mark: - Target functions
    
    @objc func attributedTextTapped() {
        
        print("Login tapped!")
    }
    @objc func attributedSecondTextTapped(){
        print("Support contact tapped!")
    }
    @objc func signUpButtonTapped(){
        let vc = СonfirmationСodeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    @objc func loginButtonTapped(){
        let vc = NewUserRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
}


