//
//  ClientForgetPasswordView.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientNewPasswordView {
    func showInputError(message: String)
    func showLoading()
    func hideLoading()
    func navigateToLoginScreen()
}

class ClientNewPasswordView: UIViewController {
    
    private var presenter: IClientNewPasswordPresenter?
    private let userId: Int
    
    init(userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let loadingOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = UIColor(hex: "#1B2228")
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.isHidden = true
        return overlay
    }()
    
    private let changePasswordLabel: UILabel = {
        let view = UILabel()
        view.text = "Смена пароля"
        view.font = UIFont(name: "SFProText-Bold", size: 24)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newPasswordTextField: UITextField = {
        var field = UITextField()
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.textColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.clear.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Введите новый пароль*",
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
    
    private let newPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let confirmPasswordTextField: UITextField = {
        var field = UITextField()
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.textColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.clear.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Повторите пароль*",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7),
                NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 14)!
            ])
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "SFProText-Regular", size: 14)
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }()
    
    private let confirmPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
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
        presenter = ClientNewPasswordPresenter(view: self, userId: userId)
        dismissKeyboardGesture()
        self.navigationController?.isNavigationBarHidden = false
        
        newPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        updateContinueButtonState()
    }

    private func updateContinueButtonState() {
        let isNewPasswordEmpty = newPasswordTextField.text?.isEmpty ?? true
        let isConfirmPasswordEmpty = confirmPasswordTextField.text?.isEmpty ?? true
        
        continueButton.isEnabled = !isNewPasswordEmpty && !isConfirmPasswordEmpty
        continueButton.backgroundColor = continueButton.isEnabled ? UIColor(hex: "#0A84FF") : UIColor(hex: "#515151")
    }
    
    private func setupUI() {
        
        view.addSubview(changePasswordLabel)
        view.addSubview(newPasswordTextField)
        view.addSubview(newPasswordErrorLabel)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(confirmPasswordErrorLabel)
        view.addSubview(continueButton)
        view.addSubview(termsTextView)
        view.addSubview(loadingIndicator)
        view.addSubview(loadingOverlay)
        loadingOverlay.addSubview(loadingIndicator)
        
        
        NSLayoutConstraint.activate([
            loadingOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            loadingOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            loadingIndicator.centerXAnchor.constraint(equalTo: loadingOverlay.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: loadingOverlay.centerYAnchor)
        ])
        
        changePasswordLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-105)
            make.centerX.equalToSuperview()
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(changePasswordLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        newPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(4)
            make.leading.equalTo(newPasswordTextField.snp.leading)
            make.trailing.equalTo(newPasswordTextField.snp.trailing)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordErrorLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        confirmPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(4)
            make.leading.equalTo(confirmPasswordTextField.snp.leading)
            make.trailing.equalTo(confirmPasswordTextField.snp.trailing)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordErrorLabel.snp.bottom).offset(12)
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
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
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
    
    @objc private func continueButtonTapped() {
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showInputError(message: "Поля не могут быть пустыми")
            return
        }

        if let passwordError = isValidPassword(newPassword) {
            showInputError(message: passwordError)
            return
        }

        if newPassword != confirmPassword {
            showInputError(message: "Пароли не совпадают")
            return
        }

        presenter?.updatePassword(newPassword: newPassword)
    }
    
    private func isValidPassword(_ password: String) -> String? {
        if password.count < 8 {
            return "Пароль должен содержать не менее 8 символов."
        }
        
        let lowercaseLetterRegex = ".*[a-z]+.*"
        let lowercaseTest = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex)
        if !lowercaseTest.evaluate(with: password) {
            return "Пароль должен содержать хотя бы одну строчную букву."
        }
        
        let digitRegex = ".*[0-9]+.*"
        let digitTest = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        if !digitTest.evaluate(with: password) {
            return "Пароль должен содержать хотя бы одну цифру."
        }
        
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        let specialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        if !specialCharacterTest.evaluate(with: password) {
            return "Пароль должен содержать хотя бы один специальный символ *[!@#$%^&*(),.?\":{}|<>]+.*."
        }
        
        return nil
    }


}

extension ClientNewPasswordView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
           if URL.scheme == "terms" || URL.scheme == "privacy" {
               return false
           }
           return true
       }
}


extension ClientNewPasswordView: IClientNewPasswordView {
    
    func showInputError(message: String) {
        if message.contains("Пароль должен") {
            newPasswordErrorLabel.text = message
            newPasswordErrorLabel.isHidden = false
            newPasswordTextField.layer.borderColor = UIColor.red.cgColor
        } else if message.contains("Пароли не совпадают") {
            confirmPasswordErrorLabel.text = message
            confirmPasswordErrorLabel.isHidden = false
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
        }

        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
    
    func showLoading() {
        loadingOverlay.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func navigateToLoginScreen() {
        let loginVC = ClientLoginViewController()
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}

extension ClientNewPasswordView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateContinueButtonState()
    }
}
