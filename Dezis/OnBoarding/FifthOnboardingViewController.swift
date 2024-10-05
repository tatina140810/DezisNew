//
//  FifthOnboardingViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 30/9/24.
//

import UIKit

class FifthOnboardingViewController: UIViewController {
    
    private var ellipsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image19)
        return image
        
    }()
    private var rectangleImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .rectangle4)
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пропустить", for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        finishOnboarding()
    }
    private func setupUI(){
        
        view.addSubview(ellipsImage)
        ellipsImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(360)
        }
        view.addSubview(rectangleImage)
        rectangleImage.snp.makeConstraints{make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
            
        }
        view.addSubview(exterminatorImage)
        exterminatorImage.snp.makeConstraints{make in
            make.top.equalTo(rectangleImage.snp.top).offset(-50)
            make.centerX.equalToSuperview()
            make.height.equalTo(234)
            make.width.equalTo(360)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(exterminatorImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints{make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(130)}
    }
    
    
    @objc func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        
        let mainViewController = ClientTabBarController()
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true, completion: nil)
    }
@objc func skipButtonTapped(){
    let vc = ClientTabBarController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
}
    
}

