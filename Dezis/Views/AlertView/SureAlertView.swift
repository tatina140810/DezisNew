//
//  SureAlertView.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 23/10/24.
//

import UIKit

class SureAlertView: UIView {
    
    var onConfirm: (() -> Void)?
    
    private let dimmingOverlayView: UIView = {
        let view = UIView()
           view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#1B2228")
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let noButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: "#0A84FF"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let yesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: "#FF0000"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setupUI()
        self.setupAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(dimmingOverlayView)
        addSubview(containerView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(noButton)
        buttonStackView.addArrangedSubview(yesButton)
        buttonStackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            dimmingOverlayView.topAnchor.constraint(equalTo: topAnchor),
            dimmingOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimmingOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimmingOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 259),
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            messageLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20),
            messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 31),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -31)
        ])
    }
    
    private func setupAddTarget() {
        noButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
    }
    
    @objc private func dismissAlert() {
        self.removeFromSuperview()
    }
    
    @objc private func yesButtonTapped() {
        
        onConfirm?()
        self.removeFromSuperview()
    }
    
    func showAlert(on view: UIView, message: String, yesButtonText: String = "Да", noButtonText: String = "Нет") {
            messageLabel.text = message
            yesButton.setTitle(yesButtonText, for: .normal)
            noButton.setTitle(noButtonText, for: .normal) 

            view.addSubview(self)
            self.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.topAnchor),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
}
