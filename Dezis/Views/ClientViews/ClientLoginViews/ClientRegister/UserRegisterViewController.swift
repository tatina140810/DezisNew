import UIKit
import SnapKit


class UserRegisterViewController: UIViewController {
    private let maxNumberCount = 12
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont(name: "SFProText-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var nameTextField = TextFieldSettings().textFieldMaker(placeholder: "ФИО*", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "Электронная почта*", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var numberTextField = TextFieldSettings().textFieldMaker(placeholder: "+996 ___ ___ ___*", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var passwordTextField = TextFieldSettings().textFieldMaker(placeholder: "Пароль*", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        label.textColor = .red
        label.textAlignment = .left
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("Продолжить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#0A84FF")
        view.layer.cornerRadius = 12
        view.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
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
    private var emailErrorMessageLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .red
        view.isHidden = true
        return view
    }()
    private var numberErrorMessageLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .red
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        createAttributedText()
        createPrivaciAttributedText()
        keyBoardSetUp()
        navigationItem.backButtonTitle = "Назад"
        numberTextField.delegate = self
        nameTextField.delegate = self
        numberTextField.keyboardType = .numberPad
    }
    
    private func setupUI() {
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(208)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        view.addSubview(emailErrorMessageLabel)
        emailErrorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        view.addSubview(numberTextField)
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        view.addSubview(numberErrorMessageLabel)
        numberErrorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.passwordRules = nil
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.isSecureTextEntry = true
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(24)
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
        view.addSubview(passwordErrorLabel)
        passwordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(passwordErrorLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
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
    
    @objc func attributedTextTapped() {
        let vc = PrivacyPage()
        navigationController?.pushViewController(vc, animated: true)
        print("Условием продажи")
    }
    @objc func attributedPrivaciTextTapped() {
        print("Положения о конфиденциальности")
        let vc = ConfidantionalyPage()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc func nextButtonTapped() {
        
        emailErrorMessageLabel.isHidden = true
        numberErrorMessageLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        emailTextField.layer.borderWidth = 0
        numberTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
        
        guard let username = nameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let number = numberTextField.text, !number.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            
            if nameTextField.text?.isEmpty == true {
                numberTextField.layer.borderColor = UIColor.red.cgColor
                numberTextField.layer.borderWidth = 1.0
            }
            if emailTextField.text?.isEmpty == true {
                emailErrorMessageLabel.text = "Введите корректные данные"
                emailErrorMessageLabel.isHidden = false
                emailTextField.layer.borderColor = UIColor.red.cgColor
                emailTextField.layer.borderWidth = 1.0
            }
            
            if numberTextField.text?.isEmpty == true {
                numberErrorMessageLabel.text = "Введите корректные данные"
                numberErrorMessageLabel.isHidden = false
                numberTextField.layer.borderColor = UIColor.red.cgColor
                numberTextField.layer.borderWidth = 1.0
            }
            if passwordTextField.text?.isEmpty == true {
                passwordTextField.layer.borderColor = UIColor.red.cgColor
                passwordTextField.layer.borderWidth = 1.0
            }
            
            return
        }
        if !isValidName(username) {
            nameTextField.layer.borderColor = UIColor.red.cgColor
            nameTextField.layer.borderWidth = 1.0
            return
        }
        
        if !isValidEmail(email) {
            emailErrorMessageLabel.text = "Введите корректные данные"
            emailErrorMessageLabel.isHidden = false
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailTextField.text = ""
            return
        }
        if !isValidPhoneNumber(number) {
            numberErrorMessageLabel.text = "Введите корректные данные"
            numberErrorMessageLabel.isHidden = false
            numberTextField.layer.borderColor = UIColor.red.cgColor
            numberTextField.layer.borderWidth = 1.0
            numberTextField.text = ""
            return
        }
        if !isValidPassword(password) {
            passwordErrorLabel.text = "Пароль должен содержать заглавные и строчные буквы, цифры и спец символы, иметь длину 8 или более символов"
            passwordErrorLabel.isHidden = false
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1.0
            return
        }
        emailTextField.layer.borderWidth = 0
        nameTextField.layer.borderWidth = 0
        numberTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
        
        
        UserDefaults.standard.set(email, forKey: "email")
        
        
        let userInfo = UserInfo(username: username,
                                password: password,
                                email: email,
                                number: number,
                                address: "",
                                apartmentNumber: "")
        
        let vc = UserRegisterBuilder.build(userinfo: userInfo)
        navigationController?.pushViewController(vc, animated: true)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func isValidPhoneNumber(_ number: String) -> Bool {
        guard number.hasPrefix("+996") else { return false }
        
        let sanitizedNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        return sanitizedNumber.count == 12
    }
    
    
    func isValidPassword(_ password: String) -> Bool {
        // Минимальная длина
        guard password.count >= 8 else { return false }
        
        // Проверка наличия строчных букв (включая кириллицу)
        let lowercaseRegex = ".*[a-zа-яё]+.*"
        let lowercaseTest = NSPredicate(format: "SELF MATCHES %@", lowercaseRegex)
        guard lowercaseTest.evaluate(with: password) else { return false }
        
        // Проверка наличия заглавных букв (включая кириллицу)
        let uppercaseRegex = ".*[A-ZА-ЯЁ]+.*"
        let uppercaseTest = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
        guard uppercaseTest.evaluate(with: password) else { return false }
        
        // Проверка наличия цифр
        let digitRegex = ".*[0-9]+.*"
        let digitTest = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        guard digitTest.evaluate(with: password) else { return false }
        
        // Проверка наличия специальных символов
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        let specialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        guard specialCharacterTest.evaluate(with: password) else { return false }
        
        // Все проверки пройдены
        return true
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else {return "+"}
        let range  = NSString (string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        if shouldRemoveLastDigit, !number.isEmpty {
            number.removeLast()
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let patern = "(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: patern, with: "$1 $2 $3", options: .regularExpression, range: regRange)
        } else {
            let patern = "(\\d{3})(\\d{3})(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: patern, with: "$1 $2-$3-$4 ", options: .regularExpression, range: regRange)
        }
        return "+" + number
    }
    
    private func updateNextButtonState() {
        let isFormValid = isValidEmail(emailTextField.text ?? "") &&
        !(nameTextField.text?.isEmpty ?? true) &&
        !(numberTextField.text?.isEmpty ?? true) &&
        !(passwordTextField.text?.isEmpty ?? true)
        
        nextButton.isEnabled = isFormValid
        nextButton.alpha = isFormValid ? 1.0 : 0.5
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension UserRegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
           if textField == nameTextField {
          
               let currentText = textField.text ?? ""
               let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
              
               validateName(newText)
           }
           
           if textField == numberTextField {
      
               let fullString = (textField.text ?? "") + string
               textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
               return false
           }
           
           return true
       }
    func isValidName(_ username: String) -> Bool {
       
            let characterSet = CharacterSet.letters.union(.whitespaces)
            return username.count >= 2 && username.count <= 20 && username.rangeOfCharacter(from: characterSet.inverted) == nil
        }
        
        private func validateName(_ name: String) {
            nameTextField.layer.borderWidth = 0
            nameTextField.layer.borderColor = UIColor.clear.cgColor
            if isValidName(name) {
                nameTextField.layer.borderColor = UIColor.clear.cgColor
                nameTextField.layer.borderWidth = 0
            
            } else {
                nameTextField.layer.borderColor = UIColor.red.cgColor
                nameTextField.layer.borderWidth = 1.0
             
            }
        }
    
    
}
