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
    }
    
    private func setupUI() {
        
        view.addSubview(changePasswordLabel)
        view.addSubview(newPasswordTextField)
        view.addSubview(confirmPasswordTextField)
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
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(12)
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
        navigationItem.hidesBackButton = true
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
        
        if newPassword == confirmPassword {
            presenter?.updatePassword(newPassword: newPassword)
        } else {
            showInputError(message: "Пароли не совпадают")
        }
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
        newPasswordTextField.layer.borderColor = UIColor.red.cgColor
        confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
        
        newPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: message,
            attributes: [
                .foregroundColor: UIColor.red,
                .font: UIFont(name: "SFProText-Regular", size: 14)!
            ]
        )
        
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: message,
            attributes: [
                .foregroundColor: UIColor.red,
                .font: UIFont(name: "SFProText-Regular", size: 14)!
            ]
        )
        
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
