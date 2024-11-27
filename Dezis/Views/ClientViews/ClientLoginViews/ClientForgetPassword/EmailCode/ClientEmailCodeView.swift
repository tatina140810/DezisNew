//
//  ClientEmailCodeView.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientEmailCodeView {
    func showInputError(message: String)
    func navigateToNextScreen(with userId: Int)
}

class ClientEmailCodeView: UIViewController {
    
    private var presenter: IClientEmailCodePresenter?
    var email: String
    var userId: Int

    init(email: String, userId: Int) {
        self.email = email
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let sendCodeLabel: UILabel = {
        let view = UILabel()
        view.text = "Мы отправили код на вашу электронную почту"
        view.font = UIFont(name: "SFProText-Bold", size: 24)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.numberOfLines = 0
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var codeTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.textColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.clear.cgColor
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "SFProText-Medium", size: 14)
        field.autocapitalizationType = .none
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let leftLabel = UILabel()
        leftLabel.text = "Код: "
        leftLabel.textColor = .white
        leftLabel.font = UIFont(name: "SFProText-Medium", size: 14)
        leftLabel.sizeToFit()

        let paddingView = UIView()
        paddingView.frame = CGRect(x: 0, y: 0, width: 15, height: leftLabel.frame.height)

        container.addSubview(paddingView)
        container.addSubview(leftLabel)

        container.frame = CGRect(x: 0, y: 0, width: leftLabel.frame.width + paddingView.frame.width, height: leftLabel.frame.height)

        paddingView.frame.origin = .zero
        leftLabel.frame.origin = CGPoint(x: paddingView.frame.width, y: 0)

        field.leftView = container
        field.leftViewMode = .always

        return field
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hex: "#515151")
        button.layer.cornerRadius = 12
        button.isEnabled = false
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
        presenter = ClientEmailCodePresenter(view: self, userId: userId)
        dismissKeyboardGesture()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupUI() {
        view.addSubview(sendCodeLabel)
        view.addSubview(codeTextField)
        view.addSubview(sendButton)
        view.addSubview(termsTextView)

        sendCodeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-105)
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
        termsTextView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTextTap(_:))))
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
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        if let codeText = codeTextField.text, !codeText.isEmpty {
            sendButton.isEnabled = true
            sendButton.backgroundColor = .init(hex: "#0A84FF")
        } else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = .init(hex: "#515151")
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
        guard let code = codeTextField.text, !code.isEmpty else {
            showInputError(message: "Введите код")
            return
        }

        presenter?.verifyUser(email: email, otp: code)
    }
}

extension ClientEmailCodeView: IClientEmailCodeView {
    
    func navigateToNextScreen(with userId: Int) {
        let nextViewController = ClientNewPasswordView(userId: userId)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func showInputError(message: String) {
        codeTextField.layer.borderColor = UIColor.red.cgColor

        let alertLabel = UILabel()
        alertLabel.text = message
        alertLabel.textColor = .red
        alertLabel.font = UIFont(name: "SFProText-Regular", size: 14)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertLabel)

        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(4)
            make.leading.equalTo(codeTextField.snp.leading)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(alertLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }
    }
}
