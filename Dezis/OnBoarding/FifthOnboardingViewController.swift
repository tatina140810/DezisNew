//
//  FifthOnboardingViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 30/9/24.
//

import UIKit

class FifthOnboardingViewController: UIViewController {
    
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .logo)
        return image
        
    }()
    
    private var exterminatorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image18)
        return image
        
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Готовы к действиям? оставьте заявку и вперед к чистоте!"
        label.font = UIFont(name: "SFProText-Medium", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var nextButton = ButtonSettings().buttonMaker(title: "Продолжить", target: self, action: #selector(nextButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        finishOnboarding()
       
    }
    private func setupUI(){
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(203)
            make.width.equalTo(190)
        }
       
        view.addSubview(exterminatorImage)
        exterminatorImage.snp.makeConstraints{make in
            make.top.equalTo(logoImage.snp.bottom).offset(40)
            make.height.equalTo(234)
            make.leading.trailing.equalToSuperview()
        
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(exterminatorImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-51)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    @objc func nextButtonTapped(){
        let vc = ChoiceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        
    }
    
    
}

