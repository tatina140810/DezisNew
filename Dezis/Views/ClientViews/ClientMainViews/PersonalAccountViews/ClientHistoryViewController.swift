//
//  ClientHistoryViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 10/10/24.
//

import UIKit

class ClientHistoryViewController: UIViewController {
    
    private let firstOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Первая обработка:"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let allOrdersLabel: UILabel = {
        let label = UILabel()
        label.text = "Все обработки:"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#1B2228")
        setupUI()
        setupNavBar()
    
        ordersCollectionView.dataSource = self
        ordersCollectionView.register(
            OrdersCollectionViewCell.self,
            forCellWithReuseIdentifier: OrdersCollectionViewCell.reuseId
        )
    }
    
    private func setupNavBar(){
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupUI() {
        view.addSubview(firstOrderLabel)
        firstOrderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(115)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(allOrdersLabel)
        allOrdersLabel.snp.makeConstraints { make in
            make.top.equalTo(firstOrderLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(ordersCollectionView)
        ordersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(allOrdersLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ClientHistoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrdersCollectionViewCell.reuseId, for: indexPath) as! OrdersCollectionViewCell
        return cell
    }
}
