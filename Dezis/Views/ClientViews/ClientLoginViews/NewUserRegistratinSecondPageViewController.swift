//
//  NewUserRegistratinSecondPageViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 28/9/24.
//

import UIKit

class NewUserRegistratinSecondPageViewController: UIViewController {

    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image8)
        return image
    }()
    
    private var titleLabel = LabelSettings().labelMaker(text: "Регистрация", font: UIFont.systemFont(ofSize: 28))
    
    private var orderNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер заказа", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var adressTextField = TextFieldSettings().textFieldMaker(placeholder: "Адрес*", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var hauseTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер дома/квартиры", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var checkBox = CheckboxButton()
    
    
    private var privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.text = "Я принимаю политику конфиденциальности"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private var secondCheckBox = CheckboxButton()
    
    private var agreementLabel: UILabel = {
        let label = UILabel()
        label.text = "Согласен(а) на обработку персональных данных"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private var contactLabel: UILabel = {
        let view = UILabel()
        view.text = "Не удалось зарегистрироваться? Связаться"
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor(hex: "#B5B5B5")
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зарегистрироваться", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#5191BA")
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createAttributedText()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Attributed Text Links
    
    private func createAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: contactLabel,
            fullText: "Не удалось зарегистрироваться? Связаться",
            tappableText: "Связаться",
            tapTarget: self,
            action: #selector(attributedTextTapped)
        )
    }
    
    // MARK: - Setup UI Elements
    
    private func setupUI() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(83)
            make.height.width.equalTo(140)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(logoImage.snp.bottom).offset(30)
        }
        
        view.addSubview(orderNumberTextField)
        orderNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(adressTextField)
        adressTextField.snp.makeConstraints { make in
            make.top.equalTo(orderNumberTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(hauseTextField)
        hauseTextField.snp.makeConstraints { make in
            make.top.equalTo(adressTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        view.addSubview(checkBox)
        checkBox.tintColor = .black
        checkBox.snp.makeConstraints{make in
            make.top.equalTo(hauseTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
        }
        view.addSubview(privacyPolicyLabel)
        privacyPolicyLabel.snp.makeConstraints{make in
            make.top.equalTo(hauseTextField.snp.bottom).offset(25)
            make.leading.equalTo(checkBox.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-16)
        }
       view.addSubview(secondCheckBox)
        secondCheckBox.tintColor = .black
       secondCheckBox.snp.makeConstraints{make in
           make.top.equalTo(checkBox.snp.bottom).offset(15)
           make.leading.equalToSuperview().offset(16)
           make.height.width.equalTo(24)
       }
        view.addSubview(agreementLabel)
        agreementLabel.snp.makeConstraints{make in
            make.top.equalTo(privacyPolicyLabel.snp.bottom).offset(23)
            make.leading.equalTo(secondCheckBox.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-16)
        }
       
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(agreementLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(contactLabel)
        contactLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    @objc private func attributedTextTapped(){
        print("Contact label tapped")
    }
    @objc private func signUpButtonTapped(){
        let vc = СonfirmationСodeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    

}
