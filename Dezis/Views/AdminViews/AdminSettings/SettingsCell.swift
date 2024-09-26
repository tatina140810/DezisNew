//
//  SettingsCell.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

enum SettingsType {
    case withRightBtn
    case withSwitch
}

struct Setting {
    var title: String
    var type: SettingsType
}

class SettingsCell: UITableViewCell {
    
    private  lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        view.textColor = .init(UIColor(hex: "#000000"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var modeSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addTarget(self, action: #selector(switchTapped), for: .valueChanged)
        return view
    }()
    
    private lazy var actionButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        view.tintColor = .black
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
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
        
        contentView.addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
        
        contentView.addSubview(modeSwitch)
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modeSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            modeSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            modeSwitch.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        contentView.addSubview(separationLineView)
        NSLayoutConstraint.activate([
            separationLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            separationLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            separationLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separationLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setup(settings: Setting) {
        titleLabel.text = settings.title
        if settings.type == .withRightBtn {
            modeSwitch.isHidden = true
            actionButton.isHidden = false
        } else if settings.type == .withSwitch {
            actionButton.isHidden = true
            modeSwitch.isHidden = false
        }
    }
    
    @objc func switchTapped() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
