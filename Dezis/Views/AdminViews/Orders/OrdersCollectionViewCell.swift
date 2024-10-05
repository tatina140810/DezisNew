//
//  OrdersCollectionViewCell.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class OrdersCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "ordersCell"
    
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
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "Дата:"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(UIColor(hex: "#000000"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timelabel: UILabel = {
        let view = UILabel()
        view.text = "Время:"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(UIColor(hex: "#000000"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailLabel: UILabel = {
        let view = UILabel()
        view.text = "Email"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#B5B5B5"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let phoneNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Номер телефона"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#B5B5B5"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressLabel: UILabel = {
        let view = UILabel()
        view.text = "Адрес"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#B5B5B5"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let houseNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Номер дома"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#B5B5B5"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let apartmentNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Номер квартиры"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#B5B5B5"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let serviceLabel: UILabel = {
        let view = UILabel()
        view.text = "Услуга"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#B5B5B5"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let orderNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Номер заказа"
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#B5B5B5"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separateLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setUp()
    }
    
    func setUp() {
        setUpSubviews()
        setUpConstraints()
    }
    
    func setUpSubviews() {
        contentView.addSubview(userImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timelabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(houseNumberLabel)
        contentView.addSubview(apartmentNumberLabel)
        contentView.addSubview(serviceLabel)
        contentView.addSubview(orderNumberLabel)
        contentView.addSubview(separateLineView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate(
            [
                userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
                userImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                userImage.heightAnchor.constraint(equalToConstant: 50),
                userImage.widthAnchor.constraint(equalToConstant: 50),
                
                nameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 16),
                nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                
                dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 22),
                dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                timelabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                timelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                emailLabel.topAnchor.constraint(equalTo: timelabel.bottomAnchor, constant: 15),
                emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
                phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                addressLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10),
                addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                houseNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
                houseNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                apartmentNumberLabel.topAnchor.constraint(equalTo: houseNumberLabel.bottomAnchor, constant: 10),
                apartmentNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                serviceLabel.topAnchor.constraint(equalTo: apartmentNumberLabel.bottomAnchor, constant: 10),
                serviceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                orderNumberLabel.topAnchor.constraint(equalTo: serviceLabel.bottomAnchor, constant: 10),
                orderNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
                
                separateLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                separateLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                separateLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                separateLineView.heightAnchor.constraint(equalToConstant: 1)
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
