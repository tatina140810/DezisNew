//
//  DezinsectionView.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 5/10/24.
//

import UIKit

class DezinsectionView: UIView {
 
    private var backgroundView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(hex: "#2B373E")
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private let firstTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Дезинсекция"
        label.font = UIFont(name: "SFProText-Bold", size: 22)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private let dezinsectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Уничтожение насекомых (тараканы, блохи, комары, мухи, клопы и др.), которые могут быть переносчиками болезней или причинять вред имуществу и человеку. "
        label.font = UIFont(name: "SFProText-Regular", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    private func setupUI(){
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            
        }
        backgroundView.addSubview(firstTextLabel)
        firstTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(20)
        }
        backgroundView.addSubview(dezinsectionDescriptionLabel)
        dezinsectionDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTextLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
