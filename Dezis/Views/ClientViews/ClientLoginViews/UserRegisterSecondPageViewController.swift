import UIKit
import Moya
protocol IUserRegisterSecondPageViewController {
    
}
class UserRegisterSecondPageViewController: UIViewController, IUserRegisterSecondPageViewController {
    
    let adress = ""
    let apartmentNumber = ""

    private var presenter: IUserRegisterPresenters?

    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var adressTextField = TextFieldSettings().textFieldMaker(placeholder: "Адрес", backgroundColor: UIColor(hex: "#2B373E"))
    
    private var apartmentNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер дома/квартиры", backgroundColor: UIColor(hex: "#2B373E"))
    
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
        backButtonSetup()
       
    }
    
    private func backButtonSetup(){
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
            make.top.equalToSuperview().offset(250)
        }
        
        view.addSubview(adressTextField)
        adressTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(apartmentNumberTextField)
        apartmentNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(adressTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(apartmentNumberTextField.snp.bottom).offset(38)
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
    @objc func attributedTextTapped() {
        print("Условием продажи")
    }
    @objc func attributedPrivaciTextTapped() {
        print("Положения о конфиденциальности")
    }
   
    @objc private func nextButtonTapped() {
        guard let adress = adressTextField.text, !adress.isEmpty,
              let apartmentNumber = apartmentNumberTextField.text, !apartmentNumber.isEmpty else {
         
            let redPlaceholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
                    
                    if adressTextField.text?.isEmpty == true {
                        adressTextField.attributedPlaceholder = NSAttributedString(
                            string: "Введите еще раз",
                            attributes: redPlaceholderAttributes
                        )
                    }
                    
                    if apartmentNumberTextField.text?.isEmpty == true {
                        apartmentNumberTextField.attributedPlaceholder = NSAttributedString(
                            string: "Введите еще раз",
                            attributes: redPlaceholderAttributes
                        )
                    
                    }
            adressTextField.layer.borderColor = UIColor.red.cgColor
            apartmentNumberTextField.layer.borderColor = UIColor.red.cgColor
            adressTextField.layer.borderWidth = 1.0
            apartmentNumberTextField.layer.borderWidth = 1.0
            
            return
        }

        if presenter == nil {

            presenter = UserRegisterPresenters(view: NewUserRegisterViewController(), secondView: self)
        }
        let username = presenter?.getRegistrInfo().username
        let email = presenter?.getRegistrInfo().email
        let password = presenter?.getRegistrInfo().password
    
        presenter?.updateSecondPageInfo(adress: adress, apartmentNumber: apartmentNumber)
     
        let vc = UINavigationController(rootViewController: СonfirmationСodeViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @objc private func backButtonTapped() {
        let vc = UINavigationController(rootViewController: NewUserRegisterViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    

}
