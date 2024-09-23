//
//  NewUserRegisterViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 18/9/24.
//

import UIKit

class NewUserRegisterViewController: UIViewController {
    
    // Mark: - Create UI Elements
    
    private var titleLabel = LabelSettings().labelMaker(text: "Регистрация", font: UIFont.systemFont(ofSize: 28))
    
    private var nameTextField = TextFieldSettings().textFieldMaker(placeholder: "Имя", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var phoneNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер телефона", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var emailTextField = TextFieldSettings().textFieldMaker(placeholder: "Email", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var orderNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер заказа", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var adressTextField = TextFieldSettings().textFieldMaker(placeholder: "Адрес", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var houseNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер дома", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var apartmentNumberTextField = TextFieldSettings().textFieldMaker(placeholder: "Номер квартиры", backgroundColor: UIColor(hex: "#F6F6F7"))
    
    private var checkMarkButton = CheckboxButton()
    
  
        private var privacyAgreementLabel: UILabel = {
            let view = UILabel()
            view.text = "Согласие на обработку персональных данных"
            view.font = UIFont(name: "Roboto", size: 10)
            view.numberOfLines = 0
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private var loginLabel: UILabel = {
            let view = UILabel()
            view.text = "У вас уже есть аккаунт? Войти"
            view.font = UIFont(name: "Roboto", size: 10)
            view.textColor = UIColor(hex: "#B5B5B5")
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private var signUpButton: UIButton = {
            let view = UIButton()
            view.setTitle( "Зарегистрироваться", for: .normal)
            view.setTitleColor(.white, for: .normal)
            view.backgroundColor = UIColor(hex: "#5191BA")
            view.layer.cornerRadius = 8
            view.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private var supportContactLabel: UILabel = {
            let view = UILabel()
            view.text = "Не удалось зарегистрироваться? Связаться"
            view.font = UIFont(name: "Roboto", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupUI()
            
        }
        
        // Mark: - Setup UI Elements
        private func setupUI(){
            
            view.addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 144),
            ])
            view.addSubview(nameTextField)
            NSLayoutConstraint.activate([
                nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
                nameTextField.heightAnchor.constraint(equalToConstant: 48),
            ])
            view.addSubview(phoneNumberTextField)
            NSLayoutConstraint.activate([
                phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
                phoneNumberTextField.heightAnchor.constraint(equalToConstant: 48),
            ])
            view.addSubview(emailTextField)
            NSLayoutConstraint.activate([
                emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 8),
                emailTextField.heightAnchor.constraint(equalToConstant: 48),
            ])
            view.addSubview(orderNumberTextField)
            NSLayoutConstraint.activate([
                orderNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                orderNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                orderNumberTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
                orderNumberTextField.heightAnchor.constraint(equalToConstant: 48),
            ])
            view.addSubview(adressTextField)
            NSLayoutConstraint.activate([
                adressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                adressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                adressTextField.topAnchor.constraint(equalTo: orderNumberTextField.bottomAnchor, constant: 8),
                adressTextField.heightAnchor.constraint(equalToConstant: 48),
            ])
            view.addSubview(houseNumberTextField)
            NSLayoutConstraint.activate([
                houseNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                houseNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                houseNumberTextField.topAnchor.constraint(equalTo: adressTextField.bottomAnchor, constant: 8),
                houseNumberTextField.heightAnchor.constraint(equalToConstant: 48),
            ])
            view.addSubview(apartmentNumberTextField)
            NSLayoutConstraint.activate([
                apartmentNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                apartmentNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                apartmentNumberTextField.topAnchor.constraint(equalTo: houseNumberTextField.bottomAnchor, constant: 8),
                apartmentNumberTextField.heightAnchor.constraint(equalToConstant: 48),
            ])
            
            view.addSubview(checkMarkButton)
            NSLayoutConstraint.activate([
                checkMarkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                checkMarkButton.topAnchor.constraint(equalTo: apartmentNumberTextField.bottomAnchor, constant: 16),
                checkMarkButton.heightAnchor.constraint(equalToConstant: 24),
                checkMarkButton.widthAnchor.constraint(equalToConstant: 24),
            ])
            view.addSubview(privacyAgreementLabel)
            NSLayoutConstraint.activate([
                privacyAgreementLabel.leadingAnchor.constraint(equalTo: checkMarkButton.trailingAnchor, constant: 5),
                privacyAgreementLabel.topAnchor.constraint(equalTo: apartmentNumberTextField.bottomAnchor, constant: 16),
                privacyAgreementLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
            view.addSubview(loginLabel)
            NSLayoutConstraint.activate([
                loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                loginLabel.topAnchor.constraint(equalTo: checkMarkButton.bottomAnchor, constant: 16),
            ])
            
            view.addSubview(signUpButton)
            NSLayoutConstraint.activate([
                signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                signUpButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
                signUpButton.heightAnchor.constraint(equalToConstant: 48)
            ])
            
            view.addSubview(supportContactLabel)
            NSLayoutConstraint.activate([
                supportContactLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                supportContactLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            ])
            
        }
     
        
        @objc func signUpButtonTapped(){
            let vc = СonfirmationСodeViewController()
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        @objc func loginButtonTapped(){
            let vc = NewUserRegisterViewController()
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }
    

