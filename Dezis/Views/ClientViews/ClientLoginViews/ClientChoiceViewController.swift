//
//  ClientChoiceViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 8/10/24.
//

import UIKit

class ClientChoiceViewController: UIViewController {

    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .logo)
        return image
    }()
    private var registerButton = ButtonSettings().buttonMaker(title: "Регистрация", target: self, action: #selector(registerButtonTapped))
    private var loginButton = ButtonSettings().buttonMaker(title:"Войти", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(loginButtonTapped))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        
    }
    
    private func setupUI(){
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(203)
            make.width.equalTo(190)
        }
        
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    @objc func registerButtonTapped() {
        let vc = NewUserRegisterViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
        
    }
    @objc func loginButtonTapped() {
        let vc = ClientLoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    

}
