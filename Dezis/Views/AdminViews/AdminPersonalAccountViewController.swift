//
//  AdminPersonalAccountViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class AdminPersonalAccountViewController: UIViewController {
    
    private let userImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "userImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Alexey Ivanovich"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#000000"))
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let personImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileLabel: UILabel = {
        let view = UILabel()
        view.text = "Профиль"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#000000"))
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let shieldImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "shield.fill")
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let settingsLabel: UILabel = {
        let view = UILabel()
        view.text = "Настройки"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#000000"))
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let settingsLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separateLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logOutImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        view.tintColor = .init(hex: "#BABBBD")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logOutLabel: UILabel = {
        let view = UILabel()
        view.text = "Выйти"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(hex: "#BABBBD")
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileLabel.isUserInteractionEnabled = true
        profileLabel.addGestureRecognizer(profileTapGesture)
        
        let settingsTapGesture = UITapGestureRecognizer(target: self, action: #selector(settingsTapped))
        settingsLabel.isUserInteractionEnabled = true
        settingsLabel.addGestureRecognizer(settingsTapGesture)
        
        let logOutTapGesture = UITapGestureRecognizer(target: self, action: #selector(logOutTapped))
        logOutLabel.isUserInteractionEnabled = true
        logOutLabel.addGestureRecognizer(logOutTapGesture)

        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(userImage)
        view.addSubview(nameLabel)
        view.addSubview(personImage)
        view.addSubview(profileLabel)
        view.addSubview(profileLineView)
        view.addSubview(shieldImage)
        view.addSubview(settingsLabel)
        view.addSubview(settingsLineView)
        view.addSubview(separateLineView)
        view.addSubview(logOutImage)
        view.addSubview(logOutLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
                userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                userImage.heightAnchor.constraint(equalToConstant: 130),
                userImage.widthAnchor.constraint(equalToConstant: 130),
                
                nameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 22),
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                personImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 36),
                personImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                personImage.heightAnchor.constraint(equalToConstant: 24),
                personImage.widthAnchor.constraint(equalToConstant: 24),
                
                profileLabel.centerYAnchor.constraint(equalTo: personImage.centerYAnchor),
                profileLabel.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 22),
                
                profileLineView.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 3),
                profileLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                profileLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                profileLineView.heightAnchor.constraint(equalToConstant: 1),
                
                shieldImage.topAnchor.constraint(equalTo: profileLineView.bottomAnchor, constant: 24),
                shieldImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                shieldImage.heightAnchor.constraint(equalToConstant: 24),
                shieldImage.widthAnchor.constraint(equalToConstant: 24),
                
                settingsLabel.centerYAnchor.constraint(equalTo: shieldImage.centerYAnchor),
                settingsLabel.leadingAnchor.constraint(equalTo: shieldImage.trailingAnchor, constant: 22),
                
                settingsLineView.topAnchor.constraint(equalTo: shieldImage.bottomAnchor, constant: 3),
                settingsLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                settingsLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                settingsLineView.heightAnchor.constraint(equalToConstant: 1),
                
                logOutImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
                logOutImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -22),
                logOutImage.heightAnchor.constraint(equalToConstant: 24),
                logOutImage.widthAnchor.constraint(equalToConstant: 24),
                
                logOutLabel.centerYAnchor.constraint(equalTo: logOutImage.centerYAnchor),
                logOutLabel.leadingAnchor.constraint(equalTo: logOutImage.trailingAnchor, constant: 18),
                
                separateLineView.bottomAnchor.constraint(equalTo: logOutImage.topAnchor, constant: -3),
                separateLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                separateLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                separateLineView.heightAnchor.constraint(equalToConstant: 1)
            ]
        )
    }
    
    @objc private func profileTapped() {
        let vc = AdminProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func settingsTapped() {
        let vc = AdminSettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func logOutTapped() {
        print("Log out tapped")
    }
}
