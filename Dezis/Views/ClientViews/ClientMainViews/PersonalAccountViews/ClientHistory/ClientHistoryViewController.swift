//
//  ClientHistoryViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 10/10/24.
//

import UIKit

protocol IClientHistoryViewController {
    func reloadData()
}

class ClientHistoryViewController: UIViewController, IClientHistoryViewController {
    
    private var presenter: IClientHistoryPresenter!


    private let firstOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Первая обработка:"
        label.font = UIFont(name: "SFProText-Regular", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    private let firstOrderView: FirstOrderView = {
        let view = FirstOrderView()
        view.isHidden = true
        return view
    }()
    
    private let allOrdersLabel: UILabel = {
        let label = UILabel()
        label.text = "Все обработки:"
        label.font = UIFont(name: "SFProText-Regular", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let ordersCollectionView: UICollectionView = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#1B2228")
        setupUI()
        setupNavBar()
        setupCollectionViewDelegates()
        
        presenter = ClientHistoryPresenter(view: self)
        presenter.fetchClientOrders()
        
    }
    
    private func configureFirstOrderView() {
        if let firstOrder = presenter.getFirstOrder() {
            firstOrderLabel.isHidden = false
            firstOrderView.isHidden = false
            firstOrderView.fill(with: firstOrder, userDetails: presenter.getUserDetails())
        } else {
            firstOrderLabel.isHidden = true
            firstOrderView.isHidden = true
        }
    }

    private func setupCollectionViewDelegates() {
        ordersCollectionView.dataSource = self
        ordersCollectionView.register(
            ClientHistoryCollectionViewCell.self,
            forCellWithReuseIdentifier: ClientHistoryCollectionViewCell.reuseId
        )
    }
    
    private func setupNavBar() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)

        let chevronImage = UIImage(resource: .shevron).withRenderingMode(.alwaysTemplate)
        let resizedChevron = UIGraphicsImageRenderer(size: CGSize(width: 8, height: 14)).image { _ in
            chevronImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 8, height: 14)))
        }
        backButton.setImage(resizedChevron, for: .normal)
        backButton.tintColor = .systemBlue

        backButton.semanticContentAttribute = .forceLeftToRight
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 5)
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -5)

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    private func setupUI() {
        
        view.addSubview(firstOrderLabel)
        if firstOrderLabel.isHidden {
            view.addSubview(allOrdersLabel)
            allOrdersLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.leading.equalToSuperview().offset(20)
            }
        } else {
            
            firstOrderLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.leading.equalToSuperview().offset(20)
            }
            
            view.addSubview(firstOrderView)
            firstOrderView.snp.makeConstraints { make in
                make.top.equalTo(firstOrderLabel.snp.bottom).offset(12)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(184)
            }
            
            view.addSubview(allOrdersLabel)
            allOrdersLabel.snp.makeConstraints { make in
                make.top.equalTo(firstOrderView.snp.bottom).offset(20)
                make.leading.equalToSuperview().offset(20)
            }
        }
        
        view.addSubview(ordersCollectionView)
        ordersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(allOrdersLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    
    func reloadData() {
        configureFirstOrderView()
        ordersCollectionView.reloadData()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ClientHistoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfClientOrders()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClientHistoryCollectionViewCell.reuseId, for: indexPath) as! ClientHistoryCollectionViewCell
        let order = presenter.clientOrderAt(indexPath.row)
        let userDetails = presenter.getUserDetails()
        
        cell.fill(with: order, userDetails: userDetails)
        
        return cell
    }
}

