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
        return view
    }()
    
    private var confirmationLabel: UILabel = {
        let view = UILabel()
        view.text = "Вам отправили код на электронную почту"
        view.font = UIFont(name: "Roboto", size: 16)
        return view
    }()
    private var codeStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        return view
    }()
    
    private var firstNumber = TextFieldSettings().textFieldMaker(placeholder: "0")
   
    private var secondNumber = TextFieldSettings().textFieldMaker(placeholder: "0")
        
    private var thirdNumber = TextFieldSettings().textFieldMaker(placeholder: "0")
        
    private var forthNumber = TextFieldSettings().textFieldMaker(placeholder: "0")
        
    private var newCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить снова", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto", size: 16)
        button.addTarget(self, action: #selector(newCodeButtonTapped), for: .touchUpInside)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    
    
    private var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle( "Далее", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#5191BA")
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }
    private func setupUI(){
        view.addSubview(codeLabel)
        codeLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(180)
            make.leading.equalToSuperview().offset(16)
        }
       
        view.addSubview(confirmationLabel)
        confirmationLabel.snp.makeConstraints {make in
            make.top.equalTo(codeLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }
            
        view.addSubview(codeStack)
        codeStack.snp.makeConstraints{make in
            make.top.equalTo(confirmationLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(272)
        }
        
        codeStack.addSubview(firstNumber)
        firstNumber.snp.makeConstraints{ make in
            make.leading.equalTo(codeStack.snp.leading)
            make.top.equalTo(codeStack)
            make.bottom.equalTo(codeStack)
            make.width.equalTo(46)
        }
            
        codeStack.addSubview(secondNumber)
        secondNumber.snp.makeConstraints{ make in
            make.leading.equalTo(firstNumber.snp.trailing).offset(20)
            make.top.equalTo(codeStack)
            make.bottom.equalTo(codeStack)
            make.width.equalTo(46)
        }
        codeStack.addSubview(thirdNumber)
        thirdNumber.snp.makeConstraints{ make in
            make.leading.equalTo(secondNumber.snp.trailing).offset(20)
            make.top.equalTo(codeStack)
            make.bottom.equalTo(codeStack)
            make.width.equalTo(46)
        }
        codeStack.addSubview(forthNumber)
        forthNumber.snp.makeConstraints { make in
            make.leading.equalTo(thirdNumber.snp.trailing).offset(20)
            make.top.equalTo(codeStack)
            make.bottom.equalTo(codeStack)
            make.width.equalTo(46)
        }
       
        view.addSubview(newCodeButton)
        newCodeButton.snp.makeConstraints { make in
            make.top.equalTo(codeStack.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints{make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(newCodeButton.snp.bottom).offset(50)
            make.height.equalTo(48)
        }
    }
    @objc func newCodeButtonTapped() {
        print("New code Button")
    }
    @objc func nextButtonTapped(){
        let vc = SuccessViewController()
        vc.titleLabel.text = "Вы успешно зарегистрировались"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
