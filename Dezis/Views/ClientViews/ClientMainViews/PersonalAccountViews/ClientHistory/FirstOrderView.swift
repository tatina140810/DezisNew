//
//  firstOrderView.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 24/10/24.
//

import Foundation
import UIKit

class FirstOrderView: UIView {
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#252F35")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = " "
        view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 25
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
        
        let attributedString = NSMutableAttributedString(string: "")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        view.attributedText = attributedString
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let streetlabel: UILabel = {
        let view = UILabel()
        let attributedString = NSMutableAttributedString(string: "")
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
        let attributedString = NSMutableAttributedString(string: "")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        view.attributedText = attributedString
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dateDetailLabel: UILabel = {
        let view = UILabel()
        let attributedString = NSMutableAttributedString(string: "")
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
        let attributedString = NSMutableAttributedString(string: "")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        view.attributedText = attributedString
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
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
    }
    
    private func setUpSubviews() {
        
        addSubview(contentView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(labelsStackView)
        contentView.addSubview(detailsStackView)
        
        labelsStackView.addArrangedSubview(serviceLabel)
        labelsStackView.addArrangedSubview(addresslabel)
        labelsStackView.addArrangedSubview(dateLabel)
        
        detailsStackView.addArrangedSubview(serviceDetailLabel)
        detailsStackView.addArrangedSubview(streetAndNumberStackView)
        
        streetAndNumberStackView.addArrangedSubview(streetlabel)
        streetAndNumberStackView.addArrangedSubview(houseNumberlabel)
        
        detailsStackView.addArrangedSubview(dateAndTimeStackView)
        
        dateAndTimeStackView.addArrangedSubview(dateDetailLabel)
        dateAndTimeStackView.addArrangedSubview(timeDetailLabel)
        
    }
    
    private func setUpConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        labelsStackView.distribution = .equalSpacing
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.height.equalTo(105)

        }
        
        detailsStackView.distribution = .equalSpacing
        detailsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(labelsStackView.snp.centerY)
            make.leading.equalTo(labelsStackView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.height.equalTo(105)

        }
    }
    
    func fill(with order: ClientOrder, userDetails: UserProfile?) {
        
        nameLabel.text = userDetails?.username ?? "Имя не указано"
        serviceDetailLabel.text = order.service
//        streetlabel.text = userDetails?. ?? "Не предоставлено"
//        houseNumberlabel.text = user?.number ?? "Не предоставлено"
        dateDetailLabel.text = order.date
        timeDetailLabel.text = order.time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
