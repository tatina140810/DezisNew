
import UIKit

struct UserVerify{
    
    var email: String
    var otp: String
}

protocol IСonfirmationСodeViewController {
    func loginFailed(error: Error)
}


class СonfirmationСodeViewController: UIViewController, IСonfirmationСodeViewController {
    
    var presenter: IСonfirmationСodePresenter?
    var email: String
    
        init(email: String) {
            self.email = email
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
    
    private var codeLabel: UILabel = {
        let view = UILabel()
        view.text = "Введите код"
        view.font = UIFont(name: "SFProText-Bold", size: 24)
        view.textColor = .white
        return view
    }()
    
    private var confirmationLabel: UILabel = {
        let view = UILabel()
        view.text = "Мы отправили вам код на почту"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 18)
        view.textColor = .white
        return view
    }()
    
    
    private var otpTextField = TextFieldSettings().textFieldMaker(placeholder: "", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var placeholderLabel: UILabel = {
        let view = UILabel()
        view.text = "Код:"
        view.font = UIFont(name: "SFProText-Regular", size: 14)
        view.textColor = .white
        return view
    }()
   
    private lazy var resendButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("Отправить снова", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        button.setTitleColor(UIColor(hex: "#5FBEF4"), for: .normal)
        button.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
        return button
    }()
    private var errorMasageLabel: UILabel = {
        let view = UILabel()
        view.text = "Код введен не верно"
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.textColor = .red
        view.isHidden = true
        return view
    }()
    private var timerLabel: UILabel = {
        let view = UILabel()
        view.text = "через 1:00 минуту"
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.textColor = .white
        view.isHidden = false
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("Продолжить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#0A84FF")
        view.layer.cornerRadius = 12
        view.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return view
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
    private var timer: Timer?
       private var timeRemaining = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        createAttributedText()
        createPrivaciAttributedText()
        presenter = СonfirmationСodePresenter(view: self)
        keyBoardSetUp()
        dismissKeyboardGesture()
        startTimer()
        navigationItem.backButtonTitle = "Назад"
                
    }
private func startTimer() {
       timeRemaining = 60
       updateTimerLabel()
       resendButton.isEnabled = false

       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
   }

    @objc private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            resendButton.isEnabled = true
            resendButton.setTitleColor(UIColor(hex: "#0A84FF"), for: .normal)
            
            resetErrorState()
        }
    }
    private func resetErrorState() {
        otpTextField.layer.borderColor = UIColor.clear.cgColor
        otpTextField.layer.borderWidth = 0.0
        errorMasageLabel.isHidden = true
    }

   private func updateTimerLabel() {
       timerLabel.text = "через 0:\(timeRemaining) секунд"
       errorMasageLabel.isHidden = true
   }

   @objc private func resendButtonTapped() {
       presenter?.resendOtp()
       startTimer()
       otpTextField.text = ""
       errorMasageLabel.isHidden = false
   }
   
    
    private func setupUI(){
        
        view.addSubview(codeLabel)
        codeLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(293)
            make.centerX.equalToSuperview()
        }
       
        view.addSubview(confirmationLabel)
        confirmationLabel.snp.makeConstraints {make in
            make.top.equalTo(codeLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        view.addSubview(otpTextField)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: otpTextField.frame.height))
        otpTextField.leftView = paddingView
        otpTextField.leftViewMode = .always
        otpTextField.snp.makeConstraints {make in
            make.top.equalTo(confirmationLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        otpTextField.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        
        view.addSubview(errorMasageLabel)
        errorMasageLabel.snp.makeConstraints {make in
            make.top.equalTo(otpTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        view.addSubview(resendButton)
        resendButton.snp.makeConstraints {make in
            make.top.equalTo(otpTextField.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(16)
        }
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints {make in
            make.top.equalTo(otpTextField.snp.bottom).offset(13)
            make.leading.equalTo(resendButton.snp.trailing).offset(3)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(24)
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
    func loginSuccess() {
        print("Успешный вход")


    }
    func loginFailed(error: Error) {
        let errorMessage = error.localizedDescription
        print("Ошибка входа: \(errorMessage)")
        displayError(errorMessage)
    }
    private func displayError(_ message: String) {
            otpTextField.layer.borderColor = UIColor.red.cgColor
            otpTextField.layer.borderWidth = 1.5
            otpTextField.layer.cornerRadius = 8
            errorMasageLabel.text = message
            errorMasageLabel.isHidden = false
        
    }
    @objc func attributedTextTapped() {
        print("Условием продажи")
    }
    @objc func attributedPrivaciTextTapped() {
        print("Положения о конфиденциальности")
    }
    @objc func nextButtonTapped(){

            guard let otp = otpTextField.text, !otp.isEmpty else {
                let redPlaceholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
                
                otpTextField.attributedPlaceholder = NSAttributedString(
                    string: "Код введен неверно",
                    attributes: redPlaceholderAttributes
                )
                otpTextField.layer.borderColor = UIColor.red.cgColor
                otpTextField.layer.borderWidth = 1.0
                return
            }
            
         
        presenter?.verifyUser(email: email, otp: otp) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return } 
                
                switch result {
                case .success(let message):
                    print("Login successful: \(message)")
                    self.loginSuccess()
                    
                    let entryAllowedVC = EntryAllowedViewController()
                    self.navigationController?.pushViewController(entryAllowedVC, animated: true)
                    
                case .failure(let error):
                    print("Login failed: \(error)")
                    self.loginFailed(error: error)
                }
            }
        }

        }
        
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}
