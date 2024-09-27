//
//  ClientLoginViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 18/9/24.
//

import UIKit

class ClientLoginViewController: UIViewController {
    
    // Mark: - Create UI Elements
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "С возвращением!"
        view.font = UIFont.systemFont(ofSize: 28)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var nameTextField = TextFieldSettings().textFieldMaker(placeholder: "Имя")
   
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "Email")
      
    private var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle( "Регистрация", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle( "Войти", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#5191BA")
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var supportContactLabel: UILabel = {
        let view = UILabel()
        view.text = "Не удалось войти? Связаться"
        view.font = UIFont(name: "Roboto", size: 19)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        validateFields()
        createAttributedText()
        
    }
    
    // Mark: - Setup UI Elements
    private func setupUI(){
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(218)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {make in
            make.top.equalTo(nameTextField.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)}
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints{make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.height.equalTo(48)
        }
        
        view.addSubview(supportContactLabel)
        supportContactLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(20)
        }
    }
    
    private func createAttributedText() {
        AttributedTextHelper.configureAttributedText(
            for: supportContactLabel,
            fullText: "Не удалось войти? Связаться",
            tappableText: "Связаться",
            tapTarget: self,
            action: #selector(attributedTextTapped))
       
    }
    
    // Mark: - TextField validation
    
    private func validateFields() -> Bool {
        
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Пожалуйста, введите имя.")
            return false
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Пожалуйста, введите email.")
            return false
        }
        
        
        if !isValidEmail(email) {
            showAlert(message: "Введите корректный email.")
            return false
        }
        
        return true
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    @objc func signUpButtonTapped() {
        
        if validateFields() {
            let vc = NewUserRegisterViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func loginButtonTapped() {
        
        if validateFields() {
            let vc = NewUserRegisterViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func attributedTextTapped() {
        // переход на страницу свзяаться
        
        print("Support contact tapped!")
    }
    
}



