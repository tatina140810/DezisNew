//
//  AdminHistoryViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 05/10/24.
//

import UIKit

protocol IAdminHistoryView {
    func reloadData()
    func updateCollectionViewVisibility(forCategory index: Int)
}

class AdminHistoryView: UIViewController, IAdminHistoryView {
    
    private var presenter: IAdminHistoryPresenter!
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 35)
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 240)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private let completedOrdersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 184)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private var selectedCategoryIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#1B2228")
        
        presenter = AdminHistoryPresenter(view: self)
        
        presenter?.fetchOrders()
        
        setupNavBar()
        setupUI()
        setupCollectionViewDelegates()
        
    }

    private func setupCollectionViewDelegates() {
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(
            CategoriesCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseId
        )
        
        ordersCollectionView.dataSource = self
        ordersCollectionView.delegate = self
        ordersCollectionView.register(
            OrdersCollectionViewCell.self,
            forCellWithReuseIdentifier: OrdersCollectionViewCell.reuseId
        )
        
        completedOrdersCollectionView.dataSource = self
        completedOrdersCollectionView.delegate = self
        completedOrdersCollectionView.register(
            CompletedOrdersCollectionViewCell.self,
            forCellWithReuseIdentifier: CompletedOrdersCollectionViewCell.reuseId
        )
        
        completedOrdersCollectionView.isHidden = true
    }

    private func setupUI() {
        view.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.clipsToBounds = false
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
        
        view.addSubview(completedOrdersCollectionView)
        
        completedOrdersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func setupNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.hidesBackButton = true
    }
    
    func reloadData() {
        categoriesCollectionView.reloadData()
        ordersCollectionView.reloadData()
        completedOrdersCollectionView.reloadData()
    }
    
    func updateCollectionViewVisibility(forCategory index: Int) {
        if index == 0 {
            ordersCollectionView.isHidden = false
            completedOrdersCollectionView.isHidden = true
        } else if index == 1 {
            ordersCollectionView.isHidden = true
            completedOrdersCollectionView.isHidden = false
        }
    }

}

extension AdminHistoryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return presenter.getCategories().count
        } else if collectionView == ordersCollectionView {
            return presenter.numberOfOrders()
        } else {
            return presenter.numberOfCompletedOrders()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseId, for: indexPath) as! CategoriesCollectionViewCell
            
            let category = presenter.getCategories()[indexPath.row]
            let isSelected = indexPath.row == selectedCategoryIndex
            
            cell.fill(with: category, isSelected: isSelected)
            return cell
            
        } else if collectionView == ordersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrdersCollectionViewCell.reuseId, for: indexPath) as! OrdersCollectionViewCell
            let order = presenter.orderAt(indexPath.row)
            let userDetails = presenter.userDetails(for: order.user)
            cell.fill(with: order, userDetails: userDetails)
            cell.onCompleteTapped = {
                self.completeOrder(for: indexPath)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompletedOrdersCollectionViewCell.reuseId, for: indexPath) as! CompletedOrdersCollectionViewCell
            let completedOrder = presenter.completedOrderAt(indexPath.row)
            let userDetails = presenter.userDetails(for: completedOrder.user)
            cell.fill(with: completedOrder, userDetails: userDetails)
            return cell
        }
    }
    private func completeOrder(for indexPath: IndexPath) {
        DispatchQueue.main.async {
            let sureAlert = SureAlertView()
            sureAlert.showAlert(on: self.view, message: "Заказ завершен?")
            
            sureAlert.onConfirm = {
                self.presenter.completeOrder(at: indexPath.row)
                let successAlert = CustomAlertView()
                successAlert.showAlert(on: self.view, withMessage: "Вы завершили заказ!", imageName: "check-circle")
            }
        }
    }
}

extension AdminHistoryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            presenter.didSelectCategory(at: indexPath.row)
            selectedCategoryIndex = indexPath.row
            print("Selected category: \(selectedCategoryIndex)")
            
            updateCollectionViewVisibility(forCategory: selectedCategoryIndex)
            
            categoriesCollectionView.reloadData()
            ordersCollectionView.reloadData()
            completedOrdersCollectionView.reloadData()
        }
    }
}
