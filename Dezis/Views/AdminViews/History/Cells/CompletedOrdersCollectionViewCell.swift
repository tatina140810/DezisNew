//
//  CompletedOrdersCollectionViewCell.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 23/10/24.
//

import UIKit

class CompletedOrdersCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "completedOrdersCell"
    
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
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let serviceLabel: UILabel = {
        let view = UILabel()
        view.text = "Услуги:"
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let serviceDetailLabel: UILabel = {
        let view = UILabel()
        
        let attributedString = NSMutableAttributedString(string: "Дезинфекция")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        view.attributedText = attributedString
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let addresslabel: UILabel = {
        let view = UILabel()
        view.text = "Адрес:"
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let streetAndNumberStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let streetlabel: UILabel = {
        let view = UILabel()
        let attributedString = NSMutableAttributedString(string: "Восток-5")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        view.attributedText = attributedString
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let houseNumberlabel: UILabel = {
        let view = UILabel()
        let attributedString = NSMutableAttributedString(string: "13/21")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        view.attributedText = attributedString
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "Дата:"
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#0A84FF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateAndTimeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dateDetailLabel: UILabel = {
        let view = UILabel()
        let attributedString = NSMutableAttributedString(string: "17.11.2024")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        view.attributedText = attributedString
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeDetailLabel: UILabel = {
        let view = UILabel()
        let attributedString = NSMutableAttributedString(string: "21:30")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        view.attributedText = attributedString
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addressStackView.addArrangedSubview(streetAndNumberStackView)
        streetAndNumberStackView.addArrangedSubview(streetlabel)
        streetAndNumberStackView.addArrangedSubview(houseNumberlabel)
        
        mainStackView.addArrangedSubview(dateStackView)
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateAndTimeStackView)
        dateAndTimeStackView.addArrangedSubview(dateDetailLabel)
        dateAndTimeStackView.addArrangedSubview(timeDetailLabel)
        
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
        
        streetAndNumberStackView.distribution = .fillEqually
        dateAndTimeStackView.distribution = .fillEqually
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
