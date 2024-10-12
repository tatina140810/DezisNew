//
//  CustomNavigationBar.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 11/10/24.
//

import Foundation
import UIKit

class CustomNavigationBar: UIView {
    
   
   
    private lazy var avatarImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(resource: .oval)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Dezis group"
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func  setupUI() {
        
        addSubview(avatarImage)
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(100)
            make.height.equalTo(36)
            make.width.equalTo(36)
           
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(avatarImage.snp.trailing).offset(20)
            
        }
    }
  
}
