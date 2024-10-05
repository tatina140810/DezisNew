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
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .init(hex: "#FFFFFF)")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(categoryNameLabel)
    }
    
    func setUpConstraints() {
        
        categoryNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func fill(with item: CategoryModel) {
        categoryNameLabel.text = item.categoryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
