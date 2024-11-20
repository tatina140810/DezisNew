import UIKit
import Moya

struct UserInfo {
    let username: String
    let password: String
    let email: String
    let number: String
    var address: String
    var apartmentNumber: String
}

final class UserRegisterBuilder {
    class func build(userinfo: UserInfo) -> UIViewController {
        let view = UserRegisterSecondPageViewController()
        let presenter = UserRegisterPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.userInfo = userinfo
        return view
    }
}

protocol IUserRegisterSecondPageViewController {
    
}
class UserRegisterSecondPageViewController: UIViewController, IUserRegisterSecondPageViewController {
    
    var presenter: IUserRegisterPresenters?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont(name: "SFProText-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var adressTextField = TextFieldSettings().textFieldMaker(placeholder: "Адрес*", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var apartmentNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер дома/квартиры*", backgroundColor: UIColor(hex: "#2B373E"))
    private var adressErrorMessageLabel: UILabel = {
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
    private var errorLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.textColor = .red
        view.textAlignment = .left
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
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        createAttributedText()
        createPrivaciAttributedText()
        navigationItem.backButtonTitle = "Назад"
        keyBoardSetUp()
        
    }
    
   
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
            make.top.equalToSuperview().offset(281)
        }
        
        view.addSubview(adressTextField)
        adressTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        view.addSubview(adressErrorMessageLabel)
        adressErrorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(adressTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(apartmentNumberTextField)
        apartmentNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(adressTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        view.addSubview(numberErrorMessageLabel)
        numberErrorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(apartmentNumberTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            
        }
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(numberErrorMessageLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            
        }
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }


        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(10)
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
    
    @objc private func nextButtonTapped() {
        activityIndicator.startAnimating()
               
               DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                   self.activityIndicator.stopAnimating()
               }
        errorLabel.isHidden = false
        errorLabel.textColor = .white
 
        guard let address = adressTextField.text, !address.isEmpty,
              let apartmentNumber = apartmentNumberTextField.text, !apartmentNumber.isEmpty else {
            
            if adressTextField.text?.isEmpty == true {
                adressErrorMessageLabel.text = "Введите корректные данные"
                adressErrorMessageLabel.isHidden = false
                adressTextField.layer.borderColor = UIColor.red.cgColor
                adressTextField.layer.borderWidth = 1.0
            }
            if apartmentNumberTextField.text?.isEmpty == true {
                numberErrorMessageLabel.text = "Введите корректные данные"
                numberErrorMessageLabel.isHidden = false
                apartmentNumberTextField.layer.borderColor = UIColor.red.cgColor
                apartmentNumberTextField.layer.borderWidth = 1.0
            }
            return
        }
        
        if var userInfo = presenter?.getUserInfo() {
            userInfo.address = address
            userInfo.apartmentNumber = apartmentNumber
            
            presenter?.registerUser(userInfo: userInfo) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(_):
                        let vc = СonfirmationСodeViewController(email: userInfo.email)
                        self?.navigationController?.pushViewController(vc, animated: true)
                        self?.showSuccessMessage()
                        
                    case .failure(let error):
                        if let moyaError = error as? MoyaError, case let .statusCode(response) = moyaError {
                            do {
                                if let errorResponse = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any],
                                   let emailErrors = errorResponse["email"] as? [String],
                                   emailErrors.contains("Пользователь с таким Email уже существует.") {
                                    self?.errorLabel.text = "Пользователь с таким Email уже существует."
                                    self?.errorLabel.textColor = .red
                                    self?.errorLabel.isHidden = false
                                    return
                                }
                            } catch {
                                print("Error decoding error response: \(error)")
                            }
                        }
                    
                        print("Failed to register user: \(error)")
                        self?.errorLabel.text = "Пользователь с таким Email уже существует."
                        self?.errorLabel.textColor = .red
                        self?.errorLabel.isHidden = false
                    }
                }
            }
        }
    }
    
    
    private func showSuccessMessage() {

        errorLabel.text = "Мы отправили Вам код на почту."
        errorLabel.textColor = .green
        errorLabel.isHidden = false
    }
}

      


