//
//  RequestsCollectionViewCell.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 05/10/24.
//

import UIKit

class RequestsCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "requestsCell"
    
    var onConfirmTapped: (() -> Void)?
    var onDenyTapped: (() -> Void)?
    
    private let titlesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "Дата:"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "ФИО"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailLabel: UILabel = {
        let view = UILabel()
        view.text = "Почта:"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let phoneNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Телефон:"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressLabel: UILabel = {
        let view = UILabel()
        view.text = "Адрес:"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let houseNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Номер квартиры/дома:"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dateDetailLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameDetailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailDatailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let phoneNumberDetailsLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressDetailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let houseNumberDetailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let denyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отказать", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#0A84FF").cgColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor(hex: "#252F35")
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        setUp()
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstraints()
        setupAddTarget()
    }
    
    private func setUpSubviews() {
        contentView.addSubview(titlesStackView)
        titlesStackView.addArrangedSubview(dateLabel)
        titlesStackView.addArrangedSubview(nameLabel)
        titlesStackView.addArrangedSubview(emailLabel)
        titlesStackView.addArrangedSubview(phoneNumberLabel)
        titlesStackView.addArrangedSubview(addressLabel)
        contentView.addSubview(houseNumberLabel)
        contentView.addSubview(detailsStackView)
        detailsStackView.addArrangedSubview(dateDetailLabel)
        detailsStackView.addArrangedSubview(nameDetailLabel)
        detailsStackView.addArrangedSubview(emailDatailLabel)
        detailsStackView.addArrangedSubview(phoneNumberDetailsLabel)
        detailsStackView.addArrangedSubview(addressDetailLabel)
        contentView.addSubview(houseNumberDetailLabel)
        contentView.addSubview(confirmButton)
        contentView.addSubview(denyButton)
    }
    
    private func setUpConstraints() {
        
        titlesStackView.distribution = .equalSpacing
        titlesStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        houseNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(titlesStackView.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        detailsStackView.distribution = .equalSpacing
        detailsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(titlesStackView.snp.centerY)
            make.leading.equalTo(titlesStackView.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        houseNumberDetailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(houseNumberLabel.snp.centerY)
            make.leading.equalTo(houseNumberLabel.snp.trailing).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(houseNumberLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(17.5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-17.5)
            make.height.equalTo(44)
        }
        
        denyButton.snp.makeConstraints { make in
            make.top.equalTo(confirmButton.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(17.5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-17.5)
            make.height.equalTo(44)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
    
    private func setupAddTarget() {
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(denyButtonTapped), for: .touchUpInside)
    }
    
    @objc func confirmButtonTapped() {
        onConfirmTapped?()
    }
    
    @objc private func denyButtonTapped() {
        onDenyTapped?()
    }
    
    func fill(with userInfo: UserInformation?) {
        nameDetailLabel.text = userInfo?.username ?? "Имя не указано"
        emailDatailLabel.text = userInfo?.email ?? "Почта не указана"
        phoneNumberDetailsLabel.text = userInfo?.number ?? "Телефон не указан"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
