//
//  AdminHomeViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class AdminHomeViewController: UIViewController {
    
    private let infoLabel: UILabel = {
        let view = UILabel()
        view.text = "Информация о записи"
        view.font = .boldSystemFont(ofSize: 24)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#1B2228")
        setupUI()
    }
    
    private func setupUI(){
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(71)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(infoLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
}
