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
    private var nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Имя"
        view.backgroundColor = UIColor(hex: "#F6F6F7")
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    private var emailTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Email"
        view.backgroundColor = UIColor(hex: "#F6F6F7")
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        
    }
    
    // Mark: - Setup UI Elements
    private func setupUI(){
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 218),
        ])
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signUpButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
        ])
      
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        view.addSubview(supportContactLabel)
        NSLayoutConstraint.activate([
            supportContactLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            supportContactLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
        ])
        
    }
    @objc func signUpButtonTapped(){
        let vc = NewUserRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    @objc func loginButtonTapped(){
        let vc = NewUserRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
   
      
}



