//
//  AdminRequestsViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 05/10/24.
//

import UIKit

protocol IAdminRequestView: AnyObject {
    func reloadData()
}

class AdminRequestsView: UIViewController, IAdminRequestView {
    
    private var presenter: IAdminRequestPresenter!
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Запросы для входа"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        view.textColor = .init(UIColor(hex: "#FFFFFF"))
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let requestsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 299)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
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
        setupCollectionViewDelegates()
        
        presenter = AdminRequestPresenter(view: self)
        presenter?.loadRequests()
    }
    
    private func setupCollectionViewDelegates() {
        requestsCollectionView.dataSource = self
        requestsCollectionView.register(
            RequestsCollectionViewCell.self,
            forCellWithReuseIdentifier: RequestsCollectionViewCell.reuseId
            )
        
    }
    
    private func setupUI(){
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(requestsCollectionView)
        
        requestsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func reloadData() {
        requestsCollectionView.reloadData()
    }
}

extension AdminRequestsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRequests()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestsCollectionViewCell.reuseId, for: indexPath) as! RequestsCollectionViewCell
            
        if let request = presenter.requestAt(indexPath.row), !request.is_confirmed {
                cell.fill(with: request)
                cell.onConfirmTapped = { [weak self] in
                    self?.confirmRequest(for: indexPath)
                }
            }
            
            cell.onDenyTapped = { self.denyRequest(for: indexPath) }
            
            return cell
        }
        
    private func confirmRequest(for indexPath: IndexPath) {
        DispatchQueue.main.async {
            let sureAlert = SureAlertView()
            sureAlert.showAlert(
                on: self.view,
                message: "Вы уверены, что хотите подтвердить запрос?",
                yesButtonText: "Подтвердить",
                noButtonText: "Отмена",
                yesButtonColor: UIColor(hex: "#0A84FF")
            )
            
            sureAlert.onConfirm = {
                self.presenter.confirmUser(at: indexPath.row) { [weak self] success in
                    guard let self = self else { return }
                    if success {
                        let successAlert = CustomAlertView()
                        successAlert.showAlert(on: self.view, withMessage: "Вы подтвердили запрос!", imageName: "check-circle")
                    }
                }
            }
        }
    }

    private func denyRequest(for indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let sureAlert = SureAlertView()
            sureAlert.showAlert(
                on: self.view,
                message: "Вы уверены, что хотите отклонить запрос?",
                yesButtonText: "Отклонить",
                noButtonText: "Отмена",
                yesButtonColor: UIColor(hex: "#FF0000")
            )
            
            sureAlert.onConfirm = {
                self.presenter.denyUser(at: indexPath.row) { success in
                    if success {
                        let successAlert = CustomAlertView()
                        successAlert.showAlert(on: self.view, withMessage: "Запрос отклонен!", imageName: "slash")
                    }
                }
            }
        }
    }
}
