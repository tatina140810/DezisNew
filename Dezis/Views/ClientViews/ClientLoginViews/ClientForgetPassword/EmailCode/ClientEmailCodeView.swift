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
        var field = UITextField()
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.textColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.clear.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Код:",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7),
                NSAttributedString.Key.font: UIFont(name: "SFProText-Medium", size: 14)!
            ])
        field.layer.cornerRadius = 10
        field.font = UIFont(name: "SFProText-Medium", size: 14)
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
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
    }
    
    private func setupAddTarget() {
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
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
        navigationItem.hidesBackButton = true
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
        
        codeTextField.attributedPlaceholder = NSAttributedString(
            string: message,
            attributes: [
                .foregroundColor: UIColor.red,
                .font: UIFont(name: "SFProText-Regular", size: 14)!
            ]
        )
        
        codeTextField.text = ""
    }
}
