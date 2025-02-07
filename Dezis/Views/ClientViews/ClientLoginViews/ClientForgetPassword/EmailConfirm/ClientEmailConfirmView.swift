//
//  ClientEmailConfirmView.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientEmailConfirmView: AnyObject {
    func showInputError(message: String)
    func navigateToNextScreen(with email: String, userId: Int)
}

class ClientEmailConfirmView: UIViewController {
    
    private var presenter: IClientEmailConfirmPresenter?
    
    private let confirmLabel: UILabel = {
        let view = UILabel()
        view.text = "Подтверждение электронной почты"
        view.font = UIFont(name: "SFProText-Bold", size: 24)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        var field = UITextField()
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.textColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.clear.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Электронная почта*",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7),
                NSAttributedString.Key.font: UIFont(name: "SFProText-Medium", size: 14)!
            ])
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "SFProText-Medium", size: 14)
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        return field
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#515151")
        button.isEnabled = false
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
        textView.font = UIFont(name: "SFProText-Regular", size: 12)
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

        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: termsRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: privacyRange)

        textView.attributedText = attributedString
        
        textView.isEditable = false
        textView.isSelectable = false

        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#1B2228")
        setupUI()
        setupAddTarget()
        setupNavigation()
        updateSendButtonState()
        presenter = ClientEmailConfirmPresenter(view: self)
        dismissKeyboardGesture()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupUI() {
        
        view.addSubview(confirmLabel)
        view.addSubview(emailTextField)
        view.addSubview(errorLabel)
        view.addSubview(sendButton)
        view.addSubview(termsTextView)
        
        confirmLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-105)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(20)
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
    
    private func updateSendButtonState() {
        let isEmailEmpty = emailTextField.text?.isEmpty ?? true
        sendButton.isEnabled = !isEmailEmpty
        sendButton.backgroundColor = sendButton.isEnabled ? UIColor(hex: "#0A84FF") : UIColor(hex: "#515151")
    }

    private func setupAddTarget() {
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        termsTextView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTextTap(_:))))
    }

    @objc private func textFieldDidChange() {
        updateSendButtonState()
    }
    
    @objc private func handleTextTap(_ gesture: UITapGestureRecognizer) {
        guard let textView = gesture.view as? UITextView else { return }

        let layoutManager = textView.layoutManager
        let location = gesture.location(in: textView)
        let characterIndex = layoutManager.characterIndex(for: location, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        let fullText = textView.attributedText.string
        let termsRange = (fullText as NSString).range(of: "Условием продажи")
        let privacyRange = (fullText as NSString).range(of: "Положения о конфиденциальности.")

        if NSLocationInRange(characterIndex, termsRange) {
            let privacyPage = PrivacyPage()
            navigationController?.pushViewController(privacyPage, animated: true)
        } else if NSLocationInRange(characterIndex, privacyRange) {
            let confidentiallyPage = ConfidantionalyPage()
            navigationController?.pushViewController(confidentiallyPage, animated: true)
        }
    }
    
    private func setupNavigation() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        
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
        guard let emailTF = emailTextField.text, !emailTF.isEmpty else {
            showInputError(message: "Пожалуйста, введите email")
            return
        }
        errorLabel.isHidden = true
        presenter?.forgotPassword(email: emailTF)
    }
}

extension ClientEmailConfirmView: IClientEmailConfirmView {
    
    func navigateToNextScreen(with email: String, userId: Int) {
        let vc = ClientEmailCodeView(email: email, userId: userId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showInputError(message: String) {
        emailTextField.layer.borderColor = UIColor.red.cgColor
        
        
        errorLabel.text = message
        errorLabel.isHidden = false
        
        emailTextField.text = ""
        updateSendButtonState()
    }

}
