//
//  RequestsCollectionViewCell.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 05/10/24.
//

import UIKit

class RequestsCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "requestsCell"
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "Дата:"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "ФИО"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailLabel: UILabel = {
        let view = UILabel()
        view.text = "Почта:"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let phoneNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Телефон:"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressLabel: UILabel = {
        let view = UILabel()
        view.text = "Адрес:"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let houseNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Номер квартиры/дома:"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let confirmButton: UIButton = {
        let view = UIButton()
        view.setTitle("Подтвердить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(hex: "#0A84FF")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let denyButton: UIButton = {
        let view = UIButton()
        view.setTitle("Отказать", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#0A84FF").cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(dateLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(houseNumberLabel)
        contentView.addSubview(confirmButton)
        contentView.addSubview(denyButton)
    }
    
    private func setUpConstraints() {
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        houseNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(houseNumberLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(17.5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-17.5)
            make.height.equalTo(44)
        }
        
        denyButton.snp.makeConstraints { make in
            make.top.equalTo(confirmButton.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(17.5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-17.5)
            make.height.equalTo(44)
        }
    }
    
    private func setupAddTarget() {
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(denyButtonTapped), for: .touchUpInside)
    }
    
    @objc func confirmButtonTapped() {
        print("confirmed")
    }
    
    @objc private func denyButtonTapped() {
        print("denied")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
