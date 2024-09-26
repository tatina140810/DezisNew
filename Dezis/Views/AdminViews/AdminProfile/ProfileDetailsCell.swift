//
//  ProfileDetailsCell.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

struct ProfileDetails {
    var title: String
}

class ProfileDetailsCell: UITableViewCell {
    
    private  lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .init(UIColor(hex: "#D2D2D2"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "pencil"), for: .normal)
        view.tintColor = .init(UIColor(hex: "#D2D2D2"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separationLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        contentView.backgroundColor = .clear
    }
    
    private func setupConstraints(){
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
        
        contentView.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            editButton.heightAnchor.constraint(equalToConstant: 20),
            editButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        contentView.addSubview(separationLineView)
        NSLayoutConstraint.activate([
            separationLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            separationLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            separationLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separationLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setup(details: ProfileDetails) {
        titleLabel.text = details.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
