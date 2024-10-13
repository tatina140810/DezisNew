//
//  OrdersCollectionViewCell.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class OrdersCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "ordersCell"
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Alexey Ivanovich"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let serviceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let serviceLabel: UILabel = {
        let view = UILabel()
        view.text = "Услуги:"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let serviceDetailLabel: UILabel = {
        let view = UILabel()
        view.text = "Дезинфекция"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let addresslabel: UILabel = {
        let view = UILabel()
        view.text = "Адрес:"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressDetaillabel: UILabel = {
        let view = UILabel()
        view.text = "Восток-5"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "Дата:"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateDetailLabel: UILabel = {
        let view = UILabel()
        view.text = "17.11.2024"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeDetailLabel: UILabel = {
        let view = UILabel()
        view.text = "21:30"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Завершить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hex: "#0A84FF")
        button.layer.cornerRadius = 10
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 32
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    }
    
    private func setUpSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(serviceStackView)
        serviceStackView.addArrangedSubview(serviceLabel)
        serviceStackView.addArrangedSubview(serviceDetailLabel)
        
        mainStackView.addArrangedSubview(addressStackView)
        addressStackView.addArrangedSubview(addresslabel)
        addressStackView.addArrangedSubview(addressDetaillabel)
        
        mainStackView.addArrangedSubview(dateStackView)
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateDetailLabel)
        dateStackView.addArrangedSubview(timeDetailLabel)
        
        contentView.addSubview(completeButton)
    }
    
    private func setUpConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
        }
            
        mainStackView.distribution = .equalSpacing
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.height.equalTo(76)
        }
        
        serviceStackView.distribution = .equalSpacing
        addressStackView.distribution = .equalSpacing
        dateStackView.distribution = .equalSpacing
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-24)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
