//
//  ClientEmailCodeView.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientEmailCodeView {

}

class ClientEmailCodeView: UIViewController {
    
    private var presenter: IClientEmailCodePresenter?
    
    private let sendCodeLabel: UILabel = {
        let view = UILabel()
        view.text = "Мы отправили код на вашу электронную почту"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var codeTextField: UITextField = {
        var field = UITextField()
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.textColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.clear.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Код:",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7),
                NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Regular", size: 14)!
            ])
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        return field
    }()
    
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hex: "#0A84FF")
        button.layer.cornerRadius = 12
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        textView.textColor = .white
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue
        ]
        
        let fullText = "Выбирая «Зарегистрироваться», вы подтверждаете свое согласие с Условием продажи и принимаете условия Положения о конфиденциальности."
        
        let termsOfService = "Условием продажи"
        let privacyPolicy = "Положения о конфиденциальности."
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: fullText, attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ])
        
        let termsRange = (fullText as NSString).range(of: termsOfService)
        let privacyRange = (fullText as NSString).range(of: privacyPolicy)
        
        attributedString.addAttribute(.link, value: "terms://", range: termsRange)
        attributedString.addAttribute(.link, value: "privacy://", range: privacyRange)
        
        textView.attributedText = attributedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#1B2228")
        setupUI()
        setupAddTarget()
        setupNavigation()
        presenter = ClientEmailCodePresenter(view: self)
        dismissKeyboardGesture()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupUI() {
        
        view.addSubview(sendCodeLabel)
        view.addSubview(codeTextField)
        view.addSubview(sendButton)
        view.addSubview(termsTextView)
        
        sendCodeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(278)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(sendCodeLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }
        
        termsTextView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func setupAddTarget() {
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    private func setupNavigation() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        
        let chevronImage = UIImage(resource: .shevron).withRenderingMode(.alwaysTemplate)
        let resizedChevron = UIGraphicsImageRenderer(size: CGSize(width: 8, height: 14)).image { _ in
            chevronImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 8, height: 14)))
        }
        backButton.setImage(resizedChevron, for: .normal)
        backButton.tintColor = .systemBlue
        
        backButton.semanticContentAttribute = .forceLeftToRight
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 5)
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -5)
        
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func sendButtonTapped() {
        
        let vc = ClientForgetPasswordView()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ClientEmailCodeView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
           if URL.scheme == "terms" || URL.scheme == "privacy" {
               return false
           }
           return true
       }
}


extension ClientEmailCodeView: IClientEmailCodeView { }
