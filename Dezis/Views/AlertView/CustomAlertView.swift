//
//  SuccessAlertView.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 23/10/24.
//

import UIKit

class CustomAlertView: UIView {
    
    private let dimmingOverlayView: UIView = {
        let view = UIView()
           view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#29323C")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        //        imageView.image = UIImage(named: "check-circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        //        label.text = "Вы завершили заказ!"
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(dimmingOverlayView)
        addSubview(containerView)
        containerView.addSubview(checkmarkImageView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            dimmingOverlayView.topAnchor.constraint(equalTo: topAnchor),
            dimmingOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimmingOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimmingOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 288),
            containerView.heightAnchor.constraint(equalToConstant: 262),
            
            checkmarkImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            checkmarkImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 57),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 100),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 100),
            
            messageLabel.topAnchor.constraint(equalTo: checkmarkImageView.bottomAnchor, constant: 26),
            messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 26),
            closeButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func setupAddTarget() {
        closeButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    }
    
    @objc private func dismissAlert() {
        self.removeFromSuperview()
    }
    
    func showAlert(on view: UIView, withMessage message: String, imageName: String) {
        messageLabel.text = message
        checkmarkImageView.image = UIImage(named: imageName)
        
        view.addSubview(self)
        self.frame = view.bounds
        self.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        })
    }
}

