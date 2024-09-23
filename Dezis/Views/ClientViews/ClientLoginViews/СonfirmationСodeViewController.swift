//
//  СonfirmationСodeViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 19/9/24.
//

import UIKit

class СonfirmationСodeViewController: UIViewController {
    
    private var codeLabel: UILabel = {
        let view = UILabel()
        view.text = "Код"
        view.font = UIFont.boldSystemFont(ofSize: 24)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var confirmationLabel: UILabel = {
        let view = UILabel()
        view.text = "Вам отправили код на электронную почту"
        view.font = UIFont(name: "Roboto", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var codeStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var firstNumber: UITextField = {
        let view = UITextField()
        view.placeholder = "0"
        view.backgroundColor = UIColor(hex: "#F6F6F7")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var secondNumber: UITextField = {
        let view = UITextField()
        view.placeholder = "0"
        view.backgroundColor = UIColor(hex: "#F6F6F7")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var thirdNumber: UITextField = {
        let view = UITextField()
        view.placeholder = "0"
        view.backgroundColor = UIColor(hex: "#F6F6F7")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var forthNumber: UITextField = {
        let view = UITextField()
        view.placeholder = "0"
        view.backgroundColor = UIColor(hex: "#F6F6F7")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var newCodeLabel: UILabel = {
        let view = UILabel()
        view.text = "Отправить снова"
        view.font = UIFont(name: "Roboto", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle( "Далее", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#5191BA")
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }
    private func setupUI(){
        view.addSubview(codeLabel)
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            codeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        view.addSubview(confirmationLabel)
        NSLayoutConstraint.activate([
            confirmationLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: 40),
                   confirmationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        view.addSubview(codeStack)
        NSLayoutConstraint.activate([
            codeStack.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 50),
                    codeStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    codeStack.heightAnchor.constraint(equalToConstant: 44),
                    codeStack.widthAnchor.constraint(equalToConstant: 272)
        ])
        
        codeStack.addSubview(firstNumber)
        NSLayoutConstraint.activate([
            firstNumber.leadingAnchor.constraint(equalTo: codeStack.leadingAnchor),
            firstNumber.topAnchor.constraint(equalTo: codeStack.topAnchor),
            firstNumber.bottomAnchor.constraint(equalTo:  codeStack.bottomAnchor),
            firstNumber.widthAnchor.constraint(equalToConstant: 46)
        ])
        codeStack.addSubview(secondNumber)
        NSLayoutConstraint.activate([
            secondNumber.leadingAnchor.constraint(equalTo: firstNumber.trailingAnchor, constant: 29),
            secondNumber.topAnchor.constraint(equalTo: codeStack.topAnchor),
            secondNumber.bottomAnchor.constraint(equalTo:  codeStack.bottomAnchor),
            secondNumber.widthAnchor.constraint(equalToConstant: 46)
        ])
        codeStack.addSubview(thirdNumber)
        NSLayoutConstraint.activate([
            thirdNumber.leadingAnchor.constraint(equalTo: secondNumber.trailingAnchor, constant: 29),
            thirdNumber.topAnchor.constraint(equalTo: codeStack.topAnchor),
            thirdNumber.bottomAnchor.constraint(equalTo:  codeStack.bottomAnchor),
            thirdNumber.widthAnchor.constraint(equalToConstant: 46)
        ])
        codeStack.addSubview(forthNumber)
        NSLayoutConstraint.activate([
            forthNumber.leadingAnchor.constraint(equalTo: thirdNumber.trailingAnchor, constant: 29),
            forthNumber.topAnchor.constraint(equalTo: codeStack.topAnchor),
            forthNumber.bottomAnchor.constraint(equalTo:  codeStack.bottomAnchor),
            forthNumber.widthAnchor.constraint(equalToConstant: 46)
        ])
        view.addSubview(newCodeLabel)
        NSLayoutConstraint.activate([
            newCodeLabel.topAnchor.constraint(equalTo: codeStack.bottomAnchor, constant: 20),
                    newCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                   nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                   nextButton.topAnchor.constraint(equalTo: newCodeLabel.bottomAnchor, constant: 50),
                   nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    @objc func nextButtonTapped(){
        let vc = SuccessViewController()
        vc.titleLabel.text = "Вы успешно зарегистрировались"
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
