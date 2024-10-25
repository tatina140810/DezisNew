//
//  OrdersCategoryCollectionViewCell.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 05/10/24.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "categoriesCell"
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = .init(hex: "#FFFFFF")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "#0A84FF")
        view.isHidden = true
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
        contentView.clipsToBounds = false
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(underlineView)
    }
    
    func setUpConstraints() {

        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
     
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(categoryNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
    }

    
    func fill(with item: CategoryModel, isSelected: Bool) {
        categoryNameLabel.text = item.categoryName
        underlineView.isHidden = !isSelected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
