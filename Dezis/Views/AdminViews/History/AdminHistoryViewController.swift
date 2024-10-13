//
//  AdminHistoryViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 05/10/24.
//
import UIKit

struct CategoryModel {
    let categoryName: String
}

class AdminHistoryViewController: UIViewController {
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let ordersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 211)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private var categories: [CategoryModel] = [
        CategoryModel(categoryName: "Новые заказы"),
        CategoryModel(categoryName: "Завершенные")
    ]
    
    private var selectedCategoryIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#1B2228")
        setupUI()
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(
            CategoriesCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseId
        )
        
        ordersCollectionView.dataSource = self
        ordersCollectionView.register(
            OrdersCollectionViewCell.self,
            forCellWithReuseIdentifier: OrdersCollectionViewCell.reuseId
        )
    }
    
    private func setupUI() {
        view.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(71)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(ordersCollectionView)
        
        ordersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension AdminHistoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return categories.count
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseId, for: indexPath) as! CategoriesCollectionViewCell
            let isSelected = indexPath.row == selectedCategoryIndex
            cell.fill(with: categories[indexPath.row], isSelected: isSelected)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrdersCollectionViewCell.reuseId, for: indexPath) as! OrdersCollectionViewCell
            return cell
        }
    }
}

extension AdminHistoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            selectedCategoryIndex = indexPath.row
            print("selected category\(selectedCategoryIndex)")
            categoriesCollectionView.reloadData()
            ordersCollectionView.reloadData()
        }
    }
}
