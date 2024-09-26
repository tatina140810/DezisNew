//
//  AdminOrdersViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class AdminOrdersViewController: UIViewController {
    
    private let ordersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 362)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
        setupUI()
        ordersCollectionView.dataSource = self
        ordersCollectionView.register(
            OrdersCollectionViewCell.self,
            forCellWithReuseIdentifier: OrdersCollectionViewCell.reuseId
        )
    }
    
    private func setupNavigationItems(){
        navigationController?.navigationBar.backgroundColor = UIColor(hex: "#5191BA")
        navigationController?.navigationBar.tintColor = .white
        let leftButton = UIBarButtonItem(image: UIImage(resource: .image7), style: .plain, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func setupUI(){
        view.addSubview(ordersCollectionView)
        NSLayoutConstraint.activate(
            [
                ordersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                ordersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                ordersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                ordersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
    }
    
    @objc func leftButtonTapped() {
        print("Left button tapped")
    }
}

extension AdminOrdersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrdersCollectionViewCell.reuseId, for: indexPath) as! OrdersCollectionViewCell
        return cell
    }
}
