//
//  СonfirmationСodeViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 19/9/24.
//

import UIKit

class СonfirmationСodeViewController: UIViewController {
    
    private var codeLabel: UILabel = {
        let view = UILabel()
        view.text = "Введите код"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 24)
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
    
    
    private var codeTextField = TextFieldSettings().textFieldMaker(placeholder: "Код:", backgroundColor: UIColor(hex: "#2B373E"))
   
    private lazy var newCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить снова", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        button.tintColor = UIColor(hex: "#5FBEF4")
        button.addTarget(self, action: #selector(newCodeButtonTapped), for: .touchUpInside)
        return button
    }()
    private var oneMinuteLabel: UILabel = {
        let view = UILabel()
        view.text = "через 1 минуту"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        view.textColor = .white
        return view
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        createAttributedText()
        createPrivaciAttributedText()
        
    }
    private func setupUI(){
        view.addSubview(codeLabel)
        codeLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
        }
       
        view.addSubview(confirmationLabel)
        confirmationLabel.snp.makeConstraints {make in
            make.top.equalTo(codeLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        view.addSubview(codeTextField)
        codeTextField.snp.makeConstraints {make in
            make.top.equalTo(confirmationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        view.addSubview(newCodeButton)
        newCodeButton.snp.makeConstraints {make in
            make.top.equalTo(codeTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
        }
        view.addSubview(oneMinuteLabel)
        oneMinuteLabel.snp.makeConstraints {make in
            make.top.equalTo(newCodeButton.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(16)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(oneMinuteLabel.snp.bottom).offset(10)
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
    @objc func newCodeButtonTapped() {
        print("New code Button")
    }
    @objc func attributedTextTapped() {
        print("Условием продажи")
    }
    @objc func attributedPrivaciTextTapped() {
        print("Положения о конфиденциальности")
    }
    @objc func nextButtonTapped(){
        let vc = SuccessViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
