//
//  EntryDeniedViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 13/10/24.
//

import UIKit

class EntryDeniedViewController: UIViewController {
  
    
    private var entryAllowedImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .entryDenied)
        return view
    }()
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "К сожалению администратор не дал вам разрешение на вход в приложение! Попробуйте зайти с другого аккаунта."
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textAlignment = .center
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var nextButton = ButtonSettings().buttonMaker(title: "Вернуться ко входу",
                                                               target: self,
                                                               action: #selector(nextButtonTapped))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        
        
    }
    
    private func setupUI(){
        
        view.addSubview(entryAllowedImage)
        entryAllowedImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(152)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(276)
            
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(entryAllowedImage.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(45)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(23)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
            
        }
    }
    @objc func nextButtonTapped() {
        
        dismiss(animated: true) {
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = scene.windows.first else { return }

            let vc = ChoiceViewController()
            window.rootViewController = UINavigationController(rootViewController: vc)
            window.makeKeyAndVisible()
        }
    }
}

